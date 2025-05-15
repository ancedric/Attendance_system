Option Strict On
Option Explicit On

Imports System.Net.Http
Imports System.Net.Http.Headers
Imports System.Runtime.Serialization
Imports System.Runtime.Serialization.Json
Imports System.IO
Imports System.Text
Imports Newtonsoft.Json
Imports System.Text.RegularExpressions
Public Class adminControl
    Dim client As New HttpClient()
    Dim adminsList As New List(Of Admin)
    Public Sub New()

        ' This call is required by the designer.
        InitializeComponent()
        client.BaseAddress = New Uri(apiUrl)
        client.DefaultRequestHeaders.Accept.Clear()
        client.DefaultRequestHeaders.Accept.Add(New MediaTypeWithQualityHeaderValue("application/json"))

        AddHandler Me.Loaded, AddressOf OnWindowLoaded
    End Sub

    Private Async Sub OnWindowLoaded(sender As Object, e As RoutedEventArgs)
        adminsList = Await GetAdminsAsync()
        'Liaison des données au sessionsDataGrid
        adminDataGrid.ItemsSource = adminsList

    End Sub

    Private Async Function GetAdminsAsync() As Task(Of List(Of Admin))
        Dim admins As New List(Of Admin)
        'Envoie de la requête pour récupérer les sessions
        Dim response As HttpResponseMessage = Await client.GetAsync("/user/get-admins")
        If response.IsSuccessStatusCode Then
            Dim jsonResponse As String = Await response.Content.ReadAsStringAsync()
            Try
                'Deserialisation du tableau json en liste d'objets SessionType
                Dim fetchedadmin As List(Of Admin) = JsonConvert.DeserializeObject(Of List(Of Admin))(jsonResponse)
                'on extrait les titres dans les sessions
                For Each u As Admin In fetchedadmin
                    admins.Add(u)
                Next
            Catch ex As Exception
                MsgBox("Error while deserialising JSON: " & ex.Message)
            End Try
        Else
            MsgBox("Error while getting admins")
        End If
        Return admins
    End Function
End Class
