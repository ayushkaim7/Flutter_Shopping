import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_assignment/cartpage.dart';
import 'package:shopping_app_assignment/fruits.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];
  bool _isSearching = false;
  String _searchText = '';

  final List<Product> _products = [
    Product(
      name: 'Banana',
      description: 'By weight Rs.40/Kg',
      imageUrl: 'assets/images/23.png',
      price: 40,
    ),
    Product(
      name: 'Apple',
      description: 'By weight Rs.80/Kg',
      imageUrl: 'assets/images/29.png',
      price: 80,
    ),
    Product(
      name: 'Carrots',
      description: 'By weight Rs.100Kg',
      imageUrl: 'assets/images/30.png',
      price: 100,
    ),
    Product(
      name: 'Onions',
      description: 'By weight Rs.120/Kg',
      imageUrl: 'assets/images/31.png',
      price: 120,
    ),
    Product(
      name: 'Lemons',
      description: 'By weight Rs.35/Kg',
      imageUrl: 'assets/images/32.png',
      price: 35,
    ),
    Product(
      name: 'Pineapple',
      description: 'By weight Rs.60/Kg',
      imageUrl: 'assets/images/33.png',
      price: 60,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _filteredProducts = _products; 
  }

  void _toggleSearchBar() {
    setState(() {
      _isSearching = !_isSearching;
      _searchText = '';
      _filteredProducts = _products;
    });
  }

  void _filterProducts(String searchText) {
    setState(() {
      _searchText = searchText;
      if (_searchText.isNotEmpty) {
        _filteredProducts = _products
            .where((product) =>
                product.name.toLowerCase().contains(_searchText.toLowerCase()))
            .toList();
      } else {
        _filteredProducts = _products; 
      }

      _filteredProducts.sort((a, b) {
        if (a.name.toLowerCase().contains(_searchText.toLowerCase()) &&
            !b.name.toLowerCase().contains(_searchText.toLowerCase())) {
          return -1;
        } else if (!a.name.toLowerCase().contains(_searchText.toLowerCase()) &&
            b.name.toLowerCase().contains(_searchText.toLowerCase())) {
          return 1;
        }
        return 0;
      });
    });
  }

  void _openWeightSelectionBottomSheet(Product product) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        double selectedWeight = 1.0;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Select Weight (Kg)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 30),
                  Slider(
                    value: selectedWeight,
                    min: 0.5,
                    max: 5.0,
                    divisions: 9,
                    activeColor: Colors.blue.shade700,
                    label: selectedWeight.toString(),
                    onChanged: (value) {
                      setState(() {
                        selectedWeight = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${selectedWeight.toStringAsFixed(1)} Kg',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width - 30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                      ),
                      onPressed: () {
                        double totalPrice = selectedWeight * product.price;
                        Provider.of<CartProvider>(context, listen: false)
                            .addToCart(product, selectedWeight, totalPrice);

                        Fluttertoast.showToast(
                          msg: '${product.name} added to cart ',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Add to Cart (Rs. ${selectedWeight * product.price})',
                        style: const TextStyle(
                            fontFamily: 'Poppins', color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, size: 28),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    _toggleSearchBar();
                  },
                  icon: const Icon(Icons.search_outlined, size: 28),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.format_list_bulleted, size: 28),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          children: [
            if (_isSearching)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterProducts,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search for a product...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _searchText.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchText = ''; 
                                _filteredProducts = _products; 
                                _searchController.clear();
                              });
                            },
                          )
                        : null,
                  ),
                ),
              ),
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "    Fruits & \n vegetables",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.65,
                  children: _filteredProducts.map((product) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.5), width: 1.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15)),
                              child: Image.asset(
                                product.imageUrl,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              product.description,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                const Text(
                                  "Rs. ",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  product.price.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 35),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade700,
                                      borderRadius: BorderRadius.circular(14)),
                                  child: IconButton(
                                      onPressed: () {
                                        _openWeightSelectionBottomSheet(
                                            product);
                                      },
                                      icon: const Icon(Icons.add,
                                          color: Colors.white)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20),
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CartPage()));
          },
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Stack(
              children: [
                const Positioned(
                    top: 25,
                    right: 22,
                    child: Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                      size: 28,
                    )),
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
