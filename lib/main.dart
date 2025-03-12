import 'package:dotby1/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(); // Initializes Firebase
  runApp(const MyApp());

   Future.delayed(Duration(seconds: 2), () {
    FlutterNativeSplash.remove();
  });
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DOTBY PRODUCTIONS',
     theme: ThemeData(
       useMaterial3: true,
         primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Color.fromARGB(255, 31, 33, 37) ),
     
      home:Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}