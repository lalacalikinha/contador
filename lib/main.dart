import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo de Adivinhação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NivelScreen(),
    );
  }
}

class NivelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escolha o Nível')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Fácil'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(10),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Médio'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(50),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Difícil'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(100),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final int maxNumber;

  GameScreen(this.maxNumber);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _randomNumber = 0; // Inicialização corrigida
  int _attempts = 0;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _randomNumber = Random().nextInt(widget.maxNumber) + 1;
  }

  void _checkNumber() {
    setState(() {
      _attempts++;
    });

    int? guessedNumber = int.tryParse(_controller.text);

if (guessedNumber != null) {
  if (guessedNumber == _randomNumber) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WinScreen(_attempts),
      ),
    );
  } else if (guessedNumber < _randomNumber) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tente um número maior!')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tente um número menor!')),
    );
  }

  if (_attempts >= 5) {  // Limite de tentativas
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoseScreen(_randomNumber),
      ),
    );
  }
}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jogo de Adivinhação')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Tente adivinhar o número entre 1 e ${widget.maxNumber}'),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número',
                hintText: 'Digite um número',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Verificar'),
              onPressed: _checkNumber,
            ),
          ],
        ),
      ),
    );
  }
}

class WinScreen extends StatelessWidget {
  final int attempts;

  WinScreen(this.attempts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Parabéns!')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Você acertou em $attempts tentativas!'),
            ElevatedButton(
              child: Text('Jogar Novamente'),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoseScreen extends StatelessWidget {
  final int number;

  LoseScreen(this.number);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game Over')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('O número era $number'),
            ElevatedButton(
              child: Text('Tentar Novamente'),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
