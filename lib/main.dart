import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bilet',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

          ],
        ),
      ),
    bottomNavigationBar: BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
        backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Business',
        backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.school),
        label: 'School',
        backgroundColor: Colors.purple,
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
        backgroundColor: Colors.pink,
    ),
    ],
    ));
  }
}
