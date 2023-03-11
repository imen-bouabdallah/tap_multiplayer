
// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'package:confetti/confetti.dart';

late int difficulty;

class game extends StatelessWidget{
  final int difficult;

  const game({required this.difficult}); //get the data passed by previous activity

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //to hide statusBar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    difficulty = difficult;
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

  // declare confettiController;
  late ConfettiController _topController;

  int _cpt =0, _cpt2 = 0;
  String _textPlayer1 = 'Player one', _textPlayer2= 'Player two';
  bool _win = false, _start = false;
  late double _screenHeight, heightPlayer1, heightPlayer2, heightPlayer,
      width, border, space;



  void initState() {
    super.initState();
    _topController =
        ConfettiController(duration: const Duration(seconds: 10));
    ///set the difficulty level
    if(difficulty == 0){ //hard
      print(difficulty);
      space = 10.0;
    }
    else if(difficulty == 1) //medium
      space = 40.0;
    else                    //easy
      space = 80.0;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _screenHeight =  MediaQuery.of(context).size.height; //get screen height
    border = _screenHeight%10; //to add borders
    _screenHeight-= border; //remove the borders value from the screen heights
    heightPlayer1 = heightPlayer2 =  _screenHeight/2; //player's space
    width = MediaQuery.of(context).size.width - border; //define width




    // ignore: non_constant_identifier_names
    // when user taps the screen
    void _handleTap(TapPosition position, double _screenHeight) {
      setState(() {
        ///bcz each time the set state is executed the heights are reintialized
        ///we can't put them outside of build cuz we need context
        ///we have to redraw the rectangles each time
        heightPlayer2 = heightPlayer2 - space*_cpt2 + space*_cpt ;
        heightPlayer1 = heightPlayer1 + space*_cpt2 - space*_cpt;
        print(difficulty + space);
        ///if one of the boxes reach full screen then the game should stops
        if(heightPlayer1>=(_screenHeight) || heightPlayer2<=5.0){
          _win = true;
          _textPlayer1 = "You won!";
          _textPlayer2 = "You lost";

        }
        else if(heightPlayer2>=(_screenHeight) || heightPlayer1<=(space -5.0)){
          _win = true;
          _textPlayer2 = "You won!";
          _textPlayer1 = "You lost";

        }
        else{
          ///otherwise we need to know which player has tapped to increment its box
          ///we either reduce or increase the player's space depending on where the tap is
          if (position.relative!.dy > (_screenHeight / 2)) {
            ///player two has tapped

            _cpt++;
            heightPlayer1 = heightPlayer1 - space;
            heightPlayer2 = heightPlayer2 + space;
          }
          else {
            ///player one

            _cpt2++;
            heightPlayer2 = heightPlayer1 - space;
            heightPlayer1 = heightPlayer2 + space;
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
        child: PositionedTapDetector2(

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
                    height: heightPlayer1 + space*_cpt2 - space*_cpt ,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.red[400],
                      ),
                      child:
                      ///if one of the players won
                      ///or the game hasn't started yet
                      ///print text
                      _win || !_start? RotatedBox(
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
                    height: heightPlayer2 - space*_cpt2 + space*_cpt,
                    child: /*Column(
                      children: [*/
                        DecoratedBox(
                        decoration: BoxDecoration(
                        color: Colors.blue[300],
                        ),
                        child:
                        _win || !_start ? Align(
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
                      /*  ConfettiWidget(
                          confettiController: _topController,
                          blastDirection: 3.14 / 2,
                          maxBlastForce: 5,
                          minBlastForce: 1,
                          emissionFrequency: 0.03,

                          // 10 paticles will pop-up at a time
                          numberOfParticles: 10,

                          // particles will pop-up
                          gravity: 0,
                        ),
                      ],
                    ),*/
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

