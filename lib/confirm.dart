import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
class Confrimorder extends StatefulWidget {

   final Map<String, dynamic> orderDetails;
  const Confrimorder({super.key,required this.orderDetails});

  @override
  State<Confrimorder> createState() => _ConfrimorderState();
}

class _ConfrimorderState extends State<Confrimorder> {
  @override
  Widget build(BuildContext context) {
     // print(widget.orderDetails);

        final item = widget.orderDetails['item'];
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
      String formattedPrice = NumberFormat('#,##0').format(widget.orderDetails['totalPrice'] ?? 0);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Order Confirmation',style: TextStyle(color: Colors.white),),
        backgroundColor:const Color.fromARGB(255, 31, 33, 37),
      ),
      body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Ticket Number: ${widget.orderDetails['ticketNumber']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
              //  Text('Total Price: ₦${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                Text('Order Details:', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
               
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Image.network(item['image'], width: 100, height: 100),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['title'].length > 20 ? item['title'].substring(0, 20) + '...' : item['title'],style:GoogleFonts.signika(textStyle: TextStyle(fontSize: 20,color:Colors.black,fontWeight: FontWeight.bold),)),
                              Text('₦${formattedPrice}', style: TextStyle(fontSize: 14)),
                              Text('Quantity: ${item['quantity']}', style: TextStyle(fontSize: 14)),
                              Text('Duration: ${item['duration']} days', style: TextStyle(fontSize: 14)),
                              Text('Pickup Date: ${formattedPickupDate}', style: TextStyle(fontSize: 14)),
                              Text('Return Date: ${formattedReturnDate}', style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ],
                      )
                    )
              ]
            )
         
          
      
    
    ));
  }
}




// Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Ticket Number: $ticketNumber', style: TextStyle(fontSize: 18)),
//                 SizedBox(height: 20),
//                 Text('Total Price: ₦${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
//                 SizedBox(height: 20),
//                 Text('Order Details:', style: TextStyle(fontSize: 18)),
//                 SizedBox(height: 10),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: items.length,
//                   itemBuilder: (context, index) {
//                     final item = items[index];
//                     final pickupDate = item['pickupDate'] != null
//                         ? dateFormat.format((item['pickupDate'] as Timestamp).toDate())
//                         : 'N/A';

//                     final returnDate = item['returnDate'] != null
//                         ? dateFormat.format((item['returnDate'] as Timestamp).toDate())
//                         : 'N/A';
                    
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Row(
//                         children: [
//                           Image.network(item['image'], width: 50, height: 50),
//                           SizedBox(width: 10),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(item['title'].length > 20 ? item['title'].substring(0, 20) + '...' : item['title'], style: TextStyle(fontSize: 16)),
//                               Text('₦${(item['price'] * item['quantity']).toStringAsFixed(2)}', style: TextStyle(fontSize: 14)),
//                               Text('Quantity: ${item['quantity']}', style: TextStyle(fontSize: 14)),
//                               Text('Duration: ${item['duration']} days', style: TextStyle(fontSize: 14)),
//                               Text('Pickup Date: $pickupDate', style: TextStyle(fontSize: 14)),
//                               Text('Return Date: $returnDate', style: TextStyle(fontSize: 14)),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );