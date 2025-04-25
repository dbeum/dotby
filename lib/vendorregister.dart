import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotby1/cloudinary.dart';
import 'package:dotby1/home.dart';
import 'package:dotby1/vendorwaitpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class VendorRegister extends StatefulWidget {
  const VendorRegister({super.key});

  @override
  State<VendorRegister> createState() => _VendorRegisterState();
}

class _VendorRegisterState extends State<VendorRegister> {
  late final TextEditingController _businessName;
late final TextEditingController _ownerName;
late final TextEditingController _email;
late final TextEditingController _number;
late final TextEditingController _description;
late final TextEditingController _address;
String? imageUrl;

 final picker = ImagePicker();
  File? _image;

  
String dropdownvalue='Artist';
var items= [
 'Artist', 
'Lightsman / gaffa',
'Soundman', 
'Videographer', 
'Photographer', 
'Music video director', 
'Film director', 
'Film producer',
'Production manager', 
'Location manager', 
'Story writer',
'Equipment handler', 
'MC / Compere', 
'Clergy',
'Executive producer- music' ,
'Executive producer-film',
'Set designer',
'Make-up artist'
];
@override
  void initState() {
   _businessName =TextEditingController();
   _ownerName =TextEditingController();
   _email =TextEditingController();
   _number =TextEditingController();
   _description =TextEditingController();
   _address =TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _businessName.dispose();
    _ownerName.dispose();
    _email.dispose();
    _number.dispose();
    _description.dispose();
    _address.dispose();
    super.dispose();
  }

  
Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;
    CloudinaryService cloudinaryService = CloudinaryService();
    imageUrl = await cloudinaryService.uploadImage(_image!);


    // You can now save this URL in your database (Firebase, etc.)
    print('Image uploaded successfully: $imageUrl');
  }

Future<void> saveVendor({
  required String businessName,
  required String ownerName,
  required String email,
  required String number,
  required String description,
  required String businessType,
  required String address,
  
}) async {
  try {
    await FirebaseFirestore.instance.collection('vendors').add({
      'businessName': businessName,
      'ownerName': ownerName,
      'email': email,
      'number': number,
      'description': description,
      'businessType': businessType,
      'location': address,
      'contacted': false,
      'approvedDate':FieldValue.serverTimestamp(),
      'uid': FirebaseAuth.instance.currentUser?.uid,
       'profileImage': imageUrl ?? '',
    });

    print('Vendor info saved!');
  } catch (e) {
    print('Error saving vendor: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        leading:   
       
        
         IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
          
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()), 
               (Route<dynamic> route )=> false
            );
          },
        ),
       
        title: Text('BECOME A VENDOR',style: GoogleFonts.protestRevolution(fontSize: 25),),),
      body:SingleChildScrollView(child: Padding(padding: EdgeInsets.all(15),
      child:  Column(
   
        children: [
    _image != null
                ? Image.file(_image!, width: 100, height: 100)
                : Icon(Icons.image, size: 100),
            SizedBox(height: 5 ),
            TextButton(
              onPressed: _pickImage,
              style: TextButton.styleFrom(backgroundColor: Colors.transparent),
              child: Text("Pick Image",style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: _uploadImage,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
              child: Text("Upload",style: TextStyle(color: Colors.black),),
            ),
              SizedBox(height: 10),
       Container(height: 40,width: 350,
       child:  TextField(
          controller: _businessName,
         decoration: InputDecoration(labelText: 'Business Name', 
         labelStyle: TextStyle(color: Colors.white),
         focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
         enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
           disabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
         ),
     
          keyboardType: TextInputType.text,
          cursorColor: Colors.white,
          style: TextStyle(color:Colors.white),
        )),
SizedBox(height: 20,),
  Container(height: 40,width: 350,
       child:  TextField(
          controller: _ownerName,
         decoration: InputDecoration(labelText: 'Owners Name', 
         labelStyle: TextStyle(color: Colors.white),
         focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
         enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
           disabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
         ),
     
          keyboardType: TextInputType.text,
          cursorColor: Colors.white,
          style: TextStyle(color:Colors.white),
        )),

SizedBox(height: 20,),
  Container(height: 40,width: 350,
       child:  TextField(
          controller: _email,
         decoration: InputDecoration(labelText: 'Email', 
         labelStyle: TextStyle(color: Colors.white),
         focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
         enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
           disabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
         ),
     
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.white,
          style: TextStyle(color:Colors.white),
        )),
        SizedBox(height: 20,),
  Container(height: 40,width: 350,
       child:  TextField(
          controller: _number,
         decoration: InputDecoration(labelText: 'Phone Number', 
         labelStyle: TextStyle(color: Colors.white),
         focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
         enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
           disabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
         ),
     
          keyboardType: TextInputType.number,
          cursorColor: Colors.white,
          style: TextStyle(color:Colors.white),
        )),
        SizedBox(height: 20,),
        DropdownButton(
          value: dropdownvalue,
          items: items.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items,style: TextStyle(color:Colors.black),));
              }).toList() , onChanged:  (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
            });
          },),

SizedBox(height: 20,),
  Container(height: 60,width: 350,
       child:  TextField(
          controller: _description,
         decoration: InputDecoration(labelText: 'Description / Services Offered(can include portfolio/social links)', 
         labelStyle: TextStyle(color: Colors.white),
         focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
         enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
           disabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
         ),
     
          keyboardType: TextInputType.text,
          cursorColor: Colors.white,
          style: TextStyle(color:Colors.white),
        )),
        SizedBox(height: 20,),
  Container(height: 40,width: 350,
       child:  TextField(
          controller: _address,
         decoration: InputDecoration(labelText: 'Location', 
         labelStyle: TextStyle(color: Colors.white),
         focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
         enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
           disabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.white)),
         ),
     
          keyboardType: TextInputType.text,
          cursorColor: Colors.white,
          style: TextStyle(color:Colors.white),
        )),
         SizedBox(height: 50,),
         ElevatedButton(onPressed: ()async {
            await saveVendor(
    businessName: _businessName.text,
    ownerName: _ownerName.text,
    email: _email.text,
    number: _number.text,
    description: _description.text,
    businessType: dropdownvalue,
    address: _address.text,
  );
   Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Vendorwaitpage()), // Replace with your page
  );
         }, child: Text('Submit',style: TextStyle(color:Colors.black),))
      ]),),)
    );
  }
}