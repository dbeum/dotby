import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotby1/vendorrequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Vendoradmin extends StatefulWidget {
  const Vendoradmin({super.key});

  @override
  State<Vendoradmin> createState() => _VendoradminState();
}

class _VendoradminState extends State<Vendoradmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vendors'),),
      body: SingleChildScrollView(child:  Column(children: [
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
  Container(
    height: 20,
    width: 2,
    color: Colors.white,
  ),
          TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Vendorrequest())),
         child: Text('CHECK REQUESTS',style: TextStyle(color: Colors.white,fontSize: 15),)),
           Container(
    height: 20,
    width: 2,
    color: Colors.white,
  ),
        ],),
Text('Artists',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
      var vendor = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Artist' && doc['contacted'] == true)
      .toList();

  if (vendor.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendor.length,
        itemBuilder: (context, index) {
          
          var vendors = vendor[index];
          
          return ListTile(
            
            title: Text(' ${vendors['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle:Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                 Column(children: [
              Text('Owner Name: ${vendors['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendors['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendors['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendors['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendors['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
         
        },
      ),);
    }
  },
),
Text('Lightsman / gaffa',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
      var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Lightsman / gaffa' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
        
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle:Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
          }
         
        
      ),);
    }
  },
),
Text('Soundman',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
       var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Soundman' &&  doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
        
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle:Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
          }
         
      ),);
    }
  },
),
Text('Videographer',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
       var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Videographer' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
        
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle:Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
          }
          
      ),);
    }
  },
),
Text('Photographer',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
      var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Photographer' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
        
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle:Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
          
        },
      ),);
    }
  },
),
Text('Music video director',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
       var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Music video director' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
         
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle: Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
        
        },
      ),);
    }
  },
),
Text('Film director',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
  var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Film director' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
         
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle: Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
          }
         
      ),);
    }
  },
),
Text('Film producer',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
    var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Film producer' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
         
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle: Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
         
        },
      ),);
    }
  },
),
Text('Production manager',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
      var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Production manager' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
      
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle: Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
         
        },
      ),);
    }
  },
),
Text('Location manager',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
     var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Location manager' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
      
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle:Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
       
        },
      ),);
    }
  },
),
Text('Story writer',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
      var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Story writer' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
        
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle:Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
         
        },
      ),);
    }
  },
),
Text('Equipment handler',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
     var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Equipment handler' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
      
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle:Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
         
        },
      ),);
    }
  },
),
Text('MC / Compere',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
      var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'MC / Compere' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
        
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle: Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
       
        },
      ),);
    }
  },
),
Text('Clergy',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
       var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Clergy' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
        
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle:Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
            
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
          }
         
      ),);
    }
  },
),
Text('Executive producer- music',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
      var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Executive producer- music' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
        
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle:Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
          }
         
      ),);
    }
  },
),
Text('Executive producer-film',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
       var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Executive producer-film' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
      
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle: Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
            
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
          }
         
      ),);
    }
  },
),
Text('Set designer',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
     var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Set designer' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
         
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle:Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: 
            
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],),)
          );
          }
       
      ),);
    }
  },
),

Text('Make-up artist',style: TextStyle(color: Colors.white,fontSize: 20)),

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
      return Center(child: Text('No vendors found.'));
    } else {
     var vendors = snapshot.data!.docs
      .where((doc) => doc['businessType'] == 'Make-up artist' && doc['contacted'] == true)
      .toList();

  if (vendors.isEmpty) {
    return Center(
      child: Text('No Approved vendors found.', style: TextStyle(color: Colors.white)),
    );
  }
      return Container(height: 200,
      child:  ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          
          var vendor = vendors[index];
         
          return ListTile(
            
            title: Text(' ${vendor['businessName']}',style: TextStyle(color: Colors.white,fontSize: 17),),
            subtitle:Container(
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white),
             borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(children: [
  vendor['profileImage'] != null && vendor['profileImage'].toString().isNotEmpty
  ? Image.network(
      vendor['profileImage'],
      width: 80,
      height: 80,
      
      fit: BoxFit.cover,
    )
  : Image.asset(
      'assets/images/logo.png', // Your fallback/placeholder image
      width: 80,
      height: 80,
    ),
                 Column(children: [
              Text('Owner Name: ${vendor['ownerName']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Email: ${vendor['email']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Phone Number: ${vendor['number']}',style: TextStyle(color: Colors.white,fontSize: 15)),
              SelectableText('Location: ${vendor['location']}',style: TextStyle(color: Colors.white,fontSize: 15)),
               Text('Approved ON:${DateTime.fromMillisecondsSinceEpoch(vendor['approvedDate'].millisecondsSinceEpoch).toString().split(" ")[0]}',style: TextStyle(color: Colors.white,fontSize: 15)),
          
            ],)
              ],)
            
            ,)
          );
          }
         
      ),);
    }
  },
),
SizedBox(height: 20,),
      ],),)
    );
  }
}   