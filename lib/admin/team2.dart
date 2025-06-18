import 'package:flutter/material.dart';

class Team2 extends StatefulWidget {
  const Team2({super.key});

  @override
  State<Team2> createState() => _Team2State();
}

class _Team2State extends State<Team2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
      child: Text('CAN ONLY BE ACCESSED ON WEB',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
    )
    );
  }
}