   M S B A M L   `   `   `  ����K  GattendanceSystem, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null3clr-namespace:attendanceSystemattendanceSystem  5      #    attendanceSystem.adminControl   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      0localclr-namespace:attendanceSystem     5      $	��681��5   7   $	��568��6C     � 	Resources  5	      &   System.Windows.Controls.DataGrid �� 
TargetType   scheduleDataGridStyle �� Property �� Value��%  &	        �� 5
   
   "  6   .�5      ��  � �� �	#FFF0EEEE6+   �� 5       � �� �	#FF5351516+   �� 5       � �� 6,   Z� �� 5       � ��$ 2q�60   �� 5       �@ RowBackground �	#FFF0EEEE6.   �� 5        �@ AlternatingRowBackground �#E6E6FA69   �� 5        �@ HorizontalGridLinesBrush
 �����69   �� 5       �@ VerticalGridLinesBrush
 �����67   �� 5       � ��$ Century Gothic)�6+   �� 5       � ��$ 8(�6)   5      5      .��5      � .+�5   
   �� $��1q�6   $
��Left=�6%   $	��548��6@   $��	10,10,0,0q�6M   $	��Top=�6`   $	��661��6x   
������� �� CornerRadius$ 12��6�   ._�5        -   5          Name$ adminDataGrid��5      #��[  6.      AutoGenerateColumns .  $��9q�6�   ��6y   Z�    Columns 5      0  *System.Windows.Controls.DataGridTextColumn  5      ,  &System.Windows.Controls.DataGridColumn   Header$ 	Admin Ref��6)   	   Width5  /System.Windows.Controls.DataGridLengthConverter$
	 auto 6Y   1  +System.Windows.Controls.DataGridBoundColumn
   Binding
 6<   �� *
AdminRef+6Y     5      $ 
First Name��6)   $	 * 6[   
 6=   �� *	FirstName+6[     5      $ 	Last Name��6)   $	 * 6Y   
 6<   �� *
LastName+6Y     5      $ Email��6)   $	 * 6R   
 68   �� *Email+6R     5       $ Password��6)   $	 * 6X   
 6;   �� *
Password+6X     5!      $ 	Privilege��6)   $	 * 6Z   
 6<   �� *	Privilege+6Z   5#      5$      5&      5'      