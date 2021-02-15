import 'package:flutter/material.dart';
import 'package:quiz_ui/data/categories.dart';
import 'package:quiz_ui/screens/category_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CategoryScreen(
        category: categories.first,
      ),
    );
  }
}
