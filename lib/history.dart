import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
  Future<List<Map<String, dynamic>>> fetchOrderHistory() async {
  
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  if (userId == null) {
  
    return []; // If there's no user logged in, return an empty list
  }

  // Fetch only the bookings made by the current user
  QuerySnapshot snapshot = await _firestore
      .collection('order_history')
      .where('userId', isEqualTo: userId) // Assuming 'userId' field is in the bookings collection
      .get();

  print("Fetched ${snapshot.docs.length} bookings for user $userId.");


   return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final item = data['item'] as Map<String, dynamic>?;
  
      return {
         'ticketNumber': doc.id,
         'returned':doc['returned'],
        'title': item?['title'],
        'price': item?['price'],
        'image': item?['image'],
        'quantity': item?['quantity'],
          'pickupDate': item?['pickupDate'],
          'returnedDate': doc['returnedDate'],
      'returnDate': item?['returnDate'],
      'poster_url': item?['image'],

      };
  }).toList();
}
  @override
  Widget build(BuildContext context) {
     final NumberFormat formatter = NumberFormat('#,###');
    return Scaffold(
      appBar: AppBar(title: Text('Order History'),),
      body:FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchOrderHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading order history.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tickets found.'));
          }
 final orderHistory = snapshot.data!;

          return ListView.builder(
            itemCount: orderHistory.length,
            itemBuilder: (context, index) {
              final order = orderHistory[index];
             // final items = item[index];
            final price = order['price'] ?? 0;
               String formattedPickupDate = order['pickupDate'] is Timestamp
                ? (order['pickupDate'] as Timestamp).toDate().toString().split(' ')[0]
                : 'N/A';
            String formattedReturnDate = order['returnDate'] is Timestamp
                ? (order['returnDate'] as Timestamp).toDate().toString().split(' ')[0]
                : 'N/A';
                String formattedReturnedDate = order['returnedDate'] is Timestamp
                ? (order['returnedDate'] as Timestamp).toDate().toString().split(' ')[0]
                : 'N/A';
             return ListTile(
                title: Text("Ticket Number: ${order['ticketNumber'] ?? 'N/A'}",style: TextStyle(color: Colors.white),),
                  subtitle:
                  Container(
        height: 170,
        width: double.infinity,
        decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.black,width: 1),
          
        ),
        child: Padding(padding: EdgeInsets.all(10),
        child: Row(children: [
            Image.network(order['image']??'', width: 100, height: 100),
 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                      
                        Text('${order['title'].length > 20 ? order['title'].substring(0, 20) + '...' : order['title']}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                      Text('₦${formatter.format(price)}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                      Text('Quantity: ${order['quantity'] ?? 'N/A'}',style: TextStyle(color: Colors.black)),
                      Text('Pickup Date: $formattedPickupDate',style: TextStyle(color: Colors.black)),
                      Text('Return Date: $formattedReturnDate',style: TextStyle(color: Colors.black)),
                       Text('Returned On: ${formattedReturnedDate ??''}',style: TextStyle(color: Colors.black)),
                      Text('                                  ${order['returned'] == true?'Returned':'Not Returned'}',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                    ],
                  ),
        ],)
        
       )
          
       ),
               
              );
            },
          );
        },
      ),
    );
  }
}