Option Strict On
Option Explicit On

Imports MessagingToolkit.Barcode
Imports System.Net.Http
Imports System.Net.Http.Headers
Imports System.Runtime.Serialization
Imports System.Runtime.Serialization.Json
Imports Newtonsoft.Json
Imports System.IO
Imports System.Text
Imports System.Text.RegularExpressions

Public Class ScanWindow
    'Dim sessionRef As String
    Dim client As New HttpClient()
    Public Sub New()

        ' This call is required by the designer.
        InitializeComponent()
        client.BaseAddress = New Uri(apiUrl)
        client.DefaultRequestHeaders.Accept.Clear()
        client.DefaultRequestHeaders.Accept.Add(New MediaTypeWithQualityHeaderValue("application/json"))

        'sessionRef = GlobalVariables.CurrentSession.Ref
        GenerateQrCOde()
    End Sub

    Private Sub GenerateQrCOde()
        'On vérifie que la référence n'est pas vide
        If GlobalVariables.CurrentSession Is Nothing OrElse String.IsNullOrEmpty(GlobalVariables.CurrentSession.Ref) Then
            MessageBox.Show("La référence est vide, impossible de générer le QR Code.")
            Return
        End If

        Try
            'Récupérer l'adresse IP locale
            Dim localIP As String = GetLocalIPAddress()

            '*** ENCODE les données pour l'URL ***
            Dim encodedRef As String = Uri.EscapeDataString(GlobalVariables.CurrentSession.Ref)
            Dim encodedName As String = Uri.EscapeDataString(GlobalVariables.CurrentSession.Name)

            'Construire la chaîne de données pour le QR Code
            Dim qrCodeData As String = $"{localIP}|{encodedRef}|{encodedName}"

            'Création d'un encodeur de QR code
            Dim encoder As New BarcodeEncoder()

            'Génération du QR Code sous forme de Bitmap
            Dim qrCodeImage As WriteableBitmap = encoder.Encode(BarcodeFormat.QRCode, qrCodeData)

            'Conversion en BitmapSource pour affichage dans WPF
            imgQrCode.Source = qrCodeImage
            MsgBox("Données du QR Code : " & qrCodeData) ' Affiche pour débogage
        Catch ex As Exception
            MsgBox("Erreur lors de la génération du QR Code : " & ex.Message)
        End Try
    End Sub

    Private Async Sub generateBtn_Click_1(sender As Object, e As RoutedEventArgs) Handles generateBtn.Click
        'On vérifie que le mot de passe de la session est correct
        If passwordBox.Password = GlobalVariables.CurrentSession.Password Then
            ' Si oui on ferme la session
            'on fait une requête vers l'API pour modifier le state de la session
            'On crée l'objet de requete
            Dim sessionData As New Session With {
                .Ref = CurrentSession.Ref,
                .Name = CurrentSession.Name,
                .Password = CurrentSession.Password,
                .SessionDate = CurrentSession.SessionDate.ToString(),
                .StartTime = CurrentSession.StartTime.ToString(),
                .State = "Close"
            }

            'sérialiser l'objet en JSON
            Dim jsonData As String = JsonConvert.SerializeObject(sessionData)
            Dim content As New StringContent(jsonData, Encoding.UTF8, "application/json")

            Try
                'On envoie la requête vers /sessions/set-state
                Dim response As HttpResponseMessage = Await client.PutAsync("/session/set-state/{currentSession.Ref}", content)

                If response.IsSuccessStatusCode Then
                    'On analyse la réponse
                    Dim responseBody As String = Await response.Content.ReadAsStringAsync()
                    Dim result As SignUpResponse = JsonConvert.DeserializeObject(Of SignUpResponse)(responseBody)

                    If result IsNot Nothing AndAlso result.Success Then
                        MsgBox("Session closed successfully :" & result.Message)
                    Else
                        MsgBox("session close failed: " & result.Message)
                    End If
                Else
                    Dim errorContent As String = Await response.Content.ReadAsStringAsync()
                    MsgBox("Error : " & response.StatusCode.ToString() & " - " & errorContent)
                End If
            Catch ex As Exception
                MsgBox("Exception : " & ex.Message)
            End Try
            GlobalVariables.CurrentSession.Close()
            'On retourne à la page d'accueil
            Dim mainWindow As New MainWindow

            Me.Close()
        Else
            'Sinon on envoie u message à l'utilisateur
            MsgBox("Sorry! You don't have the right to close this session.")
        End If
    End Sub

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

