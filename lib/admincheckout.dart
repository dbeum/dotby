import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextEditingController _ticketNumberController = TextEditingController();
  bool loading = false;
  bool orderFound = false;
  double? totalPrice;
  List<Map<String, dynamic>> items = [];
  String ticketNumber = ''; // To store the ticket number entered by the admin

  // Fetch order data based on ticket number
  Future<void> fetchOrder(String ticketNumber) async {
    setState(() {
      loading = true;
      totalPrice = null;
      items = [];
      orderFound = false;
    });

    try {
      final docRef = FirebaseFirestore.instance.collection('orders').doc(ticketNumber);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        totalPrice = (data?['totalPrice'] ?? 0).toDouble();

        final itemData = data?['item'] as Map<String, dynamic>?;
        if (itemData != null) {
         

          items = [
            {
              'title': itemData['title'],
              'price': (itemData['price'] ?? 0).toDouble(),
               'image': itemData['image'],
               'quantity': itemData['quantity'],
            }
          ];
          setState(() {
            orderFound = true;
          });
          
        } else {
         
        }
      } else {
     
      }
    } catch (e) {
  
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

 Future<void> confirmOrder(String ticketNumber) async {
  try {
    final docRef = FirebaseFirestore.instance.collection('orders').doc(ticketNumber);

    // First update the document with returnedDate and returned flag
    await docRef.update({
      'returned': false,
      'returnedDate': null,
    });

    // Now fetch the updated data
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      if (data != null) {
        // Move to order_history
        await FirebaseFirestore.instance
            .collection('order_history')
            .doc(ticketNumber)
            .set(data);

        await docRef.delete();

        print('Order confirmed and moved to history.');
        setState(() {
          orderFound = false;
        });
      }
    }
  } catch (e) {
    print('Error confirming order: $e');
  }
}


  // Reject Order handler (Delete from active orders)
  Future<void> rejectOrder(String ticketNumber) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('orders').doc(ticketNumber);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Simply delete the order from the "orders" collection
        await docRef.delete();

        print('Order rejected and deleted from active orders.');
        setState(() {
          orderFound = false; // Optionally reset UI after rejection
        });
      }
    } catch (e) {
      print('Error rejecting order: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat('#,###');
    return Scaffold(
      appBar: AppBar(title: Text('Admin - Checkout')),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                
                  TextField(
                    controller: _ticketNumberController,
                    style: TextStyle(color:Colors.white),
                    decoration: InputDecoration(
                    
                      labelText: 'Enter Ticket Number',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    onChanged: (value) {
                      ticketNumber = value;
                    },
                  ),
                  SizedBox(height: 20),
                       
       Container(
        height: 35,
        width: 150,
        decoration: BoxDecoration(
        color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.white,width: 1)
        ),
        child: TextButton(
                    onPressed: () {
                      fetchOrder(ticketNumber);
                    },
                    child: Text('Fetch Order',style: TextStyle(color: Colors.white),),
                  ),
          
       ),
 
                  
                  SizedBox(height: 20),
                 
                
                  orderFound
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ticket Number: $ticketNumber',style: TextStyle(color: Colors.white)),
                            SizedBox(height: 10),
                            Text('Total Price: ₦${formatter.format(totalPrice)}',style: TextStyle(color: Colors.white)),
                            SizedBox(height: 20),
                            ...items.map((item) {
                              return ListTile(
                                title: Text(item['title'],style: TextStyle(color: Colors.white)),
                                subtitle: 
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
       Image.network(item['image']??'', width: 100, height: 100),
                                  Text('Price: ₦${formatter.format(totalPrice)}',style: TextStyle(color: Colors.white)),
                                      Text('Quantity: ${item['quantity']}',style: TextStyle(color: Colors.white))
                                ],),
                              );
                            }).toList(),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () => confirmOrder(ticketNumber),
                                  child: Text('Confirm Order',style: TextStyle(color: Colors.black)),
                                ),
                                ElevatedButton(
                                  onPressed: () => rejectOrder(ticketNumber),
                                  child: Text('Reject Order',style: TextStyle(color: Colors.white)),
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Text('Order not found, or please enter a valid ticket number',style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
    );
  }
}
