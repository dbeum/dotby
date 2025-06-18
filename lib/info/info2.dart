

import 'package:dotby1/home/home2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Info2 extends StatefulWidget {
   final Map<String, dynamic> infoDetails;

    const Info2({super.key, required this.infoDetails});

  @override
  State<Info2> createState() => _Info2State();
}

class _Info2State extends State<Info2> {
   int _orderQuantity = 1; // Initial quantity
late double price;
  late double basePrice;

  @override
  void initState() {
    super.initState();
      basePrice = widget.infoDetails['price'] ?? 0;
     price = basePrice; 
  }


  void _increment() {
    setState(() {
      _orderQuantity++;
     price = basePrice * _orderQuantity;
    });
  }

  void _decrement() {
    if (_orderQuantity > 1) {
      setState(() {
        _orderQuantity--;
         price = basePrice * _orderQuantity; 
      });
    }
  }


  Future<void> _launchwhatsapp() async {
  String productName = widget.infoDetails['name'] ?? "the product";
  final Uri whatsappUrl = Uri.parse(
      'https://wa.me/2348173211336?text=${Uri.encodeFull("I would like to reach you regarding $productName")}');

  if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $whatsappUrl';
  }
}

  
  @override
  Widget build(BuildContext context) {
   //    String? name = widget.infoDetails['title'];
    String? profileImage = widget.infoDetails['profileImage'];
  //  int? price = widget.infoDetails['price'];

final formattedPrice = '₦${NumberFormat('#,###').format(price.toInt())}';



    return  Scaffold(
     backgroundColor: Color.fromARGB(255,	19, 20, 22),
    //  appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,),
      body: Column(
        children: [
                SizedBox(height: 50,),
  Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
     
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home2()), 
              (Route <dynamic> route )=> false,
            );
          },
        ),
      
      
       ],),
          SizedBox(height: 90,),
          Center(child:  profileImage != null
                            ? Image.network(
                                profileImage,
                              height: 200,
                              )
                            : Image.asset(
                                'assets/images/logo.png',  
                               height: 200,
                              )),

          SizedBox(height: 50,),
          Expanded(child: Container(
            
            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
            color: Color.fromARGB(255, 	32, 32, 36),
            ),
            child: Padding(padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                SizedBox(height: 10,),
                Text(widget.infoDetails['name'],style: GoogleFonts.aDLaMDisplay(fontSize:20,fontWeight:FontWeight.bold, color: Colors.white),),
                SizedBox(height: 10,),
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
Text(formattedPrice,style: GoogleFonts.mulish(fontSize:20,fontWeight:FontWeight.bold, color: Colors.white),),
Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          //add button
             Container(height: 35,width: 45,
      decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,29, 31, 35), Color.fromARGB(255,19, 20, 22)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
     child: SizedBox(
    width: double.infinity, // Forces button to take full width
    height: double.infinity, // Forces button to take full height
    child: ElevatedButton(
      onPressed: _increment, 
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, // Keep button transparent for gradient effect
        foregroundColor: Colors.white,
        padding: EdgeInsets.zero, // Remove default button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3, // Remove extra shadow
      ),
      child: Center( // Explicitly center the icon
        child: Icon(Icons.add, color: Colors.white),
      ),
    ),
  ),
),
     
            // Quantity Display
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '$_orderQuantity',
                style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),

           
             // Subtract Button
           Container(height: 35,
           width: 45,
           
      decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,29, 31, 35), Color.fromARGB(255,19, 20, 22)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      
      child: SizedBox(
    width: double.infinity, // Forces button to take full width
    height: double.infinity, // Forces button to take full height
    child: ElevatedButton(
      onPressed: _decrement,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, // Keep button transparent for gradient effect
        foregroundColor: Colors.white,
        padding: EdgeInsets.zero, // Remove default button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3, // Remove extra shadow
      ),
      child: Center( // Explicitly center the icon
        child: Icon(Icons.remove, color: Colors.white),
      ),
    ),
  ),
),

          ],
        ),
     
       
                ],),
                SizedBox(height: 10,),
                  Text(widget.infoDetails['description'],style: GoogleFonts.mulish(fontSize:10,fontWeight:FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.justify,
                softWrap: true,),
                SizedBox(height: 20,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(height: 50,
    width: 100,
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(18)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed: _launchwhatsapp,
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Change button color
    foregroundColor: Colors.white, // Change text/icon color
  //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18), // Round edges
    ),
    elevation: 5, // Add shadow effect
  ),
       child:Image.asset('assets/images/whatsapp.png')
      )),
      
       
        ],)
              ],
            ),)
          ))
        ],
      ),
    );
  }
}