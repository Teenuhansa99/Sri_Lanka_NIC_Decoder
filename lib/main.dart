import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'input_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NIC Decoder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 9, 60, 79),), //defines the theme color
        useMaterial3: true,
      ),
      home: InputPage(), //sets InputPage as the home screen
    );
  }
}
