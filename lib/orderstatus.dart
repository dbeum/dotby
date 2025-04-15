import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Return extends StatefulWidget {
  const Return({super.key});

  @override
  State<Return> createState() => _ReturnState();
}
String shortenText(String text, int maxChars) {
  if (text.length <= maxChars) return text;
  return text.substring(0, maxChars) + '...';
}

Future<void> markAsReturned(String orderId) async {
  try {
    final docRef = FirebaseFirestore.instance.collection('order_history').doc(orderId);

    await docRef.update({
      'returned': true,
      'returnedDate': FieldValue.serverTimestamp(), // Adds current server time
    });

    print('Order marked as returned with date');
  } catch (e) {
    print('Error marking order as returned: $e');
  }
}

 Widget buildOrderTile(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final item = data['item'];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.network(item['image'], width: 80, height: 80, fit: BoxFit.cover),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] ?? 'No title',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('Ticket: ${data['ticketNumber']}'),
                Text('Quantity: ${item['quantity']}'),
                  Text('Pickup: ${DateTime.fromMillisecondsSinceEpoch(item['pickupDate'].millisecondsSinceEpoch).toString().split(" ")[0]}'),
                Text('Return: ${DateTime.fromMillisecondsSinceEpoch(item['returnDate'].millisecondsSinceEpoch).toString().split(" ")[0]}'),
                Text('Returned: ${data['returned'] ? "Yes" : "No"}'),
                if (data['returned'] == true && data['returnedDate'] != null)
                  Text('Returned On: ${DateTime.fromMillisecondsSinceEpoch(data['returnedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}'),
              ],
            ),
          ),
          if (data['returned'] == false) // Show only if not yet returned
            TextButton(
              onPressed: () => markAsReturned(doc.id),
              child: const Text("Mark Returned",style: TextStyle(color:Colors.red,fontSize: 10),),
            ),
        ],
      ),
    );
  }

class _ReturnState extends State<Return> {
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(title: Text('Order Status'),),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('order_history').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());

          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
            return const Center(child: Text('No orders found.'));

          final docs = snapshot.data!.docs;
          final notReturned = docs.where((doc) => doc['returned'] == false).toList();
          final returned = docs.where((doc) => doc['returned'] == true).toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (notReturned.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Not Returned", style: TextStyle(fontSize: 18,color:Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  ...notReturned.map(buildOrderTile).toList(),
                ],
                if (returned.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Returned", style: TextStyle(fontSize: 18,color:Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  ...returned.map(buildOrderTile).toList(),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
