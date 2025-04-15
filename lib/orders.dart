import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotby1/confirm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Orders extends StatefulWidget {
  
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

late Future<List<Map<String, dynamic>>> futureOrders; // Define the future here

@override
void initState() {
  super.initState();
  futureOrders = fetchOrders(); // Initialize it in initState
}

Future<List<Map<String, dynamic>>> fetchOrders() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return []; // Return empty if no user is logged in

  // Fetch only the orders of the logged-in user
  QuerySnapshot snapshot = await _firestore
      .collection('orders')
      .where('userId', isEqualTo: user.uid) // Filter for user-specific orders
      .get();

  print("Fetched ${snapshot.docs.length} orders for user: ${user.uid}");

  // Convert documents to a list of maps
  return snapshot.docs.map((doc) {
    return {
      'id': doc.id, // Document ID (Order ID)
      ...doc.data() as Map<String, dynamic> // Order details
    };
  }).toList();
}

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
       backgroundColor:const Color.fromARGB(255, 31, 33, 37),
        elevation: 0,
      ),
      body:  Column(
       // mainAxisAlignment: MainAxisAlignment.center,
        children: [
Center(child:  Image.asset('assets/images/profile.png',height: 100,),),
 SizedBox(height: 10,),
 Text('ORDERS',style:GoogleFonts.signika(textStyle: TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.bold),)),
SizedBox(height: 10,),
Padding(padding: EdgeInsets.all(10),child: Text('Heads up! Before coming to pick up your order, kindly confirm with our customer rep on WhatsApp to avoid any delays. We got you!',
textAlign: TextAlign.justify,
softWrap: true,
style: GoogleFonts.signika(color: Colors.white),)),
 SizedBox(height: 20,),
Expanded(child: 
FutureBuilder<List<Map<String, dynamic>>>(
      future: futureOrders,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No orders found"));
        }

          final orders = snapshot.data!;

                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    final item = order['item'];
  final pickupDate = item['pickupDate'] != null
      ? (item['pickupDate'] as Timestamp).toDate()
      : null;
  
  final returnDate = item['returnDate'] != null
      ? (item['returnDate'] as Timestamp).toDate()
      : null;

  // Format the DateTime using DateFormat
  final formattedPickupDate = pickupDate != null
      ? DateFormat('yyyy-MM-dd').format(pickupDate)
      : 'Unknown';

  final formattedReturnDate = returnDate != null
      ? DateFormat('yyyy-MM-dd').format(returnDate)
      : 'Unknown';

      String formattedPrice = NumberFormat('#,##0').format(order['totalPrice'] ?? 0);
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                     
                      height: 100,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(155, 114, 117, 129),
                            Color.fromARGB(255, 29, 31, 35)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Confrimorder(orderDetails:order))),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                          
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            
                          ),
                          
                          elevation: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                               Text(
                '${item['title']?.length > 15 ? item['title'].substring(0, 15) + "..." : item['title']}',
                style: GoogleFonts.aDLaMDisplay(fontSize: 20, color: Colors.white),
              ),
              Text(
                'Pickup Date: $formattedPickupDate',
                style: GoogleFonts.aDLaMDisplay(fontSize: 10, color: Colors.white),
              ),
              Text(
                'Return Date: $formattedReturnDate',
                style: GoogleFonts.aDLaMDisplay(fontSize: 10, color: Colors.white),
              ),
              Text(
                'Quantity: ${item['quantity']}',
                style: GoogleFonts.aDLaMDisplay(fontSize: 10, color: Colors.white),
              ),
          
                              ],
                            ),
                            Text(
                              "₦$formattedPrice",
                              style: GoogleFonts.aDLaMDisplay(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}