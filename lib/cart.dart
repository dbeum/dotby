import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotby1/confirm.dart';
import 'package:dotby1/main.dart';
import 'package:dotby1/orders.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
 
late double price;
double totalPrice=0;
late int stock;
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
  if (!cartItem.exists) return;

  final currentQuantity = cartItem['quantity'] ?? 1;
  final stock = cartItem['stock'] ?? 0; // read from cart, not products

  final newQuantity = currentQuantity + change;

  if (change > 0 && newQuantity <= stock) {
    cartRef.update({'quantity': newQuantity});
  } else if (change < 0 && newQuantity > 0) {
    cartRef.update({'quantity': newQuantity});
  } else if (newQuantity <= 0) {
    cartRef.delete();
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

  if (_startDate == null || _endDate == null) {
   showTopSnackBar(context, "Please select both pickup and return dates");
    return;
  }

  final cartRef = FirebaseFirestore.instance
      .collection('carts')
      .doc(user!.uid)
      .collection('items');

  final cartItems = await cartRef.get();

  if (cartItems.docs.isEmpty) {
    showTopSnackBar(context, "Your cart is empty");
    return;
  }

  final startDateFormatted = DateTime(_startDate!.year, _startDate!.month, _startDate!.day);
  final endDateFormatted = DateTime(_endDate!.year, _endDate!.month, _endDate!.day);
  final duration = _duration;

  WriteBatch batch = FirebaseFirestore.instance.batch();

  for (var item in cartItems.docs) {
    final ticketNumber = generateTicketNumber();
    final price = item['price'] ?? 0;
    final quantity = item['quantity'] ?? 1;
    final title = item['title'] ?? 'Unknown';
    final image = item['image'] ?? '';

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

    final productRef = FirebaseFirestore.instance.collection('products').doc(item.id);
    final productSnap = await productRef.get();

    if (productSnap.exists) {
      final currentStock = productSnap['stock'] ?? 0;
      await productRef.update({
        'stock': currentStock - quantity,
      });
    }

    // Add delete to batch
    batch.delete(item.reference);
  }

  // Commit all deletes at once
  await batch.commit();
_showNotification();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Orders()),
  );
}



String generateTicketNumber() {
  final random = Random();
  int randomDigits = random.nextInt(90000) + 10000; // Generates a 5-digit number between 10000 and 99999
  return 'dotby$randomDigits'; // Concatenates 'dotby' with the 5 random digits
}
 void _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'reminders_channel',
      'Reminders',
      channelDescription: 'Notifications for daily reminders',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@drawable/ic_stat_dn'
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Order Confirmed!',
      'Your order has been placed successfully.',
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat('#,###');

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
      title: Text('Cart',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.black),),),
      body:StreamBuilder(
        stream: getCartItems(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Your cart is empty", style: GoogleFonts.mulish(color: Colors.black)));
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
                      Text('CART SUMMARY', style: GoogleFonts.mulish(fontSize: 15, color: Colors.black)),
                      Text('Total: ₦${formatter.format(calculatedTotalPrice)}', style: GoogleFonts.mulish(fontSize: 15, color: Colors.black)),
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
                    final productId = item.id;
                    final stock = item['stock'] ?? 1; 
                    
                    final atMax = quantity >= stock;

                   final itemPrice = price * quantity;
                    totalPrice += itemPrice; 

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black,
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
      colors: [Colors.white, Colors.black], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      
      child: SizedBox(
    width: double.infinity, // Forces button to take full width
    height: double.infinity, // Forces button to take full height
    child: ElevatedButton(
      onPressed:quantity > 1 ? () => updateCartQuantity(productId, -1) : null,
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
      colors: [Colors.black, Colors.white], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
     child: SizedBox(
    width: double.infinity, // Forces button to take full width
    height: double.infinity, // Forces button to take full height
    child: ElevatedButton(
      onPressed:atMax ? null : () => updateCartQuantity(productId, 1),
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
        backgroundColor: Colors.black,
        foregroundColor: Color.fromARGB(255,19, 20, 22),
        onPressed:()async {
           await checkout();

},
      ),
    );
  }
}
