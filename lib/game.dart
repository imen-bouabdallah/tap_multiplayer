
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:positioned_tap_detector/positioned_tap_detector.dart';


class game extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //to hide statusBar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData() ,
      home: TheGame(),
    );
  }

}

class TheGame extends StatefulWidget{
  @override
  _TheGameState createState() => _TheGameState();

}

class _TheGameState extends State<TheGame> {

  int _cpt =0, _cpt2 = 0;
  String _textPlayer1 = 'Player one', _textPlayer2= 'Player 2';
  bool _win = false, _start = false;
  double _screenHeight, heightPlayer1, heightPlayer2,
      width, border;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _screenHeight =  MediaQuery.of(context).size.height;
    border = _screenHeight%10;
    _screenHeight-= border;
    heightPlayer1 =  _screenHeight/2;
    heightPlayer2 =  _screenHeight/2;
    width = MediaQuery.of(context).size.width - border;


    // ignore: non_constant_identifier_names
    void _handleTap(TapPosition position, double _screenHeight) {
      setState(() {
        ///bcz each time the set state is executed the heights are reintialized
        ///we can't put them outside of build cuz we need context
        heightPlayer2 = heightPlayer2 - 10.0*_cpt2 + 10.0*_cpt ;
        heightPlayer1 = heightPlayer1 + 10.0*_cpt2 - 10.0*_cpt;

        ///if one of the boxes reach full screen then the game should stops
        if(heightPlayer1>=(_screenHeight) || heightPlayer2<=5.0){
          _win = true;
          _textPlayer1 = "You won!";
          _textPlayer2 = "You lost";

        }
        else if(heightPlayer2>=(_screenHeight) || heightPlayer1<=5.0){
          _win = true;
          _textPlayer2 = "You won!";
          _textPlayer1 = "You lost";

        }
        else{
          ///otherwise we need to know which player has tapped to increment its box

          if (position.relative.dy > (_screenHeight / 2)) {
            ///player two has tapped

            _cpt++;
            heightPlayer1 = heightPlayer1 - 10;
            heightPlayer2 = heightPlayer2 + 10.0;
          }
          else {
            ///player one

            _cpt2++;
            heightPlayer2 = heightPlayer1 - 10;
            heightPlayer1 = heightPlayer2 + 10.0;
          }
        }


        if(_win){

          heightPlayer1 = heightPlayer2= _screenHeight/2;
          _cpt = _cpt2 = 0;

          _start = false;

          ///wait 5 seconds before the button reappear
          Timer(Duration(seconds: 5),(){
            _win = false;
          });
        }

      });

    }



    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black54,
            width: border/2,
          )
        ),
        child: PositionedTapDetector(

          ///we need to get the position of tapping to know which player did it
          onTap:  (position) => _start ?
          _handleTap(position, _screenHeight)
           : {},
          child: Stack(
            children: [
              Column(
                children: [
                  //at the beginning both have the same size _cpt and _cpt2 =0
                  SizedBox(
                    width: width,
                    height: heightPlayer1 + 10.0*_cpt2 - 10.0*_cpt ,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.red[400],
                      ),
                      child:
                      _win? RotatedBox(
                        quarterTurns: 2,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            _textPlayer1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      )
                          : Text(''),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    height: heightPlayer2 - 10.0*_cpt2 + 10.0*_cpt,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                      ),
                      child:
                      _win ? Align(
                        alignment: Alignment.center,
                        child: Text(
                          _textPlayer2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                      )
                          : Text(''),
                    ),
                  ),

                ],
              ),
              Visibility(
                child: Align(
                  alignment: Alignment.center,
                  child: FloatingActionButton(
                    onPressed: ()=> _win? {}
                    :{
                      setState((){
                        _start = true;
                      })
                    },

                    child: Text(
                      'Start',
                    ),
                  ),
                ),
                visible: !_start,
              )

            ]
          ),
        ),
      ),
    );
  }

}

