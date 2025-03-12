import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Info extends StatefulWidget {
   final Map<String, dynamic> infoDetails;

    const Info({super.key, required this.infoDetails});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
   int _orderQuantity = 1; // Initial quantity
late int price;

  @override
  void initState() {
    super.initState();
    price = widget.infoDetails['price'] ?? 0; // Initialize price
  }


  void _increment() {
    setState(() {
      _orderQuantity++;
      price = (price ?? 0) * 2; 
    });
  }

  void _decrement() {
    if (_orderQuantity > 1) {
      setState(() {
        _orderQuantity--;
         price = (price ?? 0) ~/ 2;
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
    String? posterUrl = widget.infoDetails['poster_url'];
  //  int? price = widget.infoDetails['price'];

final formattedPrice = '₦${NumberFormat('#,###').format(price ?? 0)}';


    return  Scaffold(
      backgroundColor: Color.fromARGB(255,	19, 20, 22),
      appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,),
      body: Column(
        children: [
          SizedBox(height: 90,),
          Center(child:  posterUrl != null
                            ? Image.network(
                                posterUrl,
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
                    
Text(formattedPrice,style: GoogleFonts.aDLaMDisplay(fontSize:20,fontWeight:FontWeight.bold, color: Colors.white),),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(height: 50,
    width: 70,
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
      
          Container(height: 50,
    width: 250,
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(18)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed: (){},
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Change button color
    foregroundColor: Colors.white, // Change text/icon color
  //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18), // Round edges
    ),
    elevation: 5, // Add shadow effect
  ),
       child:Text('Add to bag')
      ))
        ],)
              ],
            ),)
          ))
        ],
      ),
    );
  }
}