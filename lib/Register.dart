import 'package:clay_containers/widgets/clay_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotby1/Login.dart';
import 'package:dotby1/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print('Firebase initialized');
    } catch (e) {
      print('Error initializing Firebase: $e');
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: 
  SingleChildScrollView(child:  Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 80),
            Image.asset('assets/images/logos.png', height: 200),
            SizedBox(height: 20),
            Container(
              height: 200,
              width: 250,
              // decoration: BoxDecoration(
              // //  color: Colors.black,
              //   borderRadius: BorderRadius.all(Radius.circular(15)),
              //     border: Border.all(color: Colors.black, width: 2),
              // ),
              child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'EMAIL',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,color:Colors.white),
                        ),
                        Container(
                          height: 30,
                          width: 200,
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: Colors.black, width: 2),
                          //   borderRadius: BorderRadius.all(Radius.circular(5)),
                          // ),
                          child: TextField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            enableSuggestions: true,
                                style: TextStyle(  color:Colors.white,),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                              contentPadding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'PASSWORD',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,color:Colors.white),
                        ),
                        Container(
                          height: 30,
                          width: 200,
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: Colors.black, width: 2),
                          //   borderRadius: BorderRadius.all(Radius.circular(5)),
                          // ),
                          child: TextField(
                            controller: _password,
                            autocorrect: false,
                            enableSuggestions: true,
                            obscureText: true,
                                 style: TextStyle(  color:  Colors.black,),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:  Colors.black,)),
                              contentPadding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                      SizedBox(height: 40,),
                        Container(
                          height: 35,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(width: 1,color: Colors.white)
                          ),

                          child: TextButton(
                            onPressed: () async {
                              final email = _email.text;
                              final password = _password.text;
                             
                              try {
                                final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );

                             

                                await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
                                  'email': email,
                                  
                                });

                                print('User registered: ${userCredential.user!.uid}');
                                
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              } catch (e) {
                                if (e is FirebaseAuthException) {
                                  if (e.code == 'weak-password') {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Weak Password')));
                                    print('Weak password');
                                  } else if (e.code == 'email-already-in-use') {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email already in use')));
                                    print('Email is already in use');
                                  } else if (e.code == 'invalid-email') {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid Email')));
                                    print('Invalid email');
                                  } else {
                                    print(e);
                                  }
                                } else {
                                  print('Unexpected error: $e');
                                }
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed')));
                              }
                            },
                            child: Text(
                              'CREATE ACCOUNT',
                              style: TextStyle(color: Colors.white,fontSize: 10),
                            ),
                          ),
                        ),
                     
                      ],
              
                    )
                  
                
              
            )   ,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ Text('Already have an account?',style: TextStyle(color: Colors.black),),
                        TextButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login())) , child: Text('LOGIN',style: TextStyle(color: Colors.white),))],),

SizedBox(height: 20,),
        Padding(padding: EdgeInsets.all(10),
        child:    Text('By creating an account you\'re agreeing to our Terms & Privacy Policy.',style: GoogleFonts.mulish(fontSize:10,color: Colors.white),
               textAlign: TextAlign.justify, 
             softWrap: true,),),

            SizedBox(height: 10,),
            Text('© DOTBY PRODUCTIONS',style: TextStyle(color: Colors.black),)
          ],
        ),
      ),
    ),));
  }}