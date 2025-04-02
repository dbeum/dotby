import 'package:clay_containers/widgets/clay_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotby1/firebase_options.dart';
import 'package:dotby1/home.dart';
import 'package:dotby1/home2.dart';
import 'package:dotby1/register.dart';
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
      SizedBox(height: 80,),
      Image.asset('assets/images/logos.png',height: 200,),
    
       Text('Log in',style: GoogleFonts.aDLaMDisplay(fontSize:20,fontWeight:FontWeight.bold, color: Colors.white)),
       SizedBox(height: 50,),
Container(
 height: 200,
      width: 250,
  
    child: FutureBuilder(
      future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform
          ),

      builder: (context, snapshot) {
        //switch (snapshot.connectionState){
       //   case ConnectionState.done:
       return  Column(
        children: [
          SizedBox(height: 10,),
          Text('EMAIL',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold,color: Colors.white),),
       Container(
        height: 30,
        width: 200,
       
        child: TextField(
          controller:_email ,
            keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          enableSuggestions: true,
              style: TextStyle( color:Colors.white,),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:  Colors.black,)),
        contentPadding: EdgeInsets.symmetric(vertical: 15), // Adjust the vertical padding
      ),
          ),
       ),
       SizedBox(height: 20,),
          Text('PASSWORD',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold,color: Colors.white),),
       Container(
        height: 30,
        width: 200,
      //   decoration: BoxDecoration(
      //  //   border: Border.all(color: Colors.black,width: 2),
      //    // borderRadius: BorderRadius.all(Radius.circular(5))
      //   ),
        child: TextField(
          controller: _password,
          autocorrect: false,
          enableSuggestions: true,
          obscureText: true,
                style: TextStyle( color:Colors.white),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:  Colors.black,)),
        contentPadding: EdgeInsets.symmetric(vertical: 15), // Adjust the vertical padding
      ),
          ),
       ),
       SizedBox(height: 20,),
      
      
       Container(
        height: 35,
        width: 200,
        decoration: BoxDecoration(
        color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.white,width: 1)
        ),
        child: TextButton(
         onPressed: () async{
      
          
           final email =_email.text;
           final password = _password.text;
       try {
    final UserCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
     if (UserCredential.user != null) {
      final user = UserCredential.user!;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
   
           print(UserCredential);
          
        }}
      on FirebaseAuthException  catch (e){
        if (e.code=='invalid-credential'){
          print('Invalid Credential');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid Credentials')));
        }  
        }
         }, 
         child: Text('LOGIN',style: TextStyle(color: Colors.white),),
         
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
   child:      Text('EXPLORE AS GUEST',style:TextStyle(fontSize: 10,color: Colors.white,),)),
   
  ),
  Container(
    height: 20,
    width: 2,
    color: Colors.white,
  ),
   Container(
    height: 30,
    width: 120,
 //    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color:Colors.black,),
child: TextButton(onPressed: () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Register() ));
  },
   child: Text('CREATE ACCOUNT',style:TextStyle(fontSize: 10,color: Colors.black,),)),
   
  ),
 ],)
    ]),)
  );
}}