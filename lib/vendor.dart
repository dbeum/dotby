
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotby1/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Vendor extends StatefulWidget {
  const Vendor({super.key});

  @override
  State<Vendor> createState() => _VendorState();
}

final Uri whatsappUrl = Uri.parse('https://wa.me/+2348173211336');

 
  Future<void> _launchwhatsapp() async {
    // Use launchUrl for web compatibility
    if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $whatsappUrl';
    }
  }
class _VendorState extends State<Vendor> {
 

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   //   appBar: AppBar(),
      body: Center(child: Column(children: [
        SizedBox(height: 50,),
       Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
     
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()), 
              (Route <dynamic> route )=> false,
            );
          },
        ),
        SizedBox(width: 100,),
        Text('Vendor Profile',style: TextStyle(color: Colors.white,fontSize: 15),)
       ],),
      
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
        height: 700,
        child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          var vendor = vendors[index];
          return ListTile(
            title: Text('Welcome, ${vendor['businessName']}' ,style: TextStyle(fontSize: 20,color: Colors.white),),
            subtitle:
             Column(children: [
            
            Container(
             
              decoration: BoxDecoration( color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
              child: 
           Padding(padding: EdgeInsets.all(10),child:   Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
            
                  Text('Owner: ${vendor['ownerName']}', style: TextStyle(fontSize: 16,color: Colors.black),),
            Text('Email: ${vendor['email']}' ,style: TextStyle(fontSize: 16,color: Colors.black),),
            Text('Business Type: ${vendor['businessType']}' ,style: TextStyle(fontSize: 16,color: Colors.black),),
            SizedBox(height: 20,),
            Text('Approval Status: ${vendor['contacted'] ? 'APPROVED' : 'NOT APPROVED'}' ,style: TextStyle(fontSize: 16,color: Colors.black),),
             SizedBox(height: 20),
           if(vendor['approvedDate']!=null)
 Text('Approved ON: ${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.black,fontSize: 15)),
              SizedBox(height: 10),
              // Terms and Conditions
              Text(
                "Terms & Conditions for First-Time Payment:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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

                SizedBox(height: 20),
      

            ],),),),
          
                SizedBox(height: 20),
            Text(
                    "You will be contacted via your provided contact details for job openings.",
                    style: TextStyle(fontSize: 15,color:Colors.white),
                  ),
             SizedBox(height: 20),
 TextButton(
                onPressed: _launchwhatsapp,
                child: Text(
                  "Contact Support",
                  style: TextStyle(color: Colors.red),
                ),
              ),

            ],),
            
          );
        },
        )
      );
    }
  },
)

      ],)),
                
    );
  }
}