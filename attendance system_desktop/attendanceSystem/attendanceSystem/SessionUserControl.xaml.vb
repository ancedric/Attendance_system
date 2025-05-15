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

Public Class SessionUserControl

    Dim client As New HttpClient()
        Dim sessionsList As New List(Of Session)
        Public Sub New()

            ' This call is required by the designer.
            InitializeComponent()
            client.BaseAddress = New Uri(apiUrl)
            client.DefaultRequestHeaders.Accept.Clear()
        client.DefaultRequestHeaders.Accept.Add(New MediaTypeWithQualityHeaderValue("application/json"))

        AddHandler Me.Loaded, AddressOf OnWindowLoaded
        End Sub

        Private Async Sub OnWindowLoaded(sender As Object, e As RoutedEventArgs)
            sessionsList = Await GetSessionsAsync()
            'Liaison des données au sessionsDataGrid
            sessionsDataGrid.ItemsSource = sessionsList

        End Sub

    Private Async Function GetSessionsAsync() As Task(Of List(Of Session))
        Try
            Dim response As HttpResponseMessage = Await client.GetAsync("/session/get-sessions")
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
End Class
