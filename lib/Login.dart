import 'package:clay_containers/widgets/clay_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dotby1/home/home.dart';
import 'package:dotby1/home/home2.dart';
import 'package:dotby1/firebase_options.dart';
import 'package:dotby1/register.dart';

import 'package:dotby1/admin/team2.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
 late final TextEditingController _password;
bool _obscureText = true;

@override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
   _email.dispose();
   _password.dispose();
    super.dispose();
  }
  void showTopSnackBar(BuildContext context, String message) {
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 10,
      right: 10,
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16)),
           color: Colors.black87,),

          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );

  Overlay.of(context)?.insert(overlayEntry);

  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
  @override
  Widget build(BuildContext context) {

     return Scaffold(
  body:
   SingleChildScrollView(child: Column(children: [
  Container(
   child: 
  Center(child: 
  Column(
    children: [
      SizedBox(height: 150,),
      Image.asset('assets/images/logo1.png',height: 80,),
     SizedBox(height: 50,),
       Text('Welcome Back',style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,)),
       Text('Sign into your account to continue'),
       SizedBox(height: 50,),
Container(
 height: 300,
      width: 300,
  
    child: FutureBuilder(
      future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform
          ),

      builder: (context, snapshot) {
      
       return  Column(
        children: [
          SizedBox(height: 10,),
          TextField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined),
                            hintText: 'Enter your email',
                            labelText: 'Email Address',
                           labelStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
                          ),

                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _password,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            hintText: 'Enter your password',
                            labelText: 'Password',
                             labelStyle: TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),   
                            ),
                             focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.red,width: 2))
                          ),
                        ),
       SizedBox(height: 20,),
      Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
 Container(
    height: 30,
    width: 135,
 //    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color:Colors.black,),
child: TextButton(onPressed: () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Home2() ));
  },
   child:      Text('EXPLORE AS GUEST',style:TextStyle(fontSize: 10,color:  Colors.red),)),
   
  ),
  Container(
    height: 20,
    width: 2,
    color: Colors.black,
  ),
   Container(
    height: 30,
    width: 120,
 
child: TextButton(onPressed: () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Register() ));
  },
   child: Text('CREATE ACCOUNT',style:TextStyle(fontSize: 10,color:  Colors.black,),)),
   
  ),
 ],),
 SizedBox(height: 20,),
      
       Container(
        height: 35,
        width: 200,
        decoration: BoxDecoration(
        color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.black,width: 1)
        ),
        child: TextButton(
         onPressed: () async{
      
          
       final email = _email.text;
final password = _password.text;

try {
  final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  if (userCredential.user != null) {
    final user = userCredential.user!;
    
    // Fetch user data from Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    if (userDoc.exists) {
     final data = userDoc.data() as Map<String, dynamic>?;
final role = data?['role'] as String?;

 // Retrieve role

if (user.email == 'admin@dotby.com' && role == 'admin') {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Team2()));
} else {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
}

      print('Logged in as: $role');
    } else {
      print('User data not found');
      showTopSnackBar(context, "User Data not Found");
    }
  }
} on FirebaseAuthException catch (e) {
  if (e.code == 'invalid-credential') {
    print('Invalid Credentials');
  showTopSnackBar(context, "Invalid Credentials");
  }
}

         }, 
         child: Text('LOGIN',style: TextStyle(color:  Colors.black),),
         
          ),
          
       ),
       SizedBox(height: 2,),
 
        ],
      );
      
          //default:
          //return const Text('Loading...');
        }
    
      
    ),
),
    
    ],
  
  )
   
  )  
    
  ),
  
 
    ]),)
  );
}}