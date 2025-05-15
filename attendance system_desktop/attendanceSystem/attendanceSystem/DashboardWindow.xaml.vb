Public Class DashboardWindow
    'Classe pour représenter un élément du menu
    Public Class MenuItem
        Public Property Name As String
        Public Property View As UserControl
    End Class
    'Liste des éléments du menu
    Private MenuItems As New List(Of MenuItem)

    Public Sub New()

        ' This call is required by the designer.
        InitializeComponent()

        'Liaison de la liste au ListView
        MenuList.ItemsSource = MenuItems

        ' Ajout des éléments du menu.
        MenuItems.Add(New MenuItem With {.Name = "Home", .View = New DashboardHome()})
        MenuItems.Add(New MenuItem With {.Name = "Sessions", .View = New SessionUserControl()})
        MenuItems.Add(New MenuItem With {.Name = "Participants", .View = New ParticipantsUserControl()})
        MenuItems.Add(New MenuItem With {.Name = "Users", .View = New UsersControl()})
        MenuItems.Add(New MenuItem With {.Name = "Admins", .View = New adminControl()})


    End Sub

    'Gestion de la sélection dans le ListView
    Private Sub MenuList_SelectionChanged(sender As Object, e As SelectionChangedEventArgs)
        If MenuList.SelectedItem IsNot Nothing Then
            'Récupérer l'élément sélectionné
            Dim selectedItem = CType(MenuList.SelectedItem, MenuItem)

            'Afficher la vue correspondante dans le ContentControl
            MainContent.Content = selectedItem.View
        End If
    End Sub

    Private Sub BackBtn_Click(sender As Object, e As RoutedEventArgs) Handles BackBtn.Click
        Dim mainWindow As New MainWindow

        Me.Close()
        mainWindow.Show()
    End Sub
End Class
