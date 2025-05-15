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
Public Class UsersControl
    Dim client As New HttpClient()
    Dim usersList As New List(Of User)
    Public Sub New()

        ' This call is required by the designer.
        InitializeComponent()
        client.BaseAddress = New Uri(apiUrl)
        client.DefaultRequestHeaders.Accept.Clear()
        client.DefaultRequestHeaders.Accept.Add(New MediaTypeWithQualityHeaderValue("application/json"))

        AddHandler Me.Loaded, AddressOf OnWindowLoaded
    End Sub

    Private Async Sub OnWindowLoaded(sender As Object, e As RoutedEventArgs)
        usersList = Await GetUsersAsync()
        'Liaison des données au sessionsDataGrid
        sessionsDataGrid.ItemsSource = usersList

    End Sub

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
End Class
