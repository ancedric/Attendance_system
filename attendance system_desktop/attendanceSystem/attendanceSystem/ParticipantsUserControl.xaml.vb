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


Public Class ParticipantsUserControl
    Dim client As New HttpClient()
    Dim participantsList As New List(Of Participant)
    Public Sub New()

        ' This call is required by the designer.
        InitializeComponent()
        client.BaseAddress = New Uri(apiUrl)
        client.DefaultRequestHeaders.Accept.Clear()
        client.DefaultRequestHeaders.Accept.Add(New MediaTypeWithQualityHeaderValue("application/json"))

        AddHandler Me.Loaded, AddressOf OnWindowLoaded
    End Sub

    Private Async Sub OnWindowLoaded(sender As Object, e As RoutedEventArgs)
        participantsList = Await GetParticipantsAsync()
        'Liaison des données au sessionsDataGrid
        sessionsDataGrid.ItemsSource = participantsList

    End Sub

    Private Async Function GetParticipantsAsync() As Task(Of List(Of Participant))
        Dim participants As New List(Of Participant)
        'Envoie de la requête pour récupérer les sessions
        Dim response As HttpResponseMessage = Await client.GetAsync("/participants/get-paarticipants")
        If response.IsSuccessStatusCode Then
            Dim jsonResponse As String = Await response.Content.ReadAsStringAsync()
            Try
                'Deserialisation du tableau json en liste d'objets SessionType
                Dim fetchedParticipants As List(Of Participant) = JsonConvert.DeserializeObject(Of List(Of Participant))(jsonResponse)
                'on extrait les titres dans les sessions
                For Each p As Participant In fetchedParticipants
                    participants.Add(p)
                Next
            Catch ex As Exception
                MsgBox("Error while deserialising JSON: " & ex.Message)
            End Try
        Else
            MsgBox("Error while getting sessions")
        End If
        Return participants
    End Function
End Class
