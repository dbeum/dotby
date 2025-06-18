import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Vendorrequest extends StatefulWidget {
  const Vendorrequest({super.key});

  @override
  State<Vendorrequest> createState() => _VendorrequestState();
}

Future<void> markAsReturned(String vendorsId) async {
  try {
    final docRef = FirebaseFirestore.instance.collection('vendors').doc(vendorsId);

    await docRef.update({
      'contacted': true,
      'approvedDate': FieldValue.serverTimestamp(), // Adds current server time
    });

    print('Order marked as returned with date');
  } catch (e) {
    print('Error marking order as returned: $e');
  }
}
Future<void> rejectVendor(String vendorsId) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('vendors').doc(vendorsId);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Simply delete the order from the "orders" collection
        await docRef.delete();

        print('Order rejected and deleted from active orders.');
       
      }
    } catch (e) {
      print('Error rejecting order: $e');
    }
  }
class _VendorrequestState extends State<Vendorrequest> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('vendors') // Firestore collection
      .snapshots(),  // This gives you a stream of data
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator()); // Show loading spinner
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}')); // Show error message
    } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Center(child: Text('No Vendor found.',style: TextStyle(color:Colors.white),));
    } else {
    var vendor = snapshot.data!.docs
      .where((doc) => doc['contacted'] == false)
      .toList();

  if (vendor.isEmpty) {
    return Center(
      child: Text('No Vendor requests found.', style: TextStyle(color: Colors.white)),
    );
  }
  

      return ListView.builder(
        itemCount: vendor.length,
        itemBuilder: (context, index) {
          var vendors = vendor[index];
         //     if (vendors['contacted'] == false) {
          return ListTile(
            
            title:
            
            Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(12),
      
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
         
          const SizedBox(width: 12),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            vendors['profileImage'] != null && vendors['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendors['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                Text(
                  vendors['businessName'] ?? 'No title',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('Owner: ${vendors['ownerName']}'),
                Text('Email: ${vendors['email']}'),
                  Text('Phone: ${vendors['number']}'),
                Text('Business Type: ${vendors['businessType']}'),
                if(vendors['businessType']=='Other')
             Text('${vendors['other']}' ,style: TextStyle(fontSize: 16,color: Colors.black),),
                SizedBox(height: 5,),
                SelectableText('Description: ${vendors['description']}'),
                  SizedBox(height: 5,),
               Text('Loaction: ${vendors['location']}'),
               Text('Approved: ${vendors['contacted'] ? "Yes" : "No"}'),
             
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                     TextButton(
              onPressed: () => rejectVendor(vendors.id),
              child: const Text("Reject",style: TextStyle(color:Colors.red,fontSize: 15),),
            ),
                   TextButton(
              onPressed: () => markAsReturned(vendors.id),
              child: const Text("Approve",style: TextStyle(color:Colors.green,fontSize: 15),),
            ),
                 ],)
           
              ],
            ),
          ),
       
        ],
      ),
    )
          );
 
        },
      );
    }
  },
),
    );
  }
}