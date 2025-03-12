import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:dotby1/about.dart';
import 'package:dotby1/info.dart';
import 'package:dotby1/login.dart';
import 'package:dotby1/primelenses.dart';
import 'package:dotby1/register.dart';
import 'package:dotby1/search.dart';

import 'package:dotby1/talk.dart';
import 'package:dotby1/zoomlenses.dart';
import 'package:dotby1/lenses.dart';
import 'package:dotby1/youtubeplayer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

   final Color navigationBarColor = const Color.fromARGB(255, 40, 42, 47);
  int selectedIndex = 0;
  late PageController pageController;
  int _selectedIndex = 0;

 bool _isSearching = false;
  TextEditingController searchController = TextEditingController();
  List<String> _items = ["", "", ""]; // Example items
  List<String> _filteredItems = [];
  
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
     _filteredItems = _items;
  }
   void _startSearch(String query) {
    setState(() {
      _filteredItems = _items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
final Uri whatsappUrl = Uri.parse('https://wa.me/+2348173211336');

 
  Future<void> _launchwhatsapp() async {
    // Use launchUrl for web compatibility
    if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $whatsappUrl';
    }
  }

final Uri stockUrl = Uri.parse('https://mediacreatorsplace.com/');

 
  Future<void> _launchstock() async {
    // Use launchUrl for web compatibility
    if (!await launchUrl(stockUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $stockUrl';
    }
  }
   final String email = 'info@dotbyproductions.com';

 
  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: Uri.encodeFull('subject=Hello&body=I would like to reach you regarding...'), // optional pre-filled subject and body
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not open email app';
    }
  }

  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchPhotos() async {
    // Fetch all movie documents
    QuerySnapshot snapshot = await _firestore.collection('photos').get();

    // Convert documents to a list of maps, including the document ID (movie name)
    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,  // The movie name (Alien, for example)
        ...doc.data() as Map<String, dynamic> // The rest of the movie details
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> fetchLenses() async {
    // Fetch all movie documents
    QuerySnapshot snapshot = await _firestore.collection('lenses').get();

    // Convert documents to a list of maps, including the document ID (movie name)
    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,  // The movie name (Alien, for example)
        ...doc.data() as Map<String, dynamic> // The rest of the movie details
      };
    }).toList();
  }

    Future<List<Map<String, dynamic>>> fetchLights() async {
    // Fetch all movie documents
    QuerySnapshot snapshot = await _firestore.collection('Lights').get();

    // Convert documents to a list of maps, including the document ID (movie name)
    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,  // The movie name (Alien, for example)
        ...doc.data() as Map<String, dynamic> // The rest of the movie details
      };
    }).toList();
  }

     Future<List<Map<String, dynamic>>> fetchAccessories() async {
    // Fetch all movie documents
    QuerySnapshot snapshot = await _firestore.collection('Accessories').get();

    // Convert documents to a list of maps, including the document ID (movie name)
    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,  // The movie name (Alien, for example)
        ...doc.data() as Map<String, dynamic> // The rest of the movie details
      };
    }).toList();
  }


   Future<List<Map<String, dynamic>>> fetchEvent() async {
    // Fetch all movie documents
    QuerySnapshot snapshot = await _firestore.collection('Event').get();

    // Convert documents to a list of maps, including the document ID (movie name)
    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,  // The movie name (Alien, for example)
        ...doc.data() as Map<String, dynamic> // The rest of the movie details
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
 
   return Scaffold(
    appBar:  AppBar(
        backgroundColor:const Color.fromARGB(255, 31, 33, 37),
        elevation: 0,
         title:
        _isSearching
      ? TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: "I'm Shopping for...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white),
          onChanged: _startSearch,
        )
      : 
          Stack(children: [
          
          Image.asset('assets/images/logo1.png', height: 65)
         ],), 
        actions: [ 
            IconButton(
            icon: Icon(
        _isSearching ? Icons.close : Icons.search,
        size: 24,
        color: Colors.white,
      ),
      onPressed: () {
        setState(() {
          _isSearching = !_isSearching;
          if (!_isSearching) {
            searchController.clear();
            _filteredItems = _items; // Reset the list
          }
        });
      },
    ),
            TextButton(onPressed: () {
              
            }, child:const Icon(Icons.shopping_bag_outlined,size: 30,color: Colors.white,)
            //Image.asset('assets/images/search.png')
            
        )],
      ),
    body:Stack(
        children: [
          
          Visibility(
            visible: !_isSearching,
            child:  PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[


            //HOME PAGE


         Container(
            child:   SingleChildScrollView(
              child:
      Column(children: [
     
     Container(
      margin: EdgeInsets.all(20),
      height:190 ,width: 350,
     
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(18)),
       gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('DOTBY',style: GoogleFonts.aDLaMDisplay(fontSize:30,color: Colors.white),),
      SizedBox(height: 5,),
      Container(height: 35,
      decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed: () {
        
      },
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Change button color
    foregroundColor: Colors.white, // Change text/icon color
  //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Round edges
    ),
    elevation: 5, // Add shadow effect
  ),
       child: const Text('Explore now',style: TextStyle(color: Colors.white),)),
      )
      ],),
    Image.asset('assets/images/banner.png',height: 150)
    ],
    ) ,
     ),
     SizedBox(height: 10,),
     Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 15,),
      Text('Event Coverage',style: GoogleFonts.inter(fontSize:20,fontWeight:FontWeight.bold, color: Colors.white),),
     
   
     ],),
      SizedBox(height: 20,),
       FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchEvent(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error fetching data'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data found'));
              }

              List<Map<String, dynamic>> Event = snapshot.data!;

              return 
           Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10),
        
             child: Wrap(
                 spacing: 30,
                 runSpacing: 20,
                 alignment: WrapAlignment.center,
                             children: Event.map((Event){
                 
                    // Fetch 'poster_url' from the nested document data
                    String? posterUrl = Event['poster_url'] ; // Adjust field name to match your database
String formattedPrice = NumberFormat('#,##0').format(Event['price'] ?? 0);
                 return  Container(height: 200,
    width: 150,
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Info(infoDetails:Event))),
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
posterUrl != null
    ? CachedNetworkImage(
        imageUrl: posterUrl,
        
      )
    : Image.asset(
        'assets/images/logo.png',  // Use a local placeholder image
      ),

        
            Text('₦$formattedPrice',style: GoogleFonts.aDLaMDisplay(fontSize:15,fontWeight:FontWeight.bold, color: Colors.white),),
       ],),
      ));
                     }).toList()
                 ));
                  },
                      ),
       
     
      
      SizedBox(height: 25,),
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       
      Text('Photo & Video Equipment Rentals',style: GoogleFonts.inter(fontSize:20,fontWeight:FontWeight.bold, color: Colors.white),),
      
     
   
     ],),
      SizedBox(height: 5,),
      Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 15,),
      Text('Cameras',style: GoogleFonts.inter(fontSize:20,fontWeight:FontWeight.bold, color: Colors.white),),
      
     
   
     ],),
     SizedBox(height: 20,),
               FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchPhotos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error fetching data'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data found'));
              }

              List<Map<String, dynamic>> photos = snapshot.data!;

              return 
           Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10),
        
             child: Wrap(
                 spacing: 30,
                 runSpacing: 20,
                 alignment: WrapAlignment.center,
                             children: photos.map((photos){
                 
                    // Fetch 'poster_url' from the nested document data
                    String? posterUrl = photos['poster_url'] ; // Adjust field name to match your database
String formattedPrice = NumberFormat('#,##0').format(photos['price'] ?? 0);
                 return  Container(height: 200,
    width: 150,
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Info(infoDetails: photos))),
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
          posterUrl != null
                            ? Image.network(
                                posterUrl,
                              
                              )
                            : Image.asset(
                                'assets/images/logo.png',  // Use a local placeholder image
                               
                              ),
           Text(photos['name']??'',style: GoogleFonts.aDLaMDisplay(fontSize:15,fontWeight:FontWeight.bold, color: Colors.white),
         maxLines:1,
         overflow: TextOverflow.ellipsis,
        ),
        
            Text('₦$formattedPrice',style: GoogleFonts.aDLaMDisplay(fontSize:15,fontWeight:FontWeight.bold, color: Colors.white),),
       ],),
      ));
                     }).toList()
                 ));
                  },
                      ),
                      SizedBox(height: 10,),
      Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 15,),
      Text('Lenses',style: GoogleFonts.inter(fontSize:20,fontWeight:FontWeight.bold, color: Colors.white),),
      
     
   
     ],),
     SizedBox(height: 20,),
            CustomSlidingSegmentedControl<int>(
            initialValue: _selectedIndex,
            children: {
              0: Text("All",style: GoogleFonts.mulish(fontSize:15,color: Colors.white)),
              1: Text("Prime",style: GoogleFonts.mulish(fontSize:15,color: Colors.white)),
              2: Text("Zoom",style: GoogleFonts.mulish(fontSize:15,color: Colors.white))
            },
            
            decoration: BoxDecoration(
              color: Color.fromARGB(155,114, 117, 129),
              borderRadius: BorderRadius.circular(10),
            ),
            thumbDecoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            onValueChanged: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          const SizedBox(height: 20),

          // Display different content based on selected index
          _selectedIndex == 0 ? Lenses() : _selectedIndex == 1 ? Primelenses() : Zoomlenses(),

           SizedBox(height: 10,),
      Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 15,),
      Text('Lights',style: GoogleFonts.inter(fontSize:20,fontWeight:FontWeight.bold, color: Colors.white),),
      
     
   
     ],),
     SizedBox(height: 20,),
               FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchLights(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error fetching data'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data found'));
              }

              List<Map<String, dynamic>> lights = snapshot.data!;

              return 
           Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10),
        
             child: Wrap(
                 spacing: 30,
                 runSpacing: 20,
                 alignment: WrapAlignment.center,
                             children: lights.map((lights){
                 
                    // Fetch 'poster_url' from the nested document data
                    String? posterUrl = lights['poster_url'] ; // Adjust field name to match your database
String formattedPrice = NumberFormat('#,##0').format(lights['price'] ?? 0);
                 return  Container(height: 200,
    width: 150,
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Info(infoDetails:lights))),
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
          posterUrl != null
                            ? Image.network(
                                posterUrl,
                              
                              )
                            : Image.asset(
                                'assets/images/logo.png', 
                               
                              ),
           Text(lights['name']??'',style: GoogleFonts.aDLaMDisplay(fontSize:15,fontWeight:FontWeight.bold, color: Colors.white),
         maxLines:1,
         overflow: TextOverflow.ellipsis,
        ),
        
            Text('₦$formattedPrice',style: GoogleFonts.aDLaMDisplay(fontSize:15,fontWeight:FontWeight.bold, color: Colors.white),),
       ],),
      ));
                     }).toList()
                 ));
                  },
                      ),
                            SizedBox(height: 10,),
      Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 15,),
      Text('Accessories',style: GoogleFonts.inter(fontSize:20,fontWeight:FontWeight.bold, color: Colors.white),),
      
     
   
     ],),
     SizedBox(height: 20,),
               FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchAccessories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error fetching data'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data found'));
              }

              List<Map<String, dynamic>> accessories = snapshot.data!;

              return 
           Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10),
        
             child: Wrap(
                 spacing: 30,
                 runSpacing: 20,
                 alignment: WrapAlignment.center,
                             children: accessories.map((accessories){
                 
                    // Fetch 'poster_url' from the nested document data
                    String? posterUrl = accessories['poster_url'] ; // Adjust field name to match your database
String formattedPrice = NumberFormat('#,##0').format(accessories['price'] ?? 0);
                 return  Container(height: 200,
    width: 150,
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Info(infoDetails:accessories))),
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
          posterUrl != null
                            ? Image.network(
                                posterUrl,
                              
                              )
                            : Image.asset(
                                'assets/images/logo.png', 
                               
                              ),
           Text(accessories['name']??'',style: GoogleFonts.aDLaMDisplay(fontSize:15,fontWeight:FontWeight.bold, color: Colors.white),
         maxLines:1,
         overflow: TextOverflow.ellipsis,
        ),
        
            Text('₦$formattedPrice',style: GoogleFonts.aDLaMDisplay(fontSize:15,fontWeight:FontWeight.bold, color: Colors.white),),
       ],),
      ));
                     }).toList()
                 ));
                  },
                      ),
                      SizedBox(height: 10,)
                      
        ],) ,)
            ),
            

//HOME PAGE ENDS


//MENU PAGE 


              Center(
         child: Column(children: [
        SizedBox(height: 150,),
         Container(height: 40,
          width: 250,
      decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed:_launchstock,
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Change button color
    foregroundColor: Colors.white, // Change text/icon color
  //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Round edges
    ),
    elevation: 5, // Add shadow effect
  ),
       child: Text('STOCK FOOTAGES ',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.white),)),
      ),
      SizedBox(height: 20,),
         Container(height: 40,
         width: 250,
      decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed:() {},
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Change button color
    foregroundColor: Colors.white, // Change text/icon color
  //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Round edges
    ),
    elevation: 5, // Add shadow effect
  ),
       child: Text('BECOME A VENDOR',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.white),)),
      ),
       SizedBox(height: 20,),
           Container(height: 40,
          width: 250,
      decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed: () {
        
      },
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Change button color
    foregroundColor: Colors.white, // Change text/icon color
  //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Round edges
    ),
    elevation: 5, // Add shadow effect
  ),
       child: Text('EVENTS',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.white),)),
      ),
      SizedBox(height: 20,),
          Container(height: 40,
          width: 250,
      decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed:() {
        
      },
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Change button color
    foregroundColor: Colors.white, // Change text/icon color
  //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Round edges
    ),
    elevation: 5, // Add shadow effect
  ),
       child: Text('PHOTOGRAPHY',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.white),)),
      ),
      SizedBox(height: 20,),
          Container(height: 40,
          width: 250,
      decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed:() {
        
      },
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Change button color
    foregroundColor: Colors.white, // Change text/icon color
  //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Round edges
    ),
    elevation: 5, // Add shadow effect
  ),
       child: Text('MUSIC VIDEOS',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.white),)),
      ),
      SizedBox(height: 20,),
          Container(height: 40,
          width: 250,
      decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed:() {
        
      },
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Change button color
    foregroundColor: Colors.white, // Change text/icon color
  //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Round edges
    ),
    elevation: 5, // Add shadow effect
  ),
       child: Text('FILM&DOCUMENTARY',style: GoogleFonts.aDLaMDisplay(fontSize:18,color: Colors.white),)),
      ),
      SizedBox(height: 20,),
      
         Container(height: 40,
         width: 250,
      decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton( onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  backgroundColor: Color.fromARGB(150, 40, 42, 47),
                  
			title: Text('CONTACT',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.white)),
			children: <Widget>[
				SimpleDialogOption(
					onPressed: _launchwhatsapp,
							child: Text('+234 (0)8173211336',style: GoogleFonts.aDLaMDisplay(fontSize:15,color: Colors.white)),
						),
				SimpleDialogOption(
					onPressed: _launchEmail,
				child:  Text('info@dotbyproductions.com',style: GoogleFonts.aDLaMDisplay(fontSize:15,color: Colors.white)),
			),
      SizedBox(height: 10,),
     Center(child: Column(children: [
      Text('Head Quarter',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.white)),
    Container(margin: EdgeInsets.all(20),
    child:   Text('32A Craig Street, Ogudu Valley Estate, Ramat Bus Stop, By Dominos Pizza, Ogudu, Ojota, Lagos.',style: GoogleFonts.mulish(fontSize:15,color: Colors.white),
      textAlign: TextAlign.justify,
      softWrap: true,),)
     ],),)
	],
);
              },
            );
          },
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Change button color
    foregroundColor: Colors.white, // Change text/icon color
  //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Round edges
    ),
    elevation: 5, // Add shadow effect
  ),
       child: Text('CONTACT',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.white),))
      )
         ],),
            ),


            //MENU PAGE ENDS


//ABOUT PAGE


                      Container(
            child:   SingleChildScrollView(child:
      Column(children: [
     SizedBox(height: 50,),
      Container(
      margin: EdgeInsets.all(20),
      height:190 ,width: 350,
     
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(18)),
       gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('DOTBY',style: GoogleFonts.aDLaMDisplay(fontSize:30,color: Colors.white),),
      SizedBox(height: 5,),
      Container(height: 35,
      decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed: () {
        
      },
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Change button color
    foregroundColor: Colors.white, // Change text/icon color
  //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Round edges
    ),
    elevation: 5, // Add shadow effect
  ),
       child: const Text('Explore now',style: TextStyle(color: Colors.white),)),
      )
      ],),
    Image.asset('assets/images/banner.png',height: 150)
    ],
    ) ,
     ),
     SizedBox(height: 50,),
    Row(
    
      children: [
        SizedBox(width: 50,),
      Container(height: 2,
      width: 70,
      color: Colors.red,),
      SizedBox(width: 5,),
      Text('Know Who We are',style: GoogleFonts.inter(fontSize:15,color: Colors.white),),
    ],),
    SizedBox(height: 10,),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('WE ARE A NIGERIAN VIDEO',style: GoogleFonts.aDLaMDisplay(fontSize:15,color: Colors.white),),
          Text('PRODUCTION COMPANY BASED IN ',style: GoogleFonts.aDLaMDisplay(fontSize:15,color: Colors.white),),
            Text('LAGOS WITH FOOTPRINTS ACROSS ',style: GoogleFonts.aDLaMDisplay(fontSize:15,color: Colors.white),),
              Text('AFRICA. WE ARE A LEADER AMONGST ',style: GoogleFonts.aDLaMDisplay(fontSize:15,color: Colors.white),),
                Text('VIDEO PRODUCTION COMPANIES IN ',style: GoogleFonts.aDLaMDisplay(fontSize:15,color: Colors.white),),
                  Text('NIGERIA.',style: GoogleFonts.aDLaMDisplay(fontSize:15,color: Colors.white),),
                  SizedBox(height: 20,),
       Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
 Text('DOTBY Productions is a One-Stop-media-Shop in Nigeria to provide media services to individuals,corporate bodies and professionals in and outside the media industry.',style: GoogleFonts.mulish(fontSize:15,color: Colors.white),
               textAlign: TextAlign.justify, 
             softWrap: true,),
             SizedBox(height: 10,),
Text('Our objective is to provide the best of media experience via the use of our wide range of equipment, professionally packagaed services and manpower designed to satisfy our customers’ indoor and outdoor needs.',style: GoogleFonts.mulish(fontSize:15,color: Colors.white),
               textAlign: TextAlign.justify, 
             softWrap: true,),
              SizedBox(height: 10,),
Text('We pride ourselves on the excellent services we give to our customers which make them loyal to us, become oyr brand ambassadors and make point of reference in the industry.',style: GoogleFonts.mulish(fontSize:15,color: Colors.white),
               textAlign: TextAlign.justify, 
             softWrap: true,),
             SizedBox(height: 10,),
             Text('We are highly motivated by quality in the dispensation of our service offerings.',style: GoogleFonts.mulish(fontSize:15,color: Colors.white),
               textAlign: TextAlign.justify, 
             softWrap: true,),
 SizedBox(height: 10,),
             Center(child:   Container(height: 35,
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Colors.red, Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>About())),
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Change button color
    foregroundColor: Colors.white, // Change text/icon color
  //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Round edges
    ),
    elevation: 5, // Add shadow effect
  ),
       child: Text('LEARN MORE',style: TextStyle(color: Colors.white),)),
      ),)
          ],
        ),
       ),
              SizedBox(height: 30,),
             Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      const      YouTubePlayerWidget(videoId: '7a8WMmFnP7s'), 
            SizedBox(height: 20),
       const     YouTubePlayerWidget(videoId: 'knLGO_7_y8Q'), 
             SizedBox(height: 20),
              Center(child:   Container(height: 35,
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
      colors: [Color.fromARGB(155,114, 117, 129), Color.fromARGB(255,29, 31, 35)], // Gradient colors
      begin: Alignment.topLeft, // Start point
      end: Alignment.bottomRight, // End point
    ),
      ),
      child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Talk() )),
       style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Change button color
    foregroundColor: Colors.white, // Change text/icon color
  //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Round edges
    ),
    elevation: 5, // Add shadow effect
  ),
       child: Text('See More',style: TextStyle(color: Colors.white),)),
      ),),
      SizedBox(height: 20),
      
          ],
        ),
        Text('OUR SERVICES',style: GoogleFonts.aDLaMDisplay(fontSize:30,color: Colors.white),),
SizedBox(height: 20),
    Stack(
  alignment: Alignment.center,
  children: [
    Image.asset(
      'assets/images/brush.png', 
      width: 340,
      height: 320,
      fit: BoxFit.cover,
    ),
    ClipOval(
      child: Image.asset(
        'assets/images/brush1.jpg', 
        width: 230, 
        height: 230,
        fit: BoxFit.cover, 
      ),
    ),
   
  ],
),
 SizedBox(height: 10),
    Text('Video Production',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.white),),
   Container(margin: EdgeInsets.all(30),
   child:  Text('We produce video contents with concise and evidential quality to suit your preferences. And our editors are dedicated and up to the task to deliver excellent job.',style: GoogleFonts.mulish(fontSize:15,color: Colors.white),
               textAlign: TextAlign.justify, 
             softWrap: true,),),
 SizedBox(height: 20),
    Stack(
      alignment:Alignment.center,
      children: [
          Image.asset(
      'assets/images/brush3.png', 
      width: 340,
      height: 320,
      fit: BoxFit.cover,
    ),
    ClipOval(
      child: Image.asset('assets/images/brush4.jpg',
      width: 230,
      height: 240,
      fit: BoxFit.cover,),
    )
      ],
    ),
    SizedBox(height: 10),
    Text('Audio Production',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.white),),
   Container(margin: EdgeInsets.all(30),
   child:  Text('Our audio production is sterling. We are readily available to accord you the necessary services to make your work exceptional',style: GoogleFonts.mulish(fontSize:15,color: Colors.white),
               textAlign: TextAlign.justify, 
             softWrap: true,),),
 
     SizedBox(height: 20),
    Stack(
      alignment:Alignment.center,
      children: [
          Image.asset(
      'assets/images/brush5.png', 
      width: 340,
      height: 320,
      fit: BoxFit.cover,
    ),
    ClipOval(
      child: Image.asset('assets/images/brush6.jpg',
      width: 230,
      height: 240,
      fit: BoxFit.cover,),
    )
      ],
    ),
      SizedBox(height: 10),
    Text('Equipment Rentals',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.white),),
   Container(margin: EdgeInsets.all(30),
   child:  Text('Our audio-visual equipment is top notch. We pride to claim that we are the pioneer handler of the Z-CAM Series in Nigeria, and our ultra-modern equipment are available for rent with instant delivery at a price you can afford.',style: GoogleFonts.mulish(fontSize:15,color: Colors.white),
               textAlign: TextAlign.justify, 
             softWrap: true,),),
 
     SizedBox(height: 20),
     Center(child: Image.asset('assets/images/content.png'),),
      SizedBox(height: 10),
       Text('Content Sales and Marketing',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.white),),
      Container(margin: EdgeInsets.all(30),
   child:  Text('Our workforce comprises of experienced content writers and content creators. We do our best to synergize between your request and market demand to produce masterpiece contents and creations.',style: GoogleFonts.mulish(fontSize:15,color: Colors.white),
               textAlign: TextAlign.justify, 
             softWrap: true,),),
             SizedBox(height: 20),
              Stack(
      alignment:Alignment.center,
      children: [
          Image.asset(
      'assets/images/brush7.png', 
      width: 340,
      height: 320,
      fit: BoxFit.cover,
    ),
    ClipOval(
      child: Image.asset('assets/images/event.jpg',
      width: 230,
      height: 240,
      fit: BoxFit.cover,),
    )
      ],
    ),
      SizedBox(height: 10),
    Text('Events Coverage',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.white),),
   Container(margin: EdgeInsets.all(30),
   child:  Text('Our dedicated events’ coverage team specializes in all types of events’ coverage. We boast of the most modern equipment for the task in any part of the country and our event packages are pocket-friendly.',style: GoogleFonts.mulish(fontSize:15,color: Colors.white),
               textAlign: TextAlign.justify, 
             softWrap: true,),),
 
     SizedBox(height: 20),
             Stack(
      alignment:Alignment.center,
      children: [
          Image.asset(
      'assets/images/brush8.png', 
      width: 340,
      height: 320,
      fit: BoxFit.cover,
    ),
    ClipOval(
      child: Image.asset('assets/images/brush4.jpg',
      width: 230,
      height: 240,
      fit: BoxFit.cover,),
    )
      ],
    ),
      SizedBox(height: 10),
    Text('Mixed Media Studio Rental',style: GoogleFonts.aDLaMDisplay(fontSize:20,color: Colors.white),),
   Container(margin: EdgeInsets.all(30),
   child:  Text('Our audio-visual equipment is top notch. We pride to claim that we are the pioneer handler of the Z-CAM Series in Nigeria, and our ultra-modern equipment are available for rent with instant delivery at a price you can afford.',style: GoogleFonts.mulish(fontSize:15,color: Colors.white),
               textAlign: TextAlign.justify, 
             softWrap: true,),),
 
     SizedBox(height: 20),
     Center(child: Text('© 2025 Doty Productions. All Rights Reserved',style: GoogleFonts.mulish(fontSize:15,color: Colors.white),
               ),)
      ],
    )
        ],) ,)
            ),

            
            //ABOUT PAGE ENDS


//PROFILE PAGE


       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/person.png'),
          SizedBox(height: 10,),
          CustomSlidingSegmentedControl<int>(
            initialValue: _selectedIndex,
            children: {
              0: Text("Login",style: GoogleFonts.mulish(fontSize:15,color: Colors.white)),
              1: Text("Register",style: GoogleFonts.mulish(fontSize:15,color: Colors.white)),
            },
            
            decoration: BoxDecoration(
              color: Color.fromARGB(155,114, 117, 129),
              borderRadius: BorderRadius.circular(10),
            ),
            thumbDecoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            onValueChanged: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          const SizedBox(height: 20),

          // Display different content based on selected index
          _selectedIndex == 0 ? Login() : Register(),
        ],
      ),
    

         //PROFILE PAGE ENDS


          ],
        ),
        
          ),
          

          //VISIBLE SEARCH FUNCTION


          if (_isSearching)
  Expanded(
    child: ListView.builder(
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_filteredItems[index], style: TextStyle(color: Colors.white)),
        );
      },
    ),
  ),

        ] 
    ),
    
        bottomNavigationBar:
        ClipRRect(
  borderRadius: BorderRadius.vertical(top: Radius.circular(25)), // ✅ Curved top edges
  child: WaterDropNavBar(
          backgroundColor: navigationBarColor,
           waterDropColor: Color.fromARGB(255, 233, 233, 233),
          onItemSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
          },
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              filledIcon: Icons.home,
              outlinedIcon: Icons.home_outlined,
            ),
            BarItem(
                filledIcon: Icons.bookmark_rounded,
                outlinedIcon: Icons.bookmark_border_rounded),
            BarItem(
              filledIcon: Icons.notifications,
              outlinedIcon: Icons.notifications_outlined,
            ),
            BarItem(
              filledIcon: Icons.person,
              outlinedIcon: Icons.person_outlined,
            ),
          ],
        )),
        
      );
  }
}












