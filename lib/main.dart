// import 'package:course_flutter/screens/counter_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lmon/screens/auth/login_screen.dart';
import 'package:lmon/views/Forms/request.dart';
import 'package:flutter/material.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      routes: {
        '/request': (context) => const FormRequest(),
      },
    );
  }
}