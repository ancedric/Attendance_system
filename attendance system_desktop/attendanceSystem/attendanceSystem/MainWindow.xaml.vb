Option Strict On
Option Explicit On

Imports System.Net.Http
Imports System.Net.Http.Headers
Imports System.Runtime.Serialization
Imports System.Runtime.Serialization.Json
Imports Newtonsoft.Json
Imports System.IO
Imports System.Text
Imports System.Text.RegularExpressions

Class MainWindow
    Dim selectedSession As String
    Dim sessionPassword As String
    Dim refSession As String
    Dim createdSession As Session
    Dim currentAdmin As Admin

    Dim client As New HttpClient()
    Public Sub New()
        ' This call is required by the designer.
        InitializeComponent()
        client.BaseAddress = New Uri(apiUrl)
        client.DefaultRequestHeaders.Accept.Clear()
        client.DefaultRequestHeaders.Accept.Add(New MediaTypeWithQualityHeaderValue("application/json"))

        'Affichage du nom de l'administrateur dans l'en-tête
        adminNameLabel.Content = Administrator.FirstName & " " & Administrator.LastName

        AddHandler Me.Loaded, AddressOf OnWindowLoaded
    End Sub
    Private Async Sub OnWindowLoaded(sender As Object, e As RoutedEventArgs)
        'Définition des éléments de la sessionsComboBox
        Dim sessions As List(Of String) = Await GetSessionTitlesAsync()
        'Liaison des sessions au sessionsComboBox
        'sessionsComboBox.ItemsSource = sessions
        sessionsComboBox.Items.Clear()
        For Each title As String In sessions
            sessionsComboBox.Items.Add(title)
        Next
    End Sub
    Private Function GenerateRef() As String
        'Récupérationd e la date et l'heure actuelle
        Dim now As DateTime = Date.Now
        'Extraction des composants nécessaires
        Dim year As String = now.ToString("yyyy")
        Dim monthLetter As String = now.ToString("MMMM").Substring(0, 1).ToUpper()
        Dim day As String = now.ToString("dd")
        Dim minutesSinceMidnight As Integer = now.Hour * 60 + now.Minute

        'Construction de la référence à partir des éléments de la date
        Dim eventRef As String = $"{year}{monthLetter}{day}{minutesSinceMidnight}"
        'On enregistre la nouvelle référence créée
        Return eventRef
    End Function
    Private Function CreateSession() As Session
        Dim newSession As New Session With {
            .Ref = refSession,
            .Name = selectedSession,
            .Password = sessionPassword,
            .SessionDate = Date.Now.ToString("dd/MMMM/yyyy"),
            .StartTime = Date.Now.Hour.ToString(),
            .NbParticipants = 0,
            .State = "close"
        }
        Return newSession
    End Function
    Private Async Sub startBtn_Click(sender As Object, e As RoutedEventArgs) Handles startBtn.Click
        'Récupération de la session sélectionnée
        selectedSession = CType(sessionsComboBox.SelectedValue, String)
        'Récupération du mot de passe de la session
        sessionPassword = passwordBox.Password
        'Générer la reférence de la session
        refSession = GenerateRef()
        'Créer la session
        createdSession = CreateSession()  ' Call CreateSession *before* updating GlobalVariables
        'Modifier la session globale avec les données de la session créée
        If createdSession IsNot Nothing Then
            GlobalVariables.CurrentSession = createdSession ' *Now* update CurrentSession
            'Démarrer la session
            GlobalVariables.CurrentSession.Start()
        Else
            MsgBox("Session cannot be Empty")
            Return ' Important: Exit the method if the session is invalid
        End If

        'Faire la requête vers l'API pour enregistrer la nouvelle session créée.
        'On vérifie qu'il n'y a pas de champs vides
        If String.IsNullOrEmpty(sessionPassword) Then
            MsgBox("Please! You should provide a passwordto create a new session.")
        Else
            Dim d As New Date
            'On crée l'objet de requete
            Dim sessionData As New Session With {
                .Ref = refSession,
                .Name = selectedSession,
                .Password = sessionPassword,
                .SessionDate = Date.Now.ToString("dd/MMMM/yyyy"),
                .StartTime = Date.Now.Hour.ToString(),
                .NbParticipants = 0,
                .State = "open"
            }

            'sérialiser l'objet en JSON
            Dim jsonData As String = JsonConvert.SerializeObject(sessionData)
            Dim content As New StringContent(jsonData, Encoding.UTF8, "application/json")

            Try
                'On envoie la requête vers /sessions/add-sessions
                Dim response As HttpResponseMessage = Await client.PostAsync("/session/add-session", content)

                If response.IsSuccessStatusCode Then
                    'On analyse la réponse
                    Dim responseBody As String = Await response.Content.ReadAsStringAsync()
                    Dim result As SignUpResponse = JsonConvert.DeserializeObject(Of SignUpResponse)(responseBody)

                    If result IsNot Nothing AndAlso result.Success Then
                        Dim scanWd As New ScanWindow
                        scanWd.Show()
                    Else
                        Dim scanWd As New ScanWindow
                        scanWd.Show()
                    End If
                Else
                    Dim errorContent As String = Await response.Content.ReadAsStringAsync()
                    MsgBox("Error : " & response.StatusCode.ToString() & " - " & errorContent)
                End If
            Catch ex As Exception
                MsgBox("Exception : " & ex.Message)
            End Try
        End If
    End Sub

    Private Sub adminBtn_Click(sender As Object, e As RoutedEventArgs) Handles adminBtn.Click
        VerifyPrivilege(GlobalVariables.Administrator.Privilege)
    End Sub

    Public Sub VerifyPrivilege(privilege As String)
        If (privilege = "superadmin") Then
            Dim admin As New DashboardWindow

            Me.Close()
            admin.Show()
        Else
            MsgBox("Sorry! You don't have authorization to open this page.")
        End If
    End Sub

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

    Private Function SerializeToJson(Of T)(ByVal obj As T) As String
        Dim Serializer As New DataContractJsonSerializer(GetType(T))
        Using ms As New MemoryStream()
            Serializer.WriteObject(ms, obj)
            Return Encoding.UTF8.GetString(ms.ToArray())
        End Using
    End Function

    Private Function DeserializeFromJson(Of T)(ByVal json As String) As T
        Dim serializer As New DataContractJsonSerializer(GetType(T))
        Using ms As New MemoryStream(Encoding.UTF8.GetBytes(json))
            Return CType(serializer.ReadObject(ms), T)
        End Using
    End Function
End Class
