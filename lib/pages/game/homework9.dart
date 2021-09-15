import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'game.dart';

class homework9 extends StatefulWidget {
  const homework9({Key? key}) : super(key: key);

  @override
  _homework9State createState() => _homework9State();
}

class _homework9State extends State<homework9> {
  @override
  Game? _game;
  var _controller = TextEditingController();
  String? _guessNumber;
  String? _feedback;
  int nub = 0;
  var mylist = [];
  int? seb;

  @override
  void initState() {
    super.initState();
    _game = Game();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUESS THE NUMBER'),
      ),
      body: Container(
        color: Colors.yellow.shade100,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader(),
                _buildMainContent(),
                _buildInputPanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo_number.png',
          width: 240.0,
        ),
        Text(
          'GUESS THE NUMBER',
          style: GoogleFonts.kanit(fontSize: 22.0, color: Colors.blue),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return _guessNumber == null  ? Column(
      children: [
        Text("I'm thinking of a number between 1 and 100.",style: TextStyle(fontSize: 20.0),textAlign: TextAlign.center,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Can you guess it?",style: TextStyle(fontSize: 20.0),textAlign: TextAlign.center),
            Icon(
              Icons.favorite, // รูปไอคอน
              size: 30.0, // ขนาดไอคอน
              color: Colors.red, // สีไอคอน
            ),
          ],
        )

      ],
    )
        : Column(
      children: [
        Text(
          _guessNumber!,
          style: GoogleFonts.kanit(
              fontSize: 80.0, color: Colors.black.withOpacity(0.5)),
        ),
        if(_feedback!='CORRECT!')
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.clear, // รูปไอคอน
                size: 30.0, // ขนาดไอคอน
                color: Colors.red, // สีไอคอน
              ),
              Text(
                _feedback!,
                style: GoogleFonts.kanit(fontSize: 40.0),
              ),

            ],
          ),
        if (_feedback == 'CORRECT!')
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.done, // รูปไอคอน
                  size: 30.0, // ขนาดไอคอน
                  color: Colors.green, // สีไอคอน
                ),
                Text(
                  _feedback!,
                  style: GoogleFonts.kanit(fontSize: 40.0),
                ),
              ]
          ),
        if (_feedback == 'CORRECT!')
          TextButton(
              onPressed: () {
                setState(() {
                  _game = Game();
                  _guessNumber = null;
                  mylist = [];
                  nub=0;
                });
              },
              child: Text('NEW GAME'))
      ],
    );

  }
  Widget _buildInputPanel() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(5.0, 5.0),
              color: Colors.blue,
              spreadRadius: 22.0,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                enabled: (_feedback ==null && _feedback =='CORRECT!')?false:true,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: Colors.yellow,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  isDense: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'Enter the number here',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    String input = _controller.text;
                    _controller.clear();
                    _guessNumber = input;
                    int? guess = int.tryParse(_guessNumber!);
                    mylist.add(guess!);
                    if (guess != null) {
                      nub++;
                      var result = _game!.doGuess(guess);
                      if (result == 0) {
                        //ถูก
                        _feedback = 'CORRECT!';
                        _showMaterialDialog();
                      } else if (result == 1) {
                        //มากไป
                        _feedback = 'TOO HIGH!';
                      } else {
                        //น้อยไป
                        _feedback = 'TOO LOW!';
                      }
                    }
                  });
                },
                child: Text(
                  'GUESS',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _showMaterialDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('GOOD JOB!'),
          content:
              Text('The answer is $_guessNumber\nYou have made $nub guesses.\n${getlist().toString()}'),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  String getlist(){
      String v ="";
      for(int i=0 ;i<mylist.length ; ++i) {
        v += "${mylist[i].toString()}";
      if(i!=mylist.length -1){
        v+=" => ";
      }
      }
      return v;
  }

}
