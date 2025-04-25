import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotby1/admincheckout.dart';
import 'package:dotby1/cloudinary.dart';
import 'package:dotby1/login.dart';
import 'package:dotby1/orderstatus.dart';
import 'package:dotby1/vendoradmin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Team extends StatefulWidget {
  const Team({super.key});

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  //final _imageController = TextEditingController();
  final _stockController = TextEditingController();

   final _descriptionController = TextEditingController();
   String? imageUrl;
    final picker = ImagePicker();
  File? _image;

  String _selectedCategory = 'Events';

  final List<String> categories = ['Events', 'Lights', 'Primelenses', 'Zoomlenses', 'Lenses','Accessories', 'Photos'];

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


  
    print('Image uploaded successfully: $imageUrl');
  }

  Future<void> addProduct(String category, String name, String description,  double price,int stock) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(category)
          .collection('items')
          .add({
        'name': name,
        'description': description,
        //'poster_url': imageUrl,
        'price': price,
        'stock': stock,
        'available': true,
        'createdAt': FieldValue.serverTimestamp(),
         'profileImage': imageUrl ?? '',
      });
      print('Product added successfully!');
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> deleteProduct(String category, String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(category)
          .collection('items')
          .doc(productId)
          .delete();
      print('Product deleted successfully!');
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  Future<void> updateProductAvailability(String category, String productId, bool availability) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(category)
          .collection('items')
          .doc(productId)
          .update({'available': availability});
      print('Product availability updated!');
    } catch (e) {
      print('Error updating availability: $e');
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
void signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Login()), // Navigate to login screen after sign out
  );
}
// Function to increase stock
Future<void> increaseStock(String category, String productId, int currentStock) async {
  try {
    // Increase stock by 1 (or adjust as needed)
    await FirebaseFirestore.instance
        .collection('products')
        .doc(category)
        .collection('items')
        .doc(productId)
        .update({
      'stock': currentStock + 1,
    });
    print('Stock increased!');
  } catch (e) {
    print('Error increasing stock: $e');
  }
}

// Function to decrease stock
Future<void> decreaseStock(String category, String productId, int currentStock) async {
  if (currentStock > 0) {
    try {
      // Decrease stock by 1
      await FirebaseFirestore.instance
          .collection('products')
          .doc(category)
          .collection('items')
          .doc(productId)
          .update({
        'stock': currentStock - 1,
      });
      print('Stock decreased!');
    } catch (e) {
      print('Error decreasing stock: $e');
    }
  } else {
    print('Stock cannot be less than 0');
  }
}


  @override
  Widget build(BuildContext context) {
      final NumberFormat formatter = NumberFormat('#,###');
    return Scaffold(
    //  appBar: AppBar(title: Text('Admin - Manage Products')),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Center(child: Text('Admin - Manage Products',style: TextStyle(color: Colors.white,fontSize: 25),),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
 TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkout()));}, child: Text('CHECKOUT',style: TextStyle(color: Colors.white),)),
 Container(
    height: 20,
    width: 2,
    color: Colors.white,
  ),
  TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Return()));}, child: Text('ORDER STATUS',style: TextStyle(color: Colors.white),)),
           Container(
    height: 20,
    width: 2,
    color: Colors.white,
  ),
  TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Vendoradmin()));}, child: Text('VENDOR',style: TextStyle(color: Colors.white),)),
            ],),
           
           DropdownButtonHideUnderline( // Hides default underline
  child: DropdownButton<String>(
    value: _selectedCategory,
    dropdownColor: Colors.black, // Set background color of dropdown menu
    items: categories.map((category) {
      return DropdownMenuItem(
        value: category,
        child: Text(
          category,
          style: TextStyle(color: Colors.white), // Text color inside dropdown
        ),
      );
    }).toList(),
    onChanged: (value) {
      setState(() {
        _selectedCategory = value!;
      });
    },
    style: TextStyle(color: Colors.white), // Selected item text color
  ),
),

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
         TextField(
  controller: _titleController,
  decoration: InputDecoration(
    labelText: 'Title',
    labelStyle: TextStyle(color: Colors.black), 
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white), 
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white), 
    ),
  ),
  style: TextStyle(color: Colors.white), 
   cursorColor: Colors.white,
),
     TextField(
  controller: _descriptionController,
  decoration: InputDecoration(
    labelText: 'Description',
    labelStyle: TextStyle(color: Colors.black), 
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white), 
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white), 
    ),
  ),
  style: TextStyle(color: Colors.white), 
   cursorColor: Colors.white,
),
   TextField(
  controller: _priceController,
  decoration: InputDecoration(
    labelText: 'Price',
    labelStyle: TextStyle(color: Colors.black), 
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white), 
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white), 
    ),
  ),
  style: TextStyle(color: Colors.white), 
   cursorColor: Colors.white,
),
//  TextField(
//   controller: _imageController,
//   decoration: InputDecoration(
//     labelText: 'Image URL',
//     labelStyle: TextStyle(color: Colors.black), 
//     focusedBorder: UnderlineInputBorder(
//       borderSide: BorderSide(color: Colors.white), 
//     ),
//     enabledBorder: UnderlineInputBorder(
//       borderSide: BorderSide(color: Colors.white),
//     ),
//     disabledBorder: UnderlineInputBorder(
//       borderSide: BorderSide(color: Colors.white), 
//     ),
//   ),
//   style: TextStyle(color: Colors.white), 
//    cursorColor: Colors.white,
// ),
  TextField(
  controller: _stockController,
  decoration: InputDecoration(
    labelText: 'Stock Quantity',
    labelStyle: TextStyle(color: Colors.black),
    
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white), 
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white), 
    ),
  ),
  style: TextStyle(color: Colors.white), 
   cursorColor: Colors.white,
   keyboardType: TextInputType.number,
),
            
            SizedBox(height: 20,),
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
                final name = _titleController.text;
                final price = double.tryParse(_priceController.text) ?? 0.0;
                //final imageUrl = _imageController.text;
                final description = _descriptionController.text;
                final stock = int.tryParse(_stockController.text) ?? 1;
addProduct(_selectedCategory, name, description, price,stock);

              },
              child: Text('Add Product',style: TextStyle(color: Colors.white),),
            ),
          
       ),
            
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .doc(_selectedCategory)
                    .collection('items')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  var products = snapshot.data!.docs;
   
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      var product = products[index];
                      int currentStock = product['stock'];
                      return ListTile(
                        leading: Image.network(product['profileImage'], width: 40, height: 40, fit: BoxFit.cover),
                        title: Text(product['name'],style: TextStyle(color:Colors.white)),
                        subtitle: Text('₦${formatter.format(product['price'])}',style: TextStyle(color:Colors.white,fontSize: 9),),
                        trailing:
                        
                         Row(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle),
                              onPressed: () => deleteProduct(_selectedCategory, product.id),
                            ),
                            IconButton(
                              icon: Icon(Icons.block, color: product['available'] ? Colors.red : Colors.grey),
                              onPressed: () => updateProductAvailability(_selectedCategory, product.id, !product['available']),
                            ),
                              // Decrease stock button
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => decreaseStock(_selectedCategory, product.id, currentStock),
                ),
                // Increase stock button
                Text('${product['stock']}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => increaseStock(_selectedCategory, product.id, currentStock),
                ),
                          ],
                        ),
                      );
                    },
                  );
                }, 
              ),
            ),
             
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
             floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout,color: Colors.white,),
        backgroundColor: Color.fromARGB(155,29, 31, 35),
        foregroundColor: Color.fromARGB(255,19, 20, 22),
        onPressed:()async {
           signOut(context);

},
      ),
    );
  }
}
