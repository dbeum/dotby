import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotby1/confirm.dart';
import 'package:dotby1/orders.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
 
late int price;
double totalPrice=0;
late Stream<QuerySnapshot> cartItemsStream;

 DateTime? _startDate;
  DateTime? _endDate;
  int _duration = 0;

  @override
  void initState() {
    super.initState();
     // basePrice = widget.infoDetails['price'] ?? 0;
      cartItemsStream = getCartItems();
  }



    final user = FirebaseAuth.instance.currentUser;
  
  Stream<QuerySnapshot> getCartItems() {
    if (user == null) return const Stream.empty();
    return FirebaseFirestore.instance
        .collection('carts')
        .doc(user!.uid)
        .collection('items')
        .snapshots();
  }

  void updateCartQuantity(String productId, int change) async {
    final cartRef = FirebaseFirestore.instance
        .collection('carts')
        .doc(user!.uid)
        .collection('items')
        .doc(productId);

    final cartItem = await cartRef.get();
    if (cartItem.exists) {
      final currentQuantity = cartItem['quantity'] ?? 1;
      if (currentQuantity + change > 0) {
        cartRef.update({'quantity': currentQuantity + change});
      } else {
        cartRef.delete(); // Remove item if quantity reaches 0
      }
    }
  }

  void removeFromCart(String productId) {
    FirebaseFirestore.instance
        .collection('carts')
        .doc(user!.uid)
        .collection('items')
        .doc(productId)
        .delete();
  }

Future<void> checkout() async {
  if (user == null) return;

  // Check if both dates are selected
  if (_startDate == null || _endDate == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please select both pickup and return dates")),
    );
    return;
  }

  // Fetch all cart items
  final cartItems = await FirebaseFirestore.instance
      .collection('carts')
      .doc(user!.uid)
      .collection('items')
      .get();

  if (cartItems.docs.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Your cart is empty")),
    );
    return;
  }

  // Format pickup and return dates
  final startDateFormatted = DateTime(_startDate!.year, _startDate!.month, _startDate!.day);
  final endDateFormatted = DateTime(_endDate!.year, _endDate!.month, _endDate!.day);
  final duration = _duration;

  // Process each cart item separately
  for (var item in cartItems.docs) {
    final ticketNumber = generateTicketNumber(); // Unique ticket for each item
    final price = item['price'] ?? 0;
    final quantity = item['quantity'] ?? 1;
    final title = item['title'] ?? 'Unknown';
    final image = item['image'] ?? '';

    // Create a separate order for each item
    await FirebaseFirestore.instance.collection('orders').doc(ticketNumber).set({
      'ticketNumber': ticketNumber,
      'userId': user!.uid,
      'orderDate': Timestamp.now(),
      'totalPrice': price * quantity,
      'item': {
        'itemId': item.id,
        'title': title,
        'price': price,
        'quantity': quantity,
        'duration': duration,
        'pickupDate': startDateFormatted,
        'returnDate': endDateFormatted,
        'image': image,
      }
    });

    // Remove the item from the cart after checkout
    await item.reference.delete();

      Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => Orders(), // Display generic confirmation
    ),
  );
  }

  
 
}


String generateTicketNumber() {
  final random = Random();
  int randomDigits = random.nextInt(90000) + 10000; // Generates a 5-digit number between 10000 and 99999
  return 'dotby$randomDigits'; // Concatenates 'dotby' with the 5 random digits
}

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat('#,###');

    return Scaffold(
      appBar: AppBar(backgroundColor:const Color.fromARGB(255, 31, 33, 37),
      title: Text('Cart',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.white),),),
      body:StreamBuilder(
        stream: getCartItems(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Your cart is empty", style: GoogleFonts.mulish(color: Colors.white)));
          }

          final cartItems = snapshot.data!.docs;
              double calculatedTotalPrice = 0;

          // Calculate total price based on the fetched cart items
          for (var item in cartItems) {
            final price = item['price'] ?? 0;
            final quantity = item['quantity'] ?? 1;
            calculatedTotalPrice += price * quantity;
          }


          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('CART SUMMARY', style: GoogleFonts.mulish(fontSize: 15, color: Colors.white)),
                      Text('Total: ₦${formatter.format(calculatedTotalPrice)}', style: GoogleFonts.mulish(fontSize: 15, color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    final price = item['price'] ?? 0;
                    
                    final quantity = item['quantity'] ?? 1;
                   final itemPrice = price * quantity;
                    totalPrice += itemPrice; 

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:Column(children: [
 Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(item['image'], height: 80, width: 80, fit: BoxFit.cover),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['title'].length > 20 ? item['title'].substring(0, 20) + '...' : item['title'], style: GoogleFonts.mulish(fontSize: 16, color: Colors.white),
                                ),
                                Text("₦${formatter.format(itemPrice)}", style: TextStyle(color: Colors.white)),
                                      Text(_startDate != null && _endDate != null
            ? 'Duration: $_duration days'
            : 'Select dates',style: TextStyle(color: Colors.white),),
                     SizedBox(height: 10,),
                     Row(
          mainAxisSize: MainAxisSize.min,
          children: [
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
      onPressed: () => updateCartQuantity(item.id, -1),
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

       
     
            // Quantity Display
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '$quantity',
                style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
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
      onPressed:  () => updateCartQuantity(item.id, 1), 
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
           
        
          ],
        ),
SizedBox(height: 10,)
              
                                // Row(
                                //   children: [
                                //     IconButton(
                                //       icon: Icon(Icons.remove, color: Colors.white),
                                //       onPressed: () => updateCartQuantity(item.id, -1),
                                //     ),
                                //     Text(quantity.toString(), style: TextStyle(color: Colors.white, fontSize: 18)),
                                //     IconButton(
                                //       icon: Icon(Icons.add, color: Colors.white),
                                //       onPressed: () => updateCartQuantity(item.id, 1),
                                //     ),
                                //   ],
                                // ),
                        
              
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => removeFromCart(item.id),
                            ),
                          ],
                        ),
                                   Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
    height: 40,
        width: 150,
        decoration: BoxDecoration(
        color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.white,width: 1)
        ),
child:  
            TextButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(Duration(days: 2)),
                  firstDate: DateTime.now().add(Duration(days: 2)),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  setState(() {
                    _startDate = selectedDate;
                    _endDate = null; // Reset end date if start date is changed
                      _duration = 0;
                  });
                }
              },
              child: Text(_startDate == null ? 'Pickup Date' : _startDate!.toLocal().toString().split(' ')[0],style: TextStyle(color: Colors.white,fontSize: 15)),
            )),
            SizedBox(width: 20),
            Container(
    height: 40,
        width: 150,
        decoration: BoxDecoration(
        color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.white,width: 1)
        ),
child:     TextButton(
              onPressed: _startDate == null ? null : () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _startDate!.add(Duration(days: 1)),
                  firstDate: _startDate!.add(Duration(days: 1)),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  setState(() {
                    _endDate = selectedDate;
                    _duration = _endDate!.difference(_startDate!).inDays;
                  });
                }
              },
              child: Text(_endDate == null ? 'Return Date' : _endDate!.toLocal().toString().split(' ')[0],style: TextStyle(color: Colors.white,fontSize: 15),),
            ),
   
  )
      
],)
                        ],)
                        
                        
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),

    
                // SizedBox(height: 50),
              ],
              
            ),
            
          );
        },
      ),
floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
             floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check_outlined,color: Colors.white,),
        backgroundColor: Color.fromARGB(155,29, 31, 35),
        foregroundColor: Color.fromARGB(255,19, 20, 22),
        onPressed:()async {
           await checkout();

},
      ),
    );
  }
}


