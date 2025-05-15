Public Class LoadingScreen
    Private Sub button_Click(sender As Object, e As RoutedEventArgs) Handles button.Click
        Dim auth As New AuthenticationWindow

        Me.Close()
        auth.Show()
    End Sub
End Class
