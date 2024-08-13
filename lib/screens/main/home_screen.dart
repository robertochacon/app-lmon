import 'package:lmon/screens/auth/login_screen.dart';
import 'package:lmon/views/requests.dart';
import 'package:lmon/views/calculator.dart';
import 'package:lmon/views/profile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    final screens = [
      const Requests(),
      const Calculator(),
      const Profile(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        elevation: 10,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30, // Cambia el color del botón "Back"
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // Icono de logout
            onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 10,
        selectedItemColor: Color.fromARGB(255, 194, 194, 194),
        unselectedItemColor: Colors.white, // Color del icono cuando el ítem no está seleccionado
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 35,), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate, size: 35,), label: 'Calulator'),
          BottomNavigationBarItem(icon: Icon(Icons.account_box, size: 35,), label: 'Profile'),
        ],
      ),
    );
  }
}

