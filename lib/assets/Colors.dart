import 'package:flutter/material.dart';

///a class of color/name to make access easy
class MyColors {
  final Color color;
  final String name;

  MyColors(this.color, this.name);

 /*Color getColor(){
    return this.color;
  }

  String getName(){
    return this.name;
  }*/
}

//get the name and the list and returns the color
MaterialColor retrieveColor(String name, List<MyColors> list){
  int i;
  print("inside retrieve fub");
    for (i=0; i<list.length; i++){
      if(list[i].name==name){
        print("looking for" + name );
        print(list[i].color);
        return buildMaterialColor(list[i].color);
      }
    }

  return buildMaterialColor(Colors.white);
}

///Color list to make it easier bcz themeData only uses Colors and it's limites

//pink violet
List<MyColors> PV_colors = <MyColors>[
  MyColors(Colors.purple.shade50, 'primary'),
  MyColors(Color(0xffffc8dd), 'colorGradiant1'),
  MyColors(Color(0xffcdb4db), 'colorGradiant2'),
  MyColors(Colors.white, 'primaryText'),
  MyColors(Colors.white60, 'secondaryText'),

  MyColors(Color(0xffE5D1FA), 'buttonBGColor'),
];

//red blue
List<MyColors> RB_colors = <MyColors>[
  MyColors(Colors.lightBlue, 'primary'),
  MyColors(Colors.blue.shade300, 'color1'),
  MyColors(Colors.redAccent, 'color2'),
  MyColors(Colors.black54, 'primaryText'),
  MyColors(Colors.black26, 'secondaryText'),

  MyColors(Color(0xff97DEFF), 'buttonBGColor'),
];

//pink brown
List<MyColors> PB_colors = <MyColors>[
  MyColors(Color(0xffd6ccc2), 'primary'),
  MyColors(Color(0xffe5989b), 'colorGradiant1'),
  MyColors(Color(0xffb5838d), 'colorGradiant2'),

  MyColors(Color(0xffdad7cd), 'primaryText'),
  MyColors(Colors.white60, 'secondaryText'),

  MyColors(Color(0xffffb4a2), 'buttonBGColor'),
  MyColors(Colors.white60, 'iconColor'),

  MyColors(Colors.black, 'dialogTitle'),///TODO

];



///build material color from hex color
MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}