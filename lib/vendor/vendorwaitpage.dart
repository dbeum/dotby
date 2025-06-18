import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotby1/home/home.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Vendorwaitpage extends StatefulWidget {
  const Vendorwaitpage({super.key});

  @override
  State<Vendorwaitpage> createState() => _VendorwaitpageState();
}

final Uri whatsappUrl = Uri.parse('https://wa.me/+2348173211336');

 
  Future<void> _launchwhatsapp() async {
    // Use launchUrl for web compatibility
    if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $whatsappUrl';
    }
  }
class _VendorwaitpageState extends State<Vendorwaitpage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   //   appBar: AppBar(),
      body: Center(child: Column(children: [
        SizedBox(height: 40,),
       Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
     
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()), 
              (Route <dynamic> route )=> false,
            );
          },
        ),
       ],),
         Text(  "Your vendor registration is currently pending approval.",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.black),),
                StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('vendors') // Firestore collection
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid) // Filter orders by the current user's ID
      .snapshots(),  // This gives you a stream of data
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator()); // Show loading spinner
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}')); // Show error message
    } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Center(child: Text('No Request found.'));
    } else {
      // Once data is available, we map the snapshot to a list of documents
      var vendors = snapshot.data!.docs;

      return Container(
        height: 250,
        child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          var vendor = vendors[index];
          return ListTile(
            title: Text('Business Name: ${vendor['businessName']}' ,style: TextStyle(fontSize: 16,color: Colors.black),),
            subtitle: Column(children: [Text('Owner Name: ${vendor['ownerName']}', style: TextStyle(fontSize: 16,color: Colors.black),),
            Text('Email: ${vendor['email']}' ,style: TextStyle(fontSize: 16,color: Colors.black),),
            Text('Business Type: ${vendor['businessType']}' ,style: TextStyle(fontSize: 16,color: Colors.black),),
            if(vendor['businessType']=='Other')
             Text('${vendor['other']}' ,style: TextStyle(fontSize: 16,color: Colors.black),),
            SizedBox(height: 20,),
            Text('Approval Status: ${vendor['contacted'] ? 'APPROVED' : 'NOT APPROVED'}' ,style: TextStyle(fontSize: 16,color: Colors.black),),
             SizedBox(height: 20),

             
            
       
            ],)
          );
        },
        )
      );
    }
  },
),
 Padding(padding: EdgeInsets.all(20),
 child: Column(children: [ Text(
                "Terms & Conditions:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "1. After approval a registration fee of 5,000 is required to activate your vendor account.",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "2. The registration fee will be paid upon your first job assignment.",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "3. Once your registration is approved, you'll be able to start accepting job requests.",
                style: TextStyle(fontSize: 16),
              ),],)),
       SizedBox(height: 20),
 TextButton(
                onPressed: _launchwhatsapp,
                child: Text(
                  "Contact Support",
                  style: TextStyle(color: Colors.red),
                ),
              ),
      ],)),
                
    );
  }
}