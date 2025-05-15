Option Strict On
Option Explicit On

Imports System.Net.Http
Imports System.Net.Http.Headers
Imports System.Threading.Tasks
Imports System.Runtime.Serialization
Imports System.Runtime.Serialization.Json
Imports Newtonsoft.Json
Imports System.Net
Imports System.Net.Sockets

Module GlobalVariables

    Public apiUrl As String = "http://127.0.0.1:8082"
    Public CurrentSession As New Session With {
        .Ref = "",
        .Name = "",
        .Password = "",
        .SessionDate = "",
        .StartTime = "",
        .NbParticipants = 0,
        .State = "close"
    }
    Public Administrator As New Admin With {
        .AdminRef = "",
        .FirstName = "",
        .LastName = "",
        .Password = "",
        .Email = "",
        .Privilege = "admin"
    }

    Public AdminUsers As New List(Of Admin) From {
        New Admin With {.AdminRef = "1235", .FirstName = "Cédric", .LastName = "Ananga", .Email = "ancedric55@gmail.com", .Password = "123456", .Privilege = "superadmin"},
        New Admin With {.AdminRef = "12348", .FirstName = "Liliane", .LastName = "Ndobo", .Email = "claudepu@email.com", .Password = "egsv49", .Privilege = "admin"}
        }

    <DataContract>
    Public Class Session
        <DataMember>
        Public Property Ref As String
        <DataMember>
        Public Property Name As String
        <DataMember>
        Public Property Password As String
        <DataMember>
        Public Property SessionDate As String
        <DataMember>
        Public Property StartTime As String
        <DataMember>
        Public Property NbParticipants As Integer
        <DataMember>
        Public Property State As String


        Public Sub Start()
            'On initialise la nombre de participants à 0
            NbParticipants = 0
            'On récupère la date et l'heure actuelle
            Dim currentDateTime As Date = Date.Now
            'On récupère l'heure de démarrage de la session
            StartTime = currentDateTime.Hour.ToString("hh:mm")
            'On récupère la date de la session
            SessionDate = currentDateTime.Date.ToString("dd/MM/yyyy")
            'On modifie l'état de la session à "open"
            State = "open"
        End Sub
        Public Async Sub Close()
            'on réinitialise tous les attributs
            Ref = ""
            Name = ""
            Password = ""
            StartTime = ""
            SessionDate = ""
            State = "close"
        End Sub

    End Class

    Public Class SessionType
        <JsonProperty("typeRef")>
        Public Property TypeRef As String
        <JsonProperty("TypeName")>
        Public Property TypeName As String
    End Class

    'LA classe pour les utilisateurs
    Public Class User
        Public Property UserRef As Integer
        Public Property FirstName As String
        Public Property LastName As String
        Public Property Email As String
        Public Property Password As String
    End Class

    Public Class AdminResult
        Public Property message As String
        Public Property Admin As Admin
    End Class
    'La classe pour les administrateurs
    <DataContract>
    Public Class Admin
        <DataMember>
        Public Property AdminRef As String
        <DataMember>
        Public Property FirstName As String
        <DataMember>
        Public Property LastName As String
        <DataMember>
        Public Property Email As String
        <DataMember>
        Public Property Password As String
        <DataMember>
        Public Property Privilege As String
    End Class

    'Classe pour représenter les programmations
    Public Class Schedule
        Public Property SchedRef As String
        Public Property sessionRef As String
        Public Property SessionName As String
        Public Property SessionDate As String
        Public Property SessionStart As String
    End Class

    'Classe pour les participants
    Public Class Participant
        Public Property PartRef As String
        Public Property UserRef As String
        Public Property SessionREf As String
        Public Property ComingTime As String
        Public Property QuitTime As String
    End Class

    Public Function GetLocalIPAddress() As String
        Dim host As IPHostEntry = Dns.GetHostEntry(Dns.GetHostName())
        For Each ip As IPAddress In host.AddressList
            If ip.AddressFamily = AddressFamily.InterNetwork Then
                Return ip.ToString()
            End If
        Next
        Return "" ' Retourne une chaîne vide en cas d'erreur
    End Function

End Module
