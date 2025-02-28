import 'package:dotby1/Home.dart';
import 'package:flutter/material.dart';


void main() {
   WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
     theme: ThemeData(
       useMaterial3: true,
         primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Color.fromARGB(255, 31, 33, 37) ),
     
      home:Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}