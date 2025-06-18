import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dotby1/home/home.dart';

import 'package:firebase_auth/firebase_auth.dart';
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
late double price;
  late double basePrice;
  late int stock;

  @override
  void initState() {
    super.initState();
      basePrice = widget.infoDetails['price'] ?? 0.0;
      stock = widget.infoDetails['stock'] ?? 0.0;
     price = basePrice; 
  }


  void _increment() {
   if (_orderQuantity < stock) { // Ensure quantity doesn't exceed available stock
      setState(() {
        _orderQuantity++;
        price = basePrice * _orderQuantity;
      });
    }
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
   
    String? posterUrl = widget.infoDetails['profileImage'] ??'';

bool isAvailable = widget.infoDetails['available'] ?? true;

final formattedPrice = '₦${NumberFormat('#,###').format(price ?? 0)}';

void addToCart(String productId, String title, double price, String imageUrl, int quantity, int stock) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final cartRef = FirebaseFirestore.instance.collection('carts').doc(user.uid).collection('items').doc(productId);
  final productRef = FirebaseFirestore.instance.collection('products').doc('Events').collection('items').doc(productId);

  final cartItem = await cartRef.get();
  
  // Check if the product is already in the cart
  if (cartItem.exists) {
    int existingQuantity = cartItem.data()?['quantity'] ?? 0;
    int newTotalQuantity = existingQuantity + quantity;

    // Check if there's enough stock for the new quantity
    if (newTotalQuantity > stock) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot add more than available stock')),
      );
      return;
    }

    // Update the cart with new quantity and total price
    await cartRef.update({
      'quantity': newTotalQuantity,
      'totalPrice': basePrice * newTotalQuantity,
    });

    // Decrease the stock in the product document
    await productRef.update({
      'stock': stock - quantity,  // Reduce stock by the added quantity
    });
  } else {
    // If the product isn't in the cart, add it with the given quantity
    await cartRef.set({
      'title': title,
      'price': price,
      'image': imageUrl,
      'quantity': quantity,
      'stock': stock,
      'totalPrice': basePrice * quantity,
    });

    // Decrease the stock in the product document
    await productRef.update({
      'stock': stock - quantity,  // Reduce stock by the added quantity
    });
  }
}

    return  Scaffold(
    
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
              MaterialPageRoute(builder: (context) => Home()), 
              (Route <dynamic> route )=> false,
            );
          },
        ),
      
      
       ],),
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
      onPressed:   _orderQuantity >= stock ? null : _increment, 
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

      if(widget.infoDetails['stock']>0)
          Container(height: 50,
    width: 250,
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(18)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed: (){      if (isAvailable == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('This product is unavailable')),
        );
      } else if (isAvailable == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product availability unknown')),
        );
      } else {
        addToCart(
          widget.infoDetails['id'] ?? 'default_id',
  widget.infoDetails['name'] ?? 'default_name',
  widget.infoDetails['price'] ?? 0.0,
  widget.infoDetails['profileImage'] ?? '',
  _orderQuantity,
  widget.infoDetails['stock'] ?? 0

        );
        showTopSnackBar(context, "Added to Bag");
      }
    },

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