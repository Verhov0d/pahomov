import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: ((settings) {
        if (settings.name == PeredachaDann.routeName) {
          final args = settings.arguments as String;
          return MaterialPageRoute(builder: (context) {
            return PeredachaDann(soobsh: args);
          });
        }
      }),
      title: 'Hochetsa sdat',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Ochen hochetsa sdat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  TextEditingController txt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 400,
            height: 60,
            child: TextField(
              controller: txt,
            ),
          ),
          SizedBox(
            height: 50,
            width: 150,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, PeredachaDann.routeName,
                      arguments: txt.text);
                },
                child: Text('Продолжить'),
              ),
          ),
          ]
        ), 
      ),
    );
  }
}

class PeredachaDann extends StatelessWidget {
  const PeredachaDann({super.key, required this.soobsh});

  static const routeName = '/extractArguments';
  final String soobsh;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(soobsh, style: const TextStyle(fontSize: 36),),
      );
  }
}