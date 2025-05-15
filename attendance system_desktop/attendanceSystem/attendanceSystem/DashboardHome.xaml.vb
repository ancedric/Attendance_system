Option Strict On
Option Explicit On

Imports LiveCharts
Imports LiveCharts.Wpf
Imports System.Net.Http
Imports System.Net.Http.Headers
Imports System.Runtime.Serialization
Imports System.Runtime.Serialization.Json
Imports Newtonsoft.Json
Imports System.IO
Imports System.Text
Imports System.Text.RegularExpressions

Public Class DashboardHome
    Public Property SeriesCollection As SeriesCollection
    Public Property Labels As List(Of String)

    Dim selectedSession As String = String.Empty
    Dim nbParticipants As Integer = 0
    Dim participants As New ChartValues(Of Integer)()
    Dim nbSessions As Integer = 0
    Dim client As HttpClient

    Public Sub New()
        InitializeComponent()

        ' Initialisation du client HTTP
        client = CreateHttpClient()

        ' Initialisation des collections
        SeriesCollection = New SeriesCollection()
        Labels = New List(Of String)()

        ' Configuration initiale du graphique
        Dim columnSeries = New ColumnSeries() With {
            .Title = "Valeurs",
            .Values = participants,
            .Fill = Brushes.Blue
        }
        SeriesCollection.Add(columnSeries)

        DataContext = Me
        AddHandler Me.Loaded, AddressOf OnWindowLoaded
    End Sub

    Private Async Sub OnWindowLoaded(sender As Object, e As RoutedEventArgs)
        Try
            ' Chargement initial des données
            Await LoadInitialData()
        Catch ex As Exception
            Debug.WriteLine($"Error in OnWindowLoaded: {ex.Message}")
        End Try
    End Sub

    Private Async Function LoadInitialData() As Task
        ' Chargement des titres de session en premier
        Dim sessionsTitle As List(Of String) = Await GetSessionTitlesAsync()

        If sessionsTitle?.Any() Then
            ' Initialiser la combo box
            sessionsComboBox.Items.Clear()
            For Each title As String In sessionsTitle
                sessionsComboBox.Items.Add(title)
            Next

            ' Sélectionner le premier élément si disponible
            If sessionsComboBox.Items.Count > 0 Then
                sessionsComboBox.SelectedIndex = 0
                selectedSession = sessionsComboBox.SelectedItem.ToString()
            End If
        End If

        ' Charger les autres données
        Dim sessions As List(Of Session) = Await GetSessionsAsync()
        Dim schedules As List(Of Schedule) = Await GetSchedulesAsync()

        nbParticipants = Await GetUsersNumber()
        nbSessions = If(sessions IsNot Nothing, sessions.Count, 0)

        ' Mettre à jour l'UI
        nbParticipantsLabel.Content = nbParticipants.ToString()
        nbSessionsLabel.Content = nbSessions.ToString()

        If sessions IsNot Nothing Then
            sessionsDataGrid.ItemsSource = sessions
        End If

        If schedules IsNot Nothing Then
            scheduleDataGrid.ItemsSource = schedules
        End If

        ' Calculer le taux de présence si une session est sélectionnée
        If Not String.IsNullOrEmpty(selectedSession) Then
            Dim ratio As Double = Await calculateAttendanceRatio(selectedSession)
            attendance_rate_label.Content = ratio.ToString("P")
        End If
    End Function

    Private Function CreateHttpClient() As HttpClient
        Dim client = New HttpClient() With {
        .BaseAddress = New Uri(apiUrl)
    }
        ConfigureHttpClientHeaders(client)
        Return client
    End Function

    Private Sub ConfigureHttpClientHeaders(ByVal client As HttpClient)
        client.DefaultRequestHeaders.Accept.Clear()
        client.DefaultRequestHeaders.Accept.Add(New MediaTypeWithQualityHeaderValue("application/json"))
        ' Vous pouvez ajouter d'autres en-têtes ici si nécessaire
    End Sub

    Private Async Function GetSessionsAsync() As Task(Of List(Of Session))
        Try
            Dim response As HttpResponseMessage = Await client.GetAsync("/session/get-latest-sessions")
            If response.IsSuccessStatusCode Then
                Dim jsonResponse As String = Await response.Content.ReadAsStringAsync()

                ' Essayez d'abord de désérialiser comme un tableau
                Try
                    Return JsonConvert.DeserializeObject(Of List(Of Session))(jsonResponse)
                Catch ex As JsonSerializationException
                    ' Si échec, essayez comme un objet unique
                    Dim singleSession As Session = JsonConvert.DeserializeObject(Of Session)(jsonResponse)
                    Return New List(Of Session) From {singleSession}
                End Try
            Else
                Debug.WriteLine($"Error: {response.StatusCode}")
            End If
        Catch ex As Exception
            Debug.WriteLine($"Exception: {ex.Message}")
        End Try
        Return New List(Of Session)()
    End Function

    Private Async Function GetSchedulesAsync() As Task(Of List(Of Schedule))
        Try
            Dim response As HttpResponseMessage = Await client.GetAsync("/schedule/last-five")

            If response.IsSuccessStatusCode Then
                Dim jsonResponse As String = Await response.Content.ReadAsStringAsync()

                If String.IsNullOrWhiteSpace(jsonResponse) Then
                    Return New List(Of Schedule)()
                End If

                Try
                    Dim deserialized = JsonConvert.DeserializeObject(Of List(Of Schedule))(jsonResponse)
                    Return If(deserialized IsNot Nothing, deserialized, New List(Of Schedule)())
                Catch ex As JsonSerializationException
                    ' Essayez de désérialiser comme un objet unique
                    Try
                        Dim singleItem = JsonConvert.DeserializeObject(Of Schedule)(jsonResponse)
                        Return New List(Of Schedule) From {singleItem}
                    Catch innerEx As Exception
                        Debug.WriteLine($"Error deserializing single schedule: {innerEx.Message}")
                        Return New List(Of Schedule)()
                    End Try
                Catch ex As Exception
                    Debug.WriteLine($"Error deserializing schedules: {ex.Message}")
                    Return New List(Of Schedule)()
                End Try
            Else
                Debug.WriteLine($"API Error: {response.StatusCode} - {response.ReasonPhrase}")
                Return New List(Of Schedule)()
            End If
        Catch ex As Exception
            Debug.WriteLine($"Exception in GetSchedulesAsync: {ex.Message}")
            Return New List(Of Schedule)()
        End Try
    End Function

    Private Async Function GetUsersAsync() As Task(Of List(Of User))
        Dim users As New List(Of User)
        'Envoie de la requête pour récupérer les sessions
        Dim response As HttpResponseMessage = Await client.GetAsync("/user/get-users")
        If response.IsSuccessStatusCode Then
            Dim jsonResponse As String = Await response.Content.ReadAsStringAsync()
            Try
                'Deserialisation du tableau json en liste d'objets SessionType
                Dim fetchedUser As List(Of User) = JsonConvert.DeserializeObject(Of List(Of User))(jsonResponse)
                'on extrait les titres dans les sessions
                For Each u As User In fetchedUser
                    users.Add(u)
                Next
            Catch ex As Exception
                MsgBox("Error while deserialising JSON: " & ex.Message)
            End Try
        Else
            MsgBox("Error while getting users")
        End If
        Return users
    End Function

    'Fonction pour récupérer les participants d'une session
    Private Async Function GetParticipantsAsync(sessionRef As String) As Task(Of Integer)
        Dim participants As Integer
        'Envoie de la requête pour récupérer les sessions
        Dim response As HttpResponseMessage = Await client.GetAsync("/session/get-participant-number/{sessionRef}")
        If response.IsSuccessStatusCode Then
            Dim jsonResponse As String = Await response.Content.ReadAsStringAsync()
            Try
                'Deserialisation du tableau json en liste d'objets SessionType
                Dim fetchedParticipants As Integer = JsonConvert.DeserializeObject(Of Integer)(jsonResponse)
                'on extrait le nombre de participants dans la session
                If fetchedParticipants >= 0 Then
                    participants = fetchedParticipants
                End If
            Catch ex As Exception
                MsgBox("Error while deserialising JSON: " & ex.Message)
            End Try
        Else
            MsgBox("Error while getting participants")
        End If
        Return participants
    End Function

    Private Async Function GetSessionTitlesAsync() As Task(Of List(Of String))
        Dim sessionTitles As New List(Of String)
        'Envoie de la requête pour récupérer les sessions
        Dim response As HttpResponseMessage = Await client.GetAsync("/session/get-sessionTypes")
        If response.IsSuccessStatusCode Then
            Dim jsonResponse As String = Await response.Content.ReadAsStringAsync()
            Try
                'Deserialisation du tableau json en liste d'objets SessionType
                Dim sessions As List(Of SessionType) = JsonConvert.DeserializeObject(Of List(Of SessionType))(jsonResponse)
                'on extrait les titres dans les sessions
                For Each s As SessionType In sessions
                    sessionTitles.Add(s.TypeName)
                Next
            Catch ex As Exception
                MsgBox("Error while deserialising JSON: " & ex.Message)
            End Try

        Else
            MsgBox("Error while getting session types: " & response.StatusCode.ToString())
        End If
        Return sessionTitles
    End Function

    Private Async Function GetSessionDatesAsync(session As String) As Task(Of List(Of String))
        Dim sessionDates As New List(Of String)
        'Envoie de la requête pour récupérer les sessions
        Dim response As HttpResponseMessage = Await client.GetAsync("/session/get-session-name/{session}")
        If response.IsSuccessStatusCode Then
            Dim jsonResponse As String = Await response.Content.ReadAsStringAsync()
            Try
                'Deserialisation du tableau json en liste d'objets SessionType
                Dim fetchedSessions As List(Of Session) = JsonConvert.DeserializeObject(Of List(Of Session))(jsonResponse)
                'on extrait les titres dans les sessions
                For Each s As Session In fetchedSessions
                    sessionDates.Add(s.SessionDate)
                Next
            Catch ex As Exception
                MsgBox("Error while deserialising JSON: " & ex.Message)
            End Try
        Else
            MsgBox("Error while getting sessions' dates")
        End If
        Return sessionDates
    End Function


    Private Async Function GetUsersNumber() As Task(Of Integer)
        Dim users As List(Of User) = Await GetUsersAsync()
        Dim nbUsers = users.Count

        Return nbUsers
    End Function

    'Private Async Function FetchUsers() As

    Private Async Function GetSessionsNumber() As Task(Of Integer)
        Dim sessions As List(Of Session) = Await GetSessionsAsync()
        Dim nbSessions = sessions.Count

        Return nbSessions
    End Function

    Private Async Function calculateAttendanceRatio(session As String) As Task(Of Double)
        Dim totalParticipants As Integer = 0
        Dim totalUser As Integer = Await GetUsersNumber()
        Dim participantsList As New ChartValues(Of Integer)
        Dim ratio As Double = 0.0
        'On récupère toutes les sessions qui ont le titre séléctionné dans une liste
        Dim sessions As New List(Of Session)
        'Envoie de la requête pour récupérer les sessions
        Dim response As HttpResponseMessage = Await client.GetAsync("/session/get-session-name/{session}")
        If response.IsSuccessStatusCode Then
            Dim jsonResponse As String = Await response.Content.ReadAsStringAsync()
            Try
                'Deserialisation du tableau json en liste d'objets SessionType
                Dim fetchedSessions As List(Of Session) = JsonConvert.DeserializeObject(Of List(Of Session))(jsonResponse)
                'on extrait les titres dans les sessions
                For Each s As Session In fetchedSessions
                    participantsList.Add(s.NbParticipants)
                    totalParticipants += s.NbParticipants
                Next
            Catch ex As Exception
                MsgBox("Error while deserialising JSON: " & ex.Message)
            End Try
            ratio = totalParticipants / totalUser
            participants = participantsList
        Else
            MsgBox("Error while getting sessions")
        End If
        Return ratio
    End Function


End Class
