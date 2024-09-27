import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async'; // Add this to use Timer

void main() => runApp(DiceApp());

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rolling Dice',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: DiceScreen(),
    );
  }
}

class DiceScreen extends StatefulWidget {
  @override
  _DiceScreenState createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> with TickerProviderStateMixin {
  int _diceNumber1 = 1;
  int _diceNumber2 = 1;
  int _diceNumber3 = 1;
  int _diceNumber4 = 1;

  bool _isRolling1 = false;
  bool _isRolling2 = false;
  bool _isRolling3 = false;
  bool _isRolling4 = false;

  // Animation duration
  final Duration _animationDuration = Duration(milliseconds: 500);

  void _rollDice(int diceNumber) {
    _startRollingAnimation(diceNumber); // Start rolling animation

    Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      setState(() {
        if (diceNumber == 1) _diceNumber1 = Random().nextInt(6) + 1;
        if (diceNumber == 2) _diceNumber2 = Random().nextInt(6) + 1;
        if (diceNumber == 3) _diceNumber3 = Random().nextInt(6) + 1;
        if (diceNumber == 4) _diceNumber4 = Random().nextInt(6) + 1;
      });

      // Stop after a few rolls (around 1 second)
      if (timer.tick >= 10) {
        timer.cancel();
        _stopRollingAnimation(diceNumber);
      }
    });
  }

  void _startRollingAnimation(int diceNumber) {
    setState(() {
      if (diceNumber == 1) _isRolling1 = true;
      if (diceNumber == 2) _isRolling2 = true;
      if (diceNumber == 3) _isRolling3 = true;
      if (diceNumber == 4) _isRolling4 = true;
    });
  }

  void _stopRollingAnimation(int diceNumber) {
    setState(() {
      if (diceNumber == 1) _isRolling1 = false;
      if (diceNumber == 2) _isRolling2 = false;
      if (diceNumber == 3) _isRolling3 = false;
      if (diceNumber == 4) _isRolling4 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Dice Roll'),
        ),
        backgroundColor: Color(0x5FD363E6),
      ),
      backgroundColor: Color(0x5FD363E6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDiceColumn(
                  ' Number: $_diceNumber1',
                  'images/dice-$_diceNumber1.png',
                  _isRolling1,
                      () => _rollDice(1),
                ),
                SizedBox(width: 200),
                _buildDiceColumn(
                  ' Number: $_diceNumber2',
                  'images/dice-$_diceNumber2.png',
                  _isRolling2,
                      () => _rollDice(2),
                ),
              ],
            ),
            SizedBox(height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDiceColumn(
                  ' Number: $_diceNumber3',
                  'images/dice-$_diceNumber3.png',
                  _isRolling3,
                      () => _rollDice(3),
                ),
                SizedBox(width: 200),
                _buildDiceColumn(
                  ' Number: $_diceNumber4',
                  'images/dice-$_diceNumber4.png',
                  _isRolling4,
                      () => _rollDice(4),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiceColumn(String text, String imagePath, bool isRolling, VoidCallback onPressed) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        AnimatedOpacity(
          opacity: isRolling ? 1.0 : 0.7, // Change opacity during rolling
          duration: _animationDuration,
          child: AnimatedScale(
            scale: isRolling ? 1.7 : 1.0, // Pop-up effect with scale
            duration: _animationDuration,
            child: Image.asset(
              imagePath,
              height: 100,
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: isRolling ? null : onPressed, // Disable button when rolling
          child: Text(' Roll the Dice '),
        ),
      ],
    );
  }
}
