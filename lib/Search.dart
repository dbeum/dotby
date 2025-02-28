import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(child: 
      Container(height: 35,
      margin: EdgeInsets.only(top: 100,left: 20,right: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: TextField()
  //     ElevatedButton(onPressed: () {
        
  //     },
  //      style: ElevatedButton.styleFrom(
  //   backgroundColor: Colors.transparent, // Change button color
  //   foregroundColor: Colors.white, // Change text/icon color
  // //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(30), // Round edges
  //   ),
  //   elevation: 5, // Add shadow effect
  // ),
  //      child: Text('Explore now',style: TextStyle(color: Colors.white),)),
      ),),
    );
  }
}