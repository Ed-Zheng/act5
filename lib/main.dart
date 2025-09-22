import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: DigitalPetApp(),
  ));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Your Pet";
  int happinessLevel = 50;
  int hungerLevel = 50;
  final TextEditingController _nameController = TextEditingController();
  Timer? _hungerTimer;
  Timer? _happyTimer;
  int _happyDuration = 0;
  final int winCondition = 80;

  void _playWithPet() {
    setState(() {
      happinessLevel += 10;
      _updateHunger();
    });
  }

  void _feedPet() {
    setState(() {
      hungerLevel -= 10;
      _updateHappiness();
    });
  }

  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel -= 20;
    } else {
      happinessLevel += 10;
    }
  }

  void _updateHunger() {
    setState(() {
      hungerLevel += 5;
      if (hungerLevel > 100) {
        hungerLevel = 100;
        happinessLevel -= 20;
      }
    });
  }

  Color _moodColor(double happinessLevel) {
    if (happinessLevel > 70) {
      return Colors.green;
    } else if (happinessLevel >= 30) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  String _moodEmoji(double happinessLevel) {
    if (happinessLevel > 70) {
      return 'assets/images/happy.png';
    } else if (happinessLevel >= 30) {
      return 'assets/images/neutral.png';
    } else {
      return 'assets/images/angry.png';
    }
  }

@override
void initState() {
  super.initState();
  _hungerTimer = Timer.periodic(Duration(seconds: 30), (timer) {
    setState(() {
      hungerLevel += 5;
    });
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: 120,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter Pet Name',
                ),
              ),
            ),

            SizedBox(height: 8.0),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_nameController.text.trim().isNotEmpty) {
                    petName = _nameController.text.trim();
                  }
                });
              },
              child: Text("Confirm"),
            ),

            SizedBox(height: 30.0),

            Text(
              'Name: $petName',
              style: TextStyle(fontSize: 20.0),
            ),
            
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                _moodColor(happinessLevel.toDouble()), // Pass the pet's happiness level
                BlendMode.modulate,
              ),
              child: Image.asset(
                'assets/images/pet_whale.png',
                width: 200,
                height: 200,
              ),
            ),

            Transform.translate(
              offset: const Offset(125, -185),
              child: Image.asset(
                _moodEmoji(happinessLevel.toDouble()),
                width: 40,
                height: 40,
              ),
            ),

            Text(
              'Happiness Level: $happinessLevel',
              style: TextStyle(fontSize: 20.0),
            ),

            SizedBox(height: 16.0),

            Text(
              'Hunger Level: $hungerLevel',
              style: TextStyle(fontSize: 20.0),
            ),

            SizedBox(height: 32.0),

            ElevatedButton(
              onPressed: _playWithPet,
              child: Text('Play with Your Pet'),
            ),

            SizedBox(height: 16.0),

            ElevatedButton(
              onPressed: _feedPet,
              child: Text('Feed Your Pet'),
            ),
          ],
        ),
      ),
    );
  }
}
