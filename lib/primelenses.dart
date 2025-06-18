import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotby1/info/info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Primelenses extends StatefulWidget {
  const Primelenses({super.key});

  @override
  State<Primelenses> createState() => _PrimelensesState();
}

class _PrimelensesState extends State<Primelenses> {

  
Future<List<Map<String, dynamic>>> fetchPrimelenses() async {
  
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('products') 
        .doc('Primelenses') 
        .collection('items')
        .get();

    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>, 
      };
    }).toList();
  
}
  @override
  Widget build(BuildContext context) {
   
    return   FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchPrimelenses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error fetching data'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data found',style: TextStyle(color:   Colors.black)));
              }

              List<Map<String, dynamic>> PrimelensesIems = snapshot.data!;

              return 
           Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10),
        
             child: Wrap(
                 spacing: 30,
                 runSpacing: 20,
                 alignment: WrapAlignment.center,
                             children: PrimelensesIems.map((Primelenses){
                 
                    
String formattedPrice = NumberFormat('#,##0').format(Primelenses['price'] ?? 0);
                 return  Container(height: 200,
    width: 150,
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(255,114, 117, 129), Color.fromARGB(255,29, 31, 35)], 
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
      ),
      child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Info(infoDetails: Primelenses))),
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white, 

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), 
    ),
    elevation: 5, 
  ),
       child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
     ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: Primelenses['profileImage'] != null && Primelenses['profileImage'].toString().isNotEmpty
      ? Image.network(
          Primelenses['profileImage'],
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

           Text(Primelenses['name']??'',style: GoogleFonts.aDLaMDisplay(fontSize:15,fontWeight:FontWeight.bold, color: Colors.white),
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