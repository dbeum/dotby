import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    
      appBar: AppBar(elevation: 0,   backgroundColor:Colors.white,
      ),
      body: Center(child: Column(
children: [
  Image.asset('assets/images/darts.png',height: 100,),
   Text('OUR MISSION',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.black),),
  Container(margin: EdgeInsets.all(30),
   child:  Text('We want to constantly deploy the best, up-to-date state-of-the-art media equipment and professional manpower in the industry to keep the customers delighted with innovation and sophistication. We will be relentless and go the extra mile to deliver qualitative service in partnership with our corporate, individual clients and professionals in the industry',style: GoogleFonts.mulish(fontSize:15,color: Colors.black),
               textAlign: TextAlign.justify, 
             softWrap: true,),),
             SizedBox(height: 20,),
             Image.asset('assets/images/vision.png',height: 100,),
   Text('OUR VISION',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.black),),
  Container(margin: EdgeInsets.all(30),
   child:  Text('As a one-stop media shop, we want our clients to have the best of media experience that leaves our brand permanently on their mind',style: GoogleFonts.mulish(fontSize:15,color: Colors.black),
               textAlign: TextAlign.justify, 
             softWrap: true,),),
],
      ),),
    );
  }
}