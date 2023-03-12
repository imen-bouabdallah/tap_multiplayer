import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tap_multiplayer/assets/ThemeModel.dart';
import 'package:tap_multiplayer/game.dart';

void main() {
  runApp(MyApp());
  runApp(
      ChangeNotifierProvider<ThemeModel>(
          create: (BuildContext context) => ThemeModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tap Tap multi-player',
      theme: Provider.of<ThemeModel>(context).currentTheme,
      home: MyHomePage(title: 'Finger battle'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    int difficulties = 2; //define game difficulty


    //show status bar
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    //transparent status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));


    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WillPopScope(
    onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                },//Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ); return false;
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Provider.of<ThemeModel>(context).currentTheme.colorScheme.primary,
              Provider.of<ThemeModel>(context).currentTheme.colorScheme.secondary,
              //Colors.lightBlue,
              //Colors.redAccent,
            ]
          )
        ),
        child: Scaffold(
          //bcz by default the color is white
          backgroundColor: Colors.transparent,

          //the appBar
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
            actions: <Widget>[
              IconButton(
                  onPressed: ()=>{},
                  icon: Icon(
                    Icons.settings
                  ),
              ),
            ],
          ),
          body: Center(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.black26,
                    )
                  ),
                  child: Text(
                    'Tap Tap\n\n multi-player game',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Provider.of<ThemeModel>(context).currentTheme.textTheme.bodyLarge?.color,
                      fontSize: 30,
                    )
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () =>{
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => game(difficult : difficulties) ) ),
                  },
                  style: TextButton.styleFrom(
                    fixedSize: Size(100, 5),
                  ),
                  child: Text(
                    'Begin',
                      style: TextStyle(
                        color: Colors.black54,
                      )
                  ),
                ),
                ElevatedButton(
                  onPressed:  () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                'Select game difficulty',

                            ),
                            SizedBox(height: 15),
                            TextButton(
                              onPressed: () {
                                difficulties = 2;
                                Navigator.pop(context);
                              },

                              child: Text('Easy'),
                            ),
                            TextButton(
                              onPressed: () {
                                difficulties = 1;
                                print(difficulties);
                                Navigator.pop(context);
                              },
                              child: Text('Medium'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Hard'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    surfaceTintColor: Colors.blue[300],
                    fixedSize: Size(100, 5),
                  ),

                  child: Text(
                      'Difficulty',
                      style: TextStyle(
                        color: Colors.black54,
                      )
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Select game difficulty'),
                              SizedBox(height: 15),
                              TextButton(
                                onPressed: () {
                                  difficulties = 2;
                                  Navigator.pop(context);
                                },

                                child: Text('Easy'),
                              ),
                              TextButton(
                                onPressed: () {
                                  difficulties = 1;
                                  print(difficulties);
                                  Navigator.pop(context);
                                },
                                child: Text('Medium'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Hard'),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ),
                  style: TextButton.styleFrom(
                    fixedSize: Size(100, 5),
                  ),

                  child: Text(
                      'Theme',
                      style: TextStyle(
                        color: Colors.black54,
                      )
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
