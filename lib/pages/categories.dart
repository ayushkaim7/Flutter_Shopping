import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_assignment/cartpage.dart';
import 'package:shopping_app_assignment/fruits.dart';
import 'package:shopping_app_assignment/pages/favorite.dart';
import 'package:shopping_app_assignment/product_list/fruitsandvegies.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  List<String> _categories = [
    'Banana',
    'Apple',
    'Figs',
    'Watermelon',
    'cucumber',
    'peach',
  ];

   final List<Fruit> _fruits = [
    Fruit(
      name: 'Fruits & \n vegetables',
      description: 'Fresh fruits & \n vegetables everyday',
      imageUrl:  'assets/images/23.png', 
    ),
    Fruit(
      name: 'Bakery',
      description: 'Fresh bread every \n mornning',
      imageUrl: 'assets/images/24.png', 
    ),
    Fruit(
      name: 'Grocerries',
      description: 'Shop daily \n grocerries & more',
      imageUrl: 'assets/images/25.png', 
    ),
  
  ];

  final List<Animal> _animals = [
    Animal(
      name: 'Eggs',
      description: 'Get fresh eggs \n from poultery',
      imageUrl:  'assets/images/26.png', 
    ),
    Animal(
      name: 'Chicken',
      description: 'Chieken breast \n full of proteins',
      imageUrl: 'assets/images/27.png',
    ),
    Animal(
      name: 'Fish',
      description: 'Check your daily salmon \n intake \n Order now',
      imageUrl: 'assets/images/28.png',
    ),

  ];

  late List<Fruit> _filteredFruits;
  late List<Animal> _filteredAnimals;
  String _searchQuery = '';


  late List<Fruit> _filteredCategories;


  @override
  void initState() {
    super.initState();
      _filteredFruits = _fruits;
    _filteredAnimals = _animals;
  }



    void _filterCategories(String query) {
    setState(() {
      _searchQuery = query;
      _filteredFruits = _fruits.where((fruit) {
        return fruit.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      _filteredAnimals = _animals.where((animal) {
        return animal.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Padding(
          padding:  EdgeInsets.only(left: 20 , top: 15),
          child: Icon(Icons.arrow_back_ios),
          
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25,),
              Center(child: const Text("Categories" , style: TextStyle(fontFamily: 'Poppins' , fontSize: 30 , fontWeight: FontWeight.w600),)),

              const SizedBox(height: 45,),
              Padding(
                padding: const EdgeInsets.only(left: 18 , right: 18),
                child: TextField(
                onChanged: _filterCategories,
                decoration: InputDecoration(
                  hintText: 'Search for a product...',
                  hintStyle: TextStyle(fontFamily: 'Poppins' , color: Colors.grey.shade700),
                  prefixIcon: Icon(Icons.search , size: 30,color: Colors.grey.shade700,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
               ),
             ),
             const SizedBox(height: 20,),
             const Padding(
               padding: EdgeInsets.only(left: 30),
               child:  Text("Standard Products", style: TextStyle(fontFamily: 'Poppins' , fontSize: 19 , fontWeight: FontWeight.w600),),
             ),
             const SizedBox(height: 20,),
             SizedBox(
              height: 230,
              child: Padding(
                padding: const EdgeInsets.only(left: 12  ,right: 12),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filteredFruits.length,
                  itemBuilder: (context , index){
                    final fruit = _filteredFruits[index];
                    return InkWell(
                      onTap: () {
                        if(fruit.name =='Fruits & \n vegetables' ){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList()));

                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 165,
                        
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.5,
                            ),
                          
                        
                        ),
                        child: Column(
                          children: [
                           // SizedBox(height: 15,),
                            Container(
                              height: 130,
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                                child: Image.asset(
                                  fruit.imageUrl,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                                        Text(
                      fruit.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'
                      ),
                      textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 6,),
                                        Text(
                      fruit.description,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.center,
                                        ),
                          ],
                        ),
                      ),
                    );
                  }),
              ),
             ),
             SizedBox(height: 30,),
             const Padding(
               padding: EdgeInsets.only(left: 30),
               child:  Text("Animal Products", style: TextStyle(fontFamily: 'Poppins' , fontSize: 19 , fontWeight: FontWeight.w600),),
             ),
             const SizedBox(height: 20,),
             SizedBox(
              height: 230,
              child: Padding(
                padding: const EdgeInsets.only(left: 12  ,right: 12),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filteredAnimals.length,
                  itemBuilder: (context , index){
                    final animal = _filteredAnimals[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: 165,
                      
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1.5,
                          ),
                        
                      
                      ),
                      child: Column(
                        children: [
                         // SizedBox(height: 15,),
                          Container(
                            height: 130,
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                              child: Image.asset(
                                animal.imageUrl,
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                            ),
                          ),
                  Text(
                    animal.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6,),
                  Text(
                    animal.description,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  ),
                        ],
                      ),
                    );
                  }),
              ),
             ),
             SizedBox(height: 30,),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20 , right: 20),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
          },
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(35),
              
            ),
            child: Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 25,
                    right: 22,
                    
                    child: Icon(Icons.shopping_bag , color: Colors.white, size: 28,)),
                  Positioned(
                    left: 45,
                    bottom: 35,
                    child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {

                return Text(
                  '${cartProvider.cartItemCount}', 
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),)
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}