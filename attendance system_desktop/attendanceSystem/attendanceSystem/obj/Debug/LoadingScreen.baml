   M S B A M L   `   `   `  ����K  GattendanceSystem, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null3clr-namespace:attendanceSystemattendanceSystem  5   	   $    attendanceSystem.LoadingScreen   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   0localclr-namespace:attendanceSystem     5   	     � Title$  LoadingScreen��5   	   $	��193��6   $	��580��6,   ���	#FF22289E
������� � 
ResizeMode$ NoResize=�6b    � WindowStartupLocation$ CenterScreen=�6x    � WindowStyle$
 None=�6�    � Triggers 5	      :� 5
   
    :� RoutedEvent$ Window.Loaded��6   .[�5      �� .��5      �� .��5      W�  �� 
TargetName$ labelTranslateTransform��6&    �� TargetProperty$ X�5   &    W� From$
 -200X�5   &   		 W� To$	 0X�5   &   
 g� Duration$
 0:0:1.5D�5   &    g� DecelerationRatio$	 0.5Q�5   &   W� 5      $ appTitle��6&   $ Opacity�5   &   $ 0X�5   &   $	 1X�5   &   $
 0:0:1.5D�5   &   5      5      5       � 	Resources 5       �� 
TargetType �� Property �� Value �� 
TargetType ��Name��%  '��       �� 5   
   " ��6   .�5       ��  � �� 6+   Z� �� 5!       � �� �#FFFFFF6+   �� 5"       � �� 6,   Z� �� 5#       � ��$ 0q�60   �� 5$       � ��$
 Left=�64   �� 5%       � ��$ 59��6'   �� 5&       � ��$ -1,-2,-1,-3q�6'   �� 5'       � ��$	 442��6&   �� 5(       � ��$	 422��6&   �� 5)       � ��$ Century Gothic)�6+   �� 5*       � ��$ 18(�6)   �� 5+       � ��$
 Bold"�6+   �� 5,       �@�Cursor$
 Hand��6'   �� 5-       � �� 5.      �� 5/      " ��6&   .R�50      �� $ border��6!   #��z��61   #��z��51   !   #��z��52   !   ._�53      �� $��Center=�6/   $��Center=�6L   54      55      57      58      59      .��5:      � .+�5;   
   �� -   5         ��Name$ appTitle��5;      $��	Smart ATS��6"   $
��Left=�66   $��
199,54,0,0q�6Q   $	��Top=�6e   $��Century Gothic)�6}   $
��Bold"�6�   $��36(�6�   
�������z�5<      T� 5=      -   5        labelTranslateTransform�� T� X$
 -200Q�5=   F   5?      �� 5@   
   -   5         ��Name$ button��5@      $��Get In��6!   #��[B��62   $
��Left=�6[   $��413,139,0,0q�6v   $	��Top=�6�   $	��120��6�   $��35��6�   
����������	#FF22289E$��Century Gothic)�6�   $��16(�6   � ToolTip$$ Click to enter the application��6&  ��6�   Z� 6&  5B      5C      