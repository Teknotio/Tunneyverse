import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/homepage.dart'; // <-- Import your homepage widget

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tuneyverse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF50449A)),
      ),
      home: TuneyverseLandingPage(), // <-- Set your homepage widget here
      debugShowCheckedModeBanner: false,
    );
  }
}
