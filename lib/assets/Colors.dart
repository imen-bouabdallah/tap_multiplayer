import 'package:flutter/material.dart';

class MyColors {
  final Color color;
  final String name;

  MyColors(this.color, this.name);

 /* Color getColor(){
    return this.color;
  }

  String getName(){
    return this.name;
  }*/
}

MaterialColor retrieveColor(String name, List<MyColors> list){
  int i;

    for (i=0; i<list.length; i++){
      if(list.elementAt(i).name==name){
        return buildMaterialColor(list.elementAt(i).color);
      }
    }


  return buildMaterialColor(Colors.white);
}

List<MyColors> PV_Theme = <MyColors>[
  MyColors(Colors.purple.shade50, 'primary'),
  MyColors(Color(0xffCDB4DB), 'color1'),
  MyColors(Color(0xffFFC8DD), 'color2'),
  MyColors(Colors.white, 'text1'),
  MyColors(Colors.white60, 'text2'),
];

List<MyColors> RB_Theme = <MyColors>[
  MyColors(Colors.lightBlue, 'primary'),
  MyColors(Colors.blueAccent, 'color1'),
  MyColors(Colors.redAccent, 'color2'),
  MyColors(Colors.black54, 'text1'),
  MyColors(Colors.black26, 'text2'),
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