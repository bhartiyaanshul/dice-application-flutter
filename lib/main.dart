import 'dart:async';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shake/shake.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'SpaceMono',
        useMaterial3: true,
        
      ),
      home: const MyDicePage(),
    );
  }
}

class MyDicePage extends StatefulWidget {
  const MyDicePage({super.key});

  @override
  State<MyDicePage> createState() => _MyDicePageState();
}

class _MyDicePageState extends State<MyDicePage> {
  double scale = 1;
  double turns = 0;
  late double shakeThresholdGravity;

  AssetImage one = const AssetImage('assets/images/1.jpg');
  AssetImage two = const AssetImage('assets/images/2.jpg');
  AssetImage three = const AssetImage('assets/images/3.jpg');
  AssetImage four = const AssetImage('assets/images/4.jpg');
  AssetImage five = const AssetImage('assets/images/5.jpg');
  AssetImage six = const AssetImage('assets/images/6.jpg');

  int diceImage = 1;

  void rollDice(){
    setState(() {
      turns = 10;
      scale = 0;
    });
    Timer(const Duration(milliseconds: 500), () { 
      setState(() {
        diceImage = (Random().nextInt(6)+1);
        scale = 1;
        turns = 0;
      });
    });
  }
  @override
  void initState(){
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () => rollDice(),shakeThresholdGravity: shakeThresholdGravity = 3.0);
    super.initState();
    detector.startListening();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Dice Application",style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 158, 111, 240),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedRotation(
              turns: turns,
              duration: const Duration(milliseconds: 1000),
              child: AnimatedScale(
                scale: scale,
                duration: const Duration(milliseconds: 500),
                curve: Curves.bounceIn,
                child: Image.asset('assets/images/$diceImage.jpg', width: 200)),
            ),
            // const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () => rollDice(),
                  // final player = AudioPlayer();
                  // final duration = await player.setUrl('https://foo.com/bar.mp3');                 // Schemes: (https: | file: | asset: )
                  // player.play();
                child: const Text("Press Me",style: TextStyle(fontSize: 20),)),
            )
          ],
        ),
      ),
    );
  }
}

