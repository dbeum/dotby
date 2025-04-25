import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotby1/info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Zoomlenses extends StatefulWidget {
  const Zoomlenses({super.key});

  @override
  State<Zoomlenses> createState() => _ZoomlensesState();
}

class _ZoomlensesState extends State<Zoomlenses> {
 // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
   
Future<List<Map<String, dynamic>>> fetchZoomlenses() async {
  
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('products') // Main products collection
        .doc('Zoomlenses') // The "events" category
        .collection('items') // The actual products
        .get();

    return snapshot.docs.map((doc) {
      return {
        'id': doc.id, // Document ID
        ...doc.data() as Map<String, dynamic>, // Product details
      };
    }).toList();
  
}

  
  @override
  Widget build(BuildContext context) {
    return   FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchZoomlenses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error fetching data'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data found'));
              }

              List<Map<String, dynamic>> ZoomlensesItems = snapshot.data!;

              return 
           Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10),
        
             child: Wrap(
                 spacing: 30,
                 runSpacing: 20,
                 alignment: WrapAlignment.center,
                             children: ZoomlensesItems.map((Zoomlenses){
                 
                 
String formattedPrice = NumberFormat('#,##0').format(Zoomlenses['price'] ?? 0);
                 return  Container(height: 200,
    width: 150,
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Info(infoDetails: Zoomlenses))),
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Change button color
    foregroundColor: Colors.white, // Change text/icon color
  //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Round edges
    ),
    elevation: 5, // Add shadow effect
  ),
       child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        ClipRRect(
  borderRadius: BorderRadius.circular(12), // Adjust radius as needed
  child: Zoomlenses['profileImage'] != null && Zoomlenses['profileImage'].toString().isNotEmpty
      ? Image.network(
          Zoomlenses['profileImage'],
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        )
      : Image.asset(
          'assets/images/logo.png',
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
),
           Text(Zoomlenses['name']??'',style: GoogleFonts.aDLaMDisplay(fontSize:15,fontWeight:FontWeight.bold, color: Colors.white),
         maxLines:1,
         overflow: TextOverflow.ellipsis,
        ),
        
            Text('₦$formattedPrice',style: GoogleFonts.mulish(fontSize:15,fontWeight:FontWeight.bold, color: Colors.white),),
       ],),
      ));
                     }).toList()
                 ));
                  },
                      );
  }
}