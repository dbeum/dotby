import 'dart:ui';

import 'package:before_after/before_after.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotby1/info/info2.dart';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

class Events2 extends StatefulWidget {
  const Events2({super.key});

  @override
  State<Events2> createState() => _Events2State();
}

class _Events2State extends State<Events2> {
    double value = 0.5;
late Future<List<Map<String, dynamic>>> eventFuture;

@override
void initState() {
  super.initState();
  eventFuture = fetchEvent();  // cache it once
}

final Uri whatsappUrl = Uri.parse('https://wa.me/+2348173211336');

 
  Future<void> _launchwhatsapp() async {
    // Use launchUrl for web compatibility
    if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $whatsappUrl';
    }
  }

 final Uri talkUrl = Uri.parse('https://www.youtube.com/@dotbytv');

 
  Future<void> _launchtalk() async {
    // Use launchUrl for web compatibility
    if (!await launchUrl(talkUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $talkUrl';
    }
  }
 final Uri xUrl = Uri.parse('https://x.com/dotbyproduction');

 
  Future<void> _launchx() async {
    // Use launchUrl for web compatibility
    if (!await launchUrl(xUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $xUrl';
    }
  }

 final Uri tokUrl = Uri.parse('https://www.tiktok.com/@dotbytv?_t=ZM-8vzWJDkc74Y&_r=1');

 
  Future<void> _launchtok() async {
    // Use launchUrl for web compatibility
    if (!await launchUrl(tokUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $tokUrl';
    }
  }
 final Uri igUrl = Uri.parse('https://www.instagram.com/dotbyproductions?igsh=dzljMWYxY2JsdGEz');

 
  Future<void> _launchig() async {
    // Use launchUrl for web compatibility
    if (!await launchUrl(igUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $igUrl';
    }
  }

    final Uri mapUrl = Uri.parse('https://maps.app.goo.gl/gishirBWSggdz4Ks9');

 
  Future<void> _launchmap() async {
    // Use launchUrl for web compatibility
    if (!await launchUrl(mapUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $mapUrl';
    }
  }

   final String Email = 'info@dotbyproductions.com';

 
  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: Email,
      query: Uri.encodeFull('subject=Hello&body=I would like to reach you regarding...'), // optional pre-filled subject and body
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not open email app';
    }
  }
  Future<List<Map<String, dynamic>>> fetchEvent() async {
  
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('products') // Main products collection
        .doc('Events') // The "events" category
        .collection('items') // The actual products
        .get();

    return snapshot.docs.map((doc) {
      return {
        'id': doc.id, // Document ID
        ...doc.data() as Map<String, dynamic>, // Product details
      };
    }).toList();
  
}

  @override
  Widget build(BuildContext context) { 
      
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
               ImageFiltered(
  imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
  child: Image.asset('assets/images/studio2.jpg')
),
Positioned.fill(child: Align(
  alignment: Alignment.center,
  child: 
      Text('Let\'s Shoot Your Events in Nigeria',style: GoogleFonts.luckiestGuy(fontSize: 20,color: Colors.white),)
    
  
))
              ],
            ),
            SizedBox(height: 50,),
           Container(padding: EdgeInsets.all(50),
        //   width: 1200,
           child:  
              
              
              Column(children: [
                Image.asset('assets/images/event.jpg',height: 300,),
                Text('Your Ultimate Event Shooting Partner!',style: GoogleFonts.aDLaMDisplay(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
             Container(width: 500,
               child: Text('Whether it’s a corporate gathering, concert, wedding, or private party, we bring the gear, experience, and creativity to capture every unforgettable moment.',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                softWrap: true,)),
                SizedBox(height: 10,),
                 Container(width: 500,
               child: Text('• Fully mobile setup – we come to your event, wherever it is',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
                softWrap: true,)),
                  Container(width: 500,
               child: Text('• Professional lighting, audio, and multi-camera options',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
                softWrap: true,)),
                  Container(width: 500,
               child: Text('• Discreet presence – we blend into the background, you enjoy the spotlight',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
                softWrap: true,)),
                 Container(width: 500,
               child: Text('• Fast turnaround on edited photos and videos',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
                softWrap: true,)),
                 Container(width: 500,
               child: Text('• Ideal for indoor and outdoor events of all sizes',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
                softWrap: true,)),
                 SizedBox(height: 10,),
                  Container(width: 500,
               child: Text('Let us help you turn your event into lasting visual memories.',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
                softWrap: true,)),
              ],)
           ),
            SizedBox(height: 50,),
Center(child: Text('Choose Your Package',style: GoogleFonts.luckiestGuy(fontSize: 30,color: Colors.black),),),
         Container(
padding: EdgeInsets.all(20),
child:   FutureBuilder<List<Map<String, dynamic>>>(
  future: eventFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error fetching events'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(child: Text('No events available',style: TextStyle(color: Colors.black),));
    }

    List<Map<String, dynamic>> eventItems = snapshot.data!;

              return 
           Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10),
        
             child: Wrap(
                 spacing: 30,
                 runSpacing: 20,
                 alignment: WrapAlignment.center,
                             children: eventItems.map((Event){
                 
             
String formattedPrice = NumberFormat('#,##0').format(Event['price'] ?? 0);
                 return  Container(height: 250,
    width: 250,
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(255,114, 117, 129), Color.fromARGB(255,29, 31, 35)], 
      begin: Alignment.topLeft, 
      end: Alignment.bottomRight,  
    ),
      ),
      child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Info2(infoDetails:Event))),
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white, 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), 
    ),
    elevation: 5, 
  ),
       child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
ClipRRect(
  borderRadius: BorderRadius.circular(12), 
  child: Event['profileImage'] != null && Event['profileImage'].toString().isNotEmpty
      ? Image.network(
          Event['profileImage'],
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        )
      : Image.asset(
          'assets/images/logo.png',
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
),
        
            Text('₦$formattedPrice',style: GoogleFonts.mulish(fontSize:15,fontWeight:FontWeight.bold, color: Colors.white),),
       ],),
      ));
                     }).toList()
                 ));
                  },
                      ),
         )
         ,
         SizedBox(height: 50,),
          Text('Gallery',style: GoogleFonts.luckiestGuy(fontSize:30,color: Colors.black),),
           SizedBox(height: 20,),
          Container(
            width: 500,
            child: BeforeAfter(
  value: value,
  before: Image.asset('assets/images/after.jpg'),
  after: Image.asset('assets/images/before.jpg'),
  onValueChanged: (value) {
    setState(() => this.value = value);
  },
)),

         SizedBox(height: 50,),
         Text('Thank You!',style: GoogleFonts.luckiestGuy(fontSize:40,color: Colors.black),),
         SizedBox(height: 20,),

       
  ]))
    );
  }}