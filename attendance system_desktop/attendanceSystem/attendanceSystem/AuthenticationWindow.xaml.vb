Option Strict On
Option Explicit On

Imports System.Net.Http
Imports System.Net.Http.Headers
Imports System.Runtime.Serialization
Imports System.Runtime.Serialization.Json
Imports System.IO
Imports System.Text
Imports System.Text.RegularExpressions
Imports Newtonsoft.Json

Public Class AuthenticationWindow


    Dim client As New HttpClient()
    Public Sub New()

        ' This call is required by the designer.
        InitializeComponent()
        client.BaseAddress = New Uri(apiUrl)
        client.DefaultRequestHeaders.Accept.Clear()
        client.DefaultRequestHeaders.Accept.Add(New MediaTypeWithQualityHeaderValue("application/json"))

    End Sub
    Private Async Sub signUpBtn_Click(sender As Object, e As RoutedEventArgs) Handles signUpBtn.Click
        Await SignUpAsync()
    End Sub

    Private Async Sub loginBtn_Click(sender As Object, e As RoutedEventArgs) Handles loginBtn.Click
        Await LoginAsync()
    End Sub

    Public Async Function LoginAsync() As Task
        'On récupère les informations de l'administrateur
        Dim email As String = emailTextBox.Text.Trim
        Dim password As String = passwordBox.Password

        'On vérifie que l'utilisateur a tapé les informations correctes
        If String.IsNullOrEmpty(email) Or String.IsNullOrEmpty(password) Then
            MsgBox("Please fill all the blank in the fields")
        Else
            'Préparer les données pour la requête
            Dim loginDAta = New With {
                .Email = email,
                .Password = password
            }

            Dim jsonData As String = JsonConvert.SerializeObject(loginDAta)
            Dim content As New StringContent(jsonData, Encoding.UTF8, "application/json")

            Try
                'Envoyer la requête POST vers l'API
                Dim response As HttpResponseMessage = Await client.PostAsync("/admin/signin", content)
                'On vérifie le statut de la réponse
                If response.IsSuccessStatusCode Then
                    Dim responseBody As String = Await response.Content.ReadAsStringAsync()
                    'Si l'API renvoie un JSON comprenant comprenant un tokon, un message, on peut désérialiser le JSON
                    Dim result As AdminResult = JsonConvert.DeserializeObject(Of AdminResult)(responseBody)
                    If result.Admin IsNot Nothing Then
                        GlobalVariables.Administrator = result.Admin
                        'on redirrige vers l'accueil de l'application
                        Dim mainWindow As New MainWindow
                        Me.Close()
                        mainWindow.Show()
                    Else
                        MessageBox.Show("Unable to interpret server response")
                    End If
                Else
                    'En cas d'erreur côté serveur
                    Dim errorContent As String = Await response.Content.ReadAsStringAsync()
                    MsgBox("Error: " & response.StatusCode & errorContent)
                End If
            Catch ex As Exception
                'Gestion des erreurs réseau, exceptions, etc.
                MsgBox("Exception:" & ex.Message)
            End Try
        End If
    End Function

    Public Async Function SignUpAsync() As Task
        'On récupère les informations de l'administrateur
        Dim firstName As String = firstNameTextBox.Text
        Dim lastName As String = lastNameTextBox.Text
        Dim email As String = emailTextBox1.Text
        Dim password As String = passwordBox1.Password
        'On vérifie qu'il n'y a pas de champs vides
        If String.IsNullOrEmpty(firstName) Or
            String.IsNullOrEmpty(lastName) Or
            String.IsNullOrEmpty(email) Or
            String.IsNullOrEmpty(password) Then
            MsgBox("Please enter correct informations in the fields")
        Else
            'On crée l'objet de requete
            Dim signUpData As New Admin With {
                .FirstName = firstName,
                .LastName = lastName,
                .Email = email,
                .Password = password
            }

            'sérialiser l'objet en JSON
            Dim jsonData As String = JsonConvert.SerializeObject(signUpData)
            Dim content As New StringContent(jsonData, Encoding.UTF8, "application/json")
            MsgBox(jsonData)

            Try
                'On envoie la requête vers /signup
                Dim response As HttpResponseMessage = Await client.PostAsync("/admin/signup", content)

                If response.IsSuccessStatusCode Then
                    'On analyse la réponse
                    Dim responseBody As String = Await response.Content.ReadAsStringAsync()
                    Dim result As SignUpResponse = DeserializeFromJson(Of SignUpResponse)(responseBody)

                    If result IsNot Nothing Then
                        MsgBox("Registration success:" & result.Message)
                        MsgBox("Go to the Log In panel to sign up ")
                    Else
                        MsgBox("Registration failed: " & result.Message)
                    End If
                Else
                    Dim errorContent As String = Await response.Content.ReadAsStringAsync()
                    MsgBox("Error : " & response.StatusCode.ToString() & " - " & errorContent)
                End If
            Catch ex As Exception
                MsgBox("Exception : " & ex.Message)
            End Try
        End If
    End Function
    Public Function CreateRef() As String
        Dim newRef As String
        'Récupérationd e la date et l'heure actuelle
        Dim now As DateTime = Date.Now
        'Extraction des composants nécessaires 
        Dim year As String = now.ToString("yyyy")
        Dim monthLetter As String = now.ToString("MMMM").Substring(0, 1).ToUpper()
        Dim day As String = now.ToString("dd")
        Dim minutesSinceMidnight As Integer = now.Hour * 60 + now.Minute

        'On  crée la référence à partir des éléments extraits
        newRef = $"User{minutesSinceMidnight}{year}{monthLetter}{day}"
        Return newRef
    End Function
    Private Function IsValidEmail(ByVal email As String) As Boolean
        Dim pattern As String = "^[^@\s]+@[^@\s]+\.[^@\s]+s"
        Return Regex.IsMatch(email, pattern)
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
'définition de la classe pour la requête de connexion
<DataContract>
Public Class LoginRequest
    <DataMember>
    Public Property Email As String
    <DataMember>
    Public Property Password As String
End Class

<DataContract>
Public Class SignUpResponse
    <DataMember>
    Public Property Message As String
    <DataMember>
    Public Property Success As Boolean
End Class
