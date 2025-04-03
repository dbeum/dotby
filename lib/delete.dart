import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotby1/Login.dart';
import 'package:dotby1/home.dart';
import 'package:dotby1/orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Delete extends StatelessWidget {
  const Delete({super.key});

Future<void> deleteAccount(BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("No user logged in!")),
    );
    return;
  }

  try {
    // confirmation dialog
    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Account",style: TextStyle(color:Colors.white)),
        content: Text("Are you sure? This action cannot be undone.",style: TextStyle(color:Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel",style: TextStyle(color:Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 31, 33, 37),
      ),
    );

    if (!confirmDelete) return; // User canceled

    // Step 1: Delete user data from Firestore
    await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();

    // Step 2: Delete the user's authentication account
    await user.delete();

    // Sign out after deletion
    await FirebaseAuth.instance.signOut();

    // Navigate to login/signup screen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Account deleted successfully.")),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error deleting account: ${e.toString()}")),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  backgroundColor: Color.fromARGB(255, 31, 33, 37),),
body:Center(child:  Column(
children: [
  SizedBox(height: 250,),
  Text('WOULD YOU LIKE TO PROCEED?',style:GoogleFonts.signika(textStyle: TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.bold),)),
 SizedBox(height: 5,),
 Container(
        height: 35,
        width: 100,
        decoration: BoxDecoration(
        color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.white,width: 1)
        ),
        child:TextButton(onPressed:() async {
    await deleteAccount(context);
  }, child: Text('YES',style: TextStyle(color: Colors.red),)),
         
          
          
       ),
  
],),)
    );
  }
}