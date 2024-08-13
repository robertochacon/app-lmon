import 'package:flutter/material.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
            onPressed: (){



              Navigator.pushNamed(context, '/request');
            },
            child: const Icon(Icons.add)),
          )
      );
  }
}
