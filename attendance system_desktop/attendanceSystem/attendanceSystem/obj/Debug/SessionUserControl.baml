   M S B A M L   `   `   `  ����K  GattendanceSystem, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null3clr-namespace:attendanceSystemattendanceSystem  5      )    #attendanceSystem.SessionUserControl   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      0localclr-namespace:attendanceSystem     5      $	��681��5   7   $	��568��6C     � 	Resources  5	      &   System.Windows.Controls.DataGrid �� 
TargetType   scheduleDataGridStyle �� Property �� Value��%  &	        �� 5
   
   "  6   .�5      ��  � �� �	#FFF0EEEE6+   �� 5       � �� �	#FF5351516+   �� 5       � �� 6,   Z� �� 5       � ��$ 2q�60   �� 5       �@ RowBackground �	#FFF0EEEE6.   �� 5        �@ AlternatingRowBackground �#E6E6FA69   �� 5        �@ HorizontalGridLinesBrush
 �����69   �� 5       �@ VerticalGridLinesBrush
 �����67   �� 5       � ��$ Century Gothic)�6+   �� 5       � ��$ 8(�6)   5      5      .��5      � .+�5   
   �� $��1q�6   $
��Left=�6%   $	��548��6@   $��	10,10,0,0q�6M   $	��Top=�6`   $	��661��6x   
������� �� CornerRadius$ 12��6�   ._�5        -   5          Name$ sessionsDataGrid��5      #��[  61      AutoGenerateColumns .  $��9q�6�   ��6|   Z�    Columns 5      0  *System.Windows.Controls.DataGridTextColumn  5      ,  &System.Windows.Controls.DataGridColumn   Header$ 	Reference��6)   	   Width5  /System.Windows.Controls.DataGridLengthConverter$
	 auto 6T   1  +System.Windows.Controls.DataGridBoundColumn
   Binding
 6<   �� *Ref+6T     5      $
 Name��6)   $	 * 6P   
 67   �� *Name+6P     5      $ 
Start Time��6)   $	 * 6[   
 6=   �� *	StartTime+6[     5      $ End Time��6)   $	 * 6W   
 6;   �� *	EndTime+6W     5       $
 Date��6)   $	 * 6P   
 67   �� *Date+6P   5"      5#      5%      5&      