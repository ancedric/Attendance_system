   M S B A M L   `   `   `  ����K  GattendanceSystem, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null3clr-namespace:attendanceSystemattendanceSystem  5   	   +    %attendanceSystem.AuthenticationWindow   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   0localclr-namespace:attendanceSystem     5   	     � Title$  Admin Authentication��5   	   $	��580��6&   $	��536��63    � WindowStartupLocation$ CenterScreen=�6?   ���	#FFCDCEDE � Triggers 5	      :� 5
   
    :� RoutedEvent$ Window.Loaded��6   .[�5      �� .��5      �� .��5      W�  �� 
TargetName$ labelTranslateTransform��6&    �� TargetProperty$ X�5   &    W� From$
 -200X�5   &   	 W� To$ 0X�5   &    g� Duration$ 0:0:1.5D�5   &   	 g� DecelerationRatio$		 0.5Q�5   &   W� 5      $ appTitle��6&   $ Opacity�5   &   $ 0X�5   &   $ 1X�5   &   $ 0:0:1.5D�5   &   5      5      5      
 � 	Resources
 5       �� 
TargetType �� Property �� Value �� 
TargetType ��Name   RoundedBorderStyle �� Triggers P� Property P� Value��%W  '��       &	  �    �� 5    
   " ��6   .�5!      ��  � �� 6+   Z� �� 5"       � �� �#FFFFFF6+   �� 5#       � �� 6,   Z� �� 5$       � ��$ 0q�60   �� 5%       � ��$
 Left=�64   �� 5&       � ��$ 59��6'   �� 5'       � ��$ -1,-2,-1,-3q�6'   �� 5(       � ��$	 442��6&   �� 5)       � ��$	 422��6&   �� 5*       � ��$ Century Gothic)�6+   �� 5+       � ��$ 18(�6)   �� 5,       � ��$
 Bold"�6+   �� 5-       �@�Cursor$
 Hand��6'   �� 5.       � �� 5/      �� 50      " ��6&   .R�51      �� $ border��6!   #��z��61   #��z��52   !   #��z��53   !   ._�54      �� $��Center=�6/   $��Center=�6L   55      56      58      59      �� 5;   
   " ��6   .�5<      ��  �@��Padding$ 10q�6(   �� 5=       � ��
 ���� 6+   �� 5>       � ��
 ���� 6,   �� 5?       � ��$ 1q�60   �� 5@       � ��$
 Left=�64   �� 5A       � ��$ 76��6'   �� 5B       � ��$ 
48,197,0,0q�6'   �� 5C       � ��$	 Top=�62   �� 5D       � ��$	 442��6&   �� 5E       � �� �	#FF22289E6+   �� 5F       �@��CornerRadius$ 12��6-    5G      P� 5H       �@J�IsMouseOver . . �5I      ��  � �� �#0396A663   5J      5L      5M      .��5N      � .+�5O   
   � $
��Left=�6   $��77��6*   $��0,10,0,0q�66   $	��Top=�6H   $	��528��6`   .+�5P      �� -   5         ��Name$ appTitle��5P      $��Authentication��6&   $
��Left=�6?   $��
110,10,0,0q�6Z   $	��Top=�6n   $	��356��6�   ���	#FF453FC1$��Century Gothic)�6�   $
��Bold"�6�   $��36(�6�    J� Opacity$ 0Q�6�   z�5Q      T� 5R      -   5        labelTranslateTransform�� T� X$
 -200Q�5R   J   5T      5U      � 5V   
   $
��Left=�6   $	��465��6*   $��	10,74,0,0q�67   $	��Top=�6J   $	��508��6b   .+�5W      �� $��3,0,3,3q�6   $
��Left=�6/   $	��445��6J   $��	24,10,0,0q�6W   $	��Top=�6j   $	��461��6�    �� CornerRadius$ 24��6�   
�������._�5X      �� -   5         ��Name$ 
tabControl��5X      $
��Left=�61   $	��426��6L   $��9,9,0,0q�6Y   $	��Top=�6j   $	��441��6�   ��6�   Z� ��6�   Z� .@�5Y      �� $��Log In��6   $��-1,-7,-119,-7q�6.   ���	#FF9B9BB6 � Cursor$
 Hand��6s   $��Century Gothic)�6�   $
��Bold"�6�   $��14(�6�   ���	#FF22289E��6\   Z� .��5Z      � $��
22,0,22,16q�6    J� Effect 5[      3  -System.Windows.Media.Effects.DropShadowEffect  5\   "      Color$ White��63      	Direction$	 513Q�6A      Opacity$	 0.5Q�6Q      ShadowDepth$	 100Q�6_      
BlurRadius$	 100Q�6q   .+�5^      �� -   5        $ label3��5^   $   $��Admin Email��64   $
��Left=�6J   $��	32,44,0,0q�6e   $	��Top=�6x   ���	#FF535151$��Normal"�6�   �� 5_      #��[  6%   $��
32,217,0,0q�6]   $	��337��6q   $��50��6}   ._�5`   "   �� -   5         ��Name$ loginBtn��5`   )   $��Log In��6;   #��[B��6L   $��-1,-6q�6�   $	��317��6�   $��40��6�   ��6u   Z� ��6�   Z� 6�   5a      �� 5b      $��1q�6%   $
��Left=�69   $��39��6T   $��	32,76,0,0q�6`   $	��Top=�6s   $	��337��6�   
�������$ 8��6�   $	 0.8Q�6�   ._�5c   "   �� -   5          ��Name$  emailTextBox��5c   *   $
��Left=�6@   $��34��6[   $��8,1,0,0q�6g   ! �� TextWrapping$
! Wrap=�6x   $	��Top=�6�   $	��318��6�   " �� 	IsEnabled" . $��Century Gothic)�6�   $��0,8,0,0q�6  ���	#FF535151# � ToolTip$# Create a session title��6X  ��6�   Z� ��6�   Z� $ �� SelectionBrush$ 6>  Z� 6X  5d      �� 5e      -   5        $ label3_Copy1��5e   $   $��Admin Password��6:   $
��Left=�6S   $��
37,120,0,0q�6n   $	��Top=�6�   ���	#FF535151$��Normal"�6�   �� 5f      $��1q�6%   $
��Left=�69   $��40��6T   $��
32,152,0,0q�6`   $	��Top=�6t   $	��337��6�   
�������$ 8��6�   $	 0.8Q�6�   ._�5g   "   G� -   5        % G�Name$% passwordBox��5g   .   $��9,5,9,4q�6C   & J� RenderTransformOrigin$& 
0.51,0.643&�6T   $��Century Gothic)�6w   $# Create a session password��6�   ���	#FF7C7B80��6�   Z� ��6�   Z� 6�   5h      5i      5j      �� 5k      $��Sign Up��6   $��95,-4,-95,-8q�6/   ���	#FF9B9BB6$
��Left=�6s   $	��226��6�   $��Century Gothic)�6�   $
��Bold"�6�   $��14(�6�   ���	#FF22289E' �� 
IsSelected' . ��6\   Z� .��5l      � ���	#FFCDCEDE$��	21,5,22,1q�66   .+�5m      �� -	   5        $ label3_Copy��5m   $   $��Admin First Name��69   $
��Left=�6T   $��	36,15,0,0q�6o   $	��Top=�6�   ���	#FF535151$��Normal"�6�   �� 5n      #��[  6%   $��
34,331,0,0q�6]   $	��337��6q   $��50��6}   ._�5o   "   �� -
   5        $ 	signUpBtn��5o   )   $��Sign Up��6<   #��[B��6N   $��-1,-6q�6�   $	��317��6�   $��40��6�   ��6w   Z� ��6�   Z� 6�   5p      �� 5q      $��1q�6%   $
��Left=�69   $��39��6T   $��	34,42,0,0q�6`   $	��Top=�6s   $	��335��6�   
�������$ 8��6�   $	 0.8Q�6�   ._�5r   "   �� -   5        $  firstNameTextBox��5r   *   $
��Left=�6D   $��34��6_   $��8,1,0,0q�6k   $
! Wrap=�6|   $	��Top=�6�   $	��316��6�   " . $��Century Gothic)�6�   $��0,8,0,0q�6  ���	#FF535151$# Create a session title��6\  ��6�   Z� ��6�   Z� $ 6B  Z� 6\  5s      �� 5t      -   5        $ label3_Copy2��5t   $   $��Admin Password��6:   $
��Left=�6S   $��
36,239,0,0q�6n   $	��Top=�6�   ���	#FF535151$��Normal"�6�   �� 5u      $��1q�6%   $
��Left=�69   $��39��6T   $��
34,271,0,0q�6`   $	��Top=�6t   $	��335��6�   
�������$ 8��6�   $	 0.8Q�6�   ._�5v   "   G� -   5        $% passwordBox1��5v   .   $��9,0,9,4q�6D   $& 
0.51,0.643&�6U   $��Century Gothic)�6x   $# Create a session password��6�   ���	#FF7C7B80$��28��6�   $��Bottom=�6  ��6�   Z� ��6�   Z� 6  5w      �� 5x      -   5        $ label3_Copy3��5x   $   $��Admin Last Name��6:   $
��Left=�6T   $��	36,86,0,0q�6o   $	��Top=�6�   ���	#FF535151$��Normal"�6�   �� 5y      $��1q�6%   $
��Left=�69   $��39��6T   $��
34,113,0,0q�6`   $	��Top=�6t   $	��335��6�   
�������$ 8��6�   $	 0.8Q�6�   ._�5z   "   �� -   5        $  lastNameTextBox��5z   *   $
��Left=�6C   $��34��6^   $��8,1,0,0q�6j   $
! Wrap=�6{   $	��Top=�6�   $	��316��6�   " . $��Century Gothic)�6�   $��0,8,0,0q�6  ���	#FF535151$# Create a session title��6[  ��6�   Z� ��6�   Z� $ 6A  Z� 6[  5{      �� 5|      -   5        $ label3_Copy4��5|   $   $��Admin Email��6:   $
��Left=�6P   $��
36,163,0,0q�6k   $	��Top=�6   ���	#FF535151$��Normal"�6�   �� 5}      $��1q�6%   $
��Left=�69   $��39��6T   $��
36,195,0,0q�6`   $	��Top=�6t   $	��335��6�   
�������$ 8��6�   $	 0.8Q�6�   ._�5~   "   �� -   5        $  emailTextBox1��5~   *   $
��Left=�6A   $��34��6\   $��8,1,0,0q�6h   $
! Wrap=�6y   $	��Top=�6�   $	��316��6�   " . $��Century Gothic)�6�   $��0,8,0,0q�6  ���	#FF535151$# Create a session title��6Y  ��6�   Z� ��6�   Z� $ 6?  Z� 6Y  5      5�      5�      5�      5�      5�      5�      5�      