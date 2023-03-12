import 'package:flutter/material.dart';
import 'package:tap_multiplayer/assets/Colors.dart';


///a class to switch between themes when the user clicks the button
class ThemeModel extends ChangeNotifier{
  ThemeData currentTheme = AppThemes.PB_Theme;

  changeTheme(int value){
    if(value==1)
      currentTheme = AppThemes.RB_Theme;
    else if(value == 2)
      currentTheme = AppThemes.PV_Theme;
  }


}

///Themes
class AppThemes{
  static ThemeData RB_Theme = ThemeData.light().copyWith(
      primaryColor: retrieveColor('primary', RB_colors),

      //this is used and called in the scaffold background to give gradiant effect
      colorScheme: ColorScheme.light(
            primary: retrieveColor('color1', RB_colors),
            secondary: retrieveColor('color2', RB_colors),
      ),

      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: retrieveColor('primaryText', RB_colors),
        ),
        bodyLarge: TextStyle(
          color: retrieveColor('secondaryText', RB_colors),
          fontSize: 30,
        ),
      )
  );


  static ThemeData PV_Theme = ThemeData(
    primarySwatch: retrieveColor('primary', PV_colors),

    //to change appbar settings
    appBarTheme: AppBarTheme(
      toolbarTextStyle: TextStyle(
          color: retrieveColor('secondaryText', PV_colors)
      )
    ),


    textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: retrieveColor('primaryText', PV_colors),
        ),
        bodyLarge: TextStyle(
            color: retrieveColor('secondaryText', PV_colors)
        ),
      ),


    colorScheme: ColorScheme.light(
      primary: retrieveColor('colorGradiant1', PV_colors),
      secondary: retrieveColor('colorGradiant2', PV_colors),
    ),


    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.light(
        background:  retrieveColor('buttonBGColor', PV_colors),
      ),
    ),
  );


  static ThemeData PB_Theme = ThemeData(
    primarySwatch: retrieveColor('primary', PB_colors),

    //to change appbar settings
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(
        color: retrieveColor('iconColor', PB_colors)
      ),
        toolbarTextStyle: TextStyle(
            color: retrieveColor('secondaryText', PB_colors)
        )
    ),


    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: retrieveColor('primaryText', PB_colors),
      ),
      bodyLarge: TextStyle(
          color: retrieveColor('secondaryText', PB_colors)
      ),
    ),


    colorScheme: ColorScheme.light(
      primary: retrieveColor('colorGradiant1', PB_colors),
      secondary: retrieveColor('colorGradiant2', PB_colors),
    ),


    dialogTheme: DialogTheme(
      titleTextStyle: TextStyle(
        color: retrieveColor('dialogTitle', PB_colors)
      )
    ),


    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.light(
        background:  retrieveColor('buttonBGColor', PB_colors),
      ),
    ),
  );
}