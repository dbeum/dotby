import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotby1/admincheckout.dart';
import 'package:dotby1/login.dart';
import 'package:dotby1/orderstatus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Team extends StatefulWidget {
  const Team({super.key});

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();
   final _descriptionController = TextEditingController();
  String _selectedCategory = 'Events';

  final List<String> categories = ['Events', 'Lights', 'Primelenses', 'Zoomlenses', 'Lenses','Accessories', 'Photos'];

  Future<void> addProduct(String category, String name, String description, String imageUrl, double price) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(category)
          .collection('items')
          .add({
        'name': name,
        'description': description,
        'poster_url': imageUrl,
        'price': price,
        'available': true,
        'createdAt': FieldValue.serverTimestamp(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin - Manage Products')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
 TextField(
  controller: _imageController,
  decoration: InputDecoration(
    labelText: 'Image URL',
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
                final imageUrl = _imageController.text;
                final description = _descriptionController.text; // Get description text
addProduct(_selectedCategory, name, description, imageUrl, price);

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
                      return ListTile(
                        leading: Image.network(product['poster_url'], width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(product['name']),
                        subtitle: Text('₦${product['price']}'),
                        trailing: Row(
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
