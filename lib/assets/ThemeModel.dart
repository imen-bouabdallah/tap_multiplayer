import 'package:flutter/material.dart';
import 'package:tap_multiplayer/assets/Colors.dart';

class ThemeModel extends ChangeNotifier{
  List<MyColors> currentTheme = RB_Theme;

  changeTheme(int value){
    if(value==1)
      currentTheme = RB_Theme;
    else if(value == 2)
      currentTheme = PV_Theme;
  }


}