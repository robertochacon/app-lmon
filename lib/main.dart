// import 'package:course_flutter/screens/counter_screen.dart';
import 'package:lmon/screens/auth/login_screen.dart';
import 'package:lmon/views/Forms/request.dart';
import 'package:flutter/material.dart';

import 'screens/main/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      // home: const HomeScreen(),
      routes: {
        '/request': (context) => const FormRequest(),
      },
    );
  }
}