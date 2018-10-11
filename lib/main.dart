import 'package:flutter/material.dart';
import 'package:loja/screens/Home_Screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clothing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 4, 125, 141)
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

