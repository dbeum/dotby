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
 bool _obscureText = true;

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
  SingleChildScrollView(child:  Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 150),
            Image.asset('assets/images/logo1.png', height: 80),
            SizedBox(height: 20),
            Container(
              height: 270,
              width: 300,
          
              child: Column(
                      children: [
                        SizedBox(height: 10),
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
                        Container(
                          height: 35,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(width: 1,color:  Colors.black)
                          ),

                          child: TextButton(
                          //role only necssary when there would be differnet user tiers
                            onPressed: () async {
                              final email = _email.text;
                              final password = _password.text;
                             final role = 'user'; 
                              try {
                                final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );

                             

                                await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
                                  'email': email,
                                   'role': role,
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
                                    showTopSnackBar(context, "Weak password");
                                  } else if (e.code == 'email-already-in-use') {
                                  showTopSnackBar(context, "Email already in use");
                                  } else if (e.code == 'invalid-email') {
                                    showTopSnackBar(context, "Invalid Email");
                                  } else {
                                    print(e);
                                  }
                                } else {
                                  print('Unexpected error: $e');
                                }
                               showTopSnackBar(context, "Registration Failed");
                              }
                            },
                            child: Text(
                              'CREATE ACCOUNT',
                              style: TextStyle(color:   Colors.black,fontSize: 10),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10),
        child:    Text('By creating an account you\'re agreeing to our Terms & Privacy Policy.',style: GoogleFonts.mulish(fontSize:10,color:  Colors.grey),
               textAlign: TextAlign.justify, 
             softWrap: true,),),
                      ],
              
                    )
                  
                
              
            )   ,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ Text('Already have an account?',style: TextStyle(color:  Colors.black),),
                        TextButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login())) , child: Text('LOGIN',style: TextStyle(color:   Colors.red),))],),

SizedBox(height: 20,),
       

            SizedBox(height: 10,),
            Text('© DOTBY PRODUCTIONS',style: TextStyle(color:  Colors.grey),)
          ],
        ),
      ),
    ),));
  }}