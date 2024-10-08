import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_assignment/fruits.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new)),
        title: const Text('Cart' , style: TextStyle(fontFamily: 'Poppins' , fontSize: 22 , fontWeight: FontWeight.w600),),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 20),
        itemCount: cartProvider.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartProvider.cartItems[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              //borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 0,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
   
                  Stack(
                    children: [
                      Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(cartItem.product.imageUrl),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                     Positioned(
        top: 2,  
        left: 32,   
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9), 
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.withOpacity(0.4)
            )
          ),
          child: Column(
            children: [
              Text(
                '${cartItem.weight.toStringAsFixed(1)}',  
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text("Kg" , style:TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ) ,)
            ],
          ),
        ),
      ),
                    ] 
                  ),
                  const SizedBox(width: 15),
          
     
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
          
                        Text(
                          cartItem.product.name,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
         
                        Text(
                          'Rs. ${cartItem.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),

                  TextButton(onPressed: (){
                    cartProvider.removeFromCart(cartItem);

                  }, child: Text("Remove" ,
                   style:TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blue.shade700,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue.shade700,
                    decorationThickness: 2,
                    
                   ),),

                   )
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20 , right: 20 , bottom: 30),
        child: Stack(
          children: [
            Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: BorderRadius.circular(28)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Together to pay' , style: TextStyle(fontFamily: 'Poppins' , fontSize: 18 , color: Colors.white60),),
                  const SizedBox(height: 5,),
                  cartProvider.totalPrice == 0 ?  Text('Cart is empty',  style: const TextStyle(fontFamily: 'Poppins' , fontSize: 20 , color: Colors.white , fontWeight: FontWeight.w500),): Text('Rs. ${cartProvider.totalPrice}',  style: const TextStyle(fontFamily: 'Poppins' , fontSize: 20 , color: Colors.white , fontWeight: FontWeight.w500),),

                  
                ],
                
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 40,   
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 24, 
            ),
          ),
          ]
        ),
      ),
    );
  }
}


class CartItem {
  final Product product;
  final double weight;
  final double totalPrice;

  CartItem({required this.product, required this.weight, required this.totalPrice});
}


class CartProvider with ChangeNotifier {
  final List<CartItem> _cart = [];
  List<CartItem> get cartItems => _cart;

  void addToCart(Product product, double weight, double totalPrice) {
    _cart.add(CartItem(product: product, weight: weight, totalPrice: totalPrice));
    notifyListeners();
  }

  int get cartItemCount => _cart.length;

  void removeFromCart(CartItem cartItem) {
    _cart.remove(cartItem);
    notifyListeners();
  }




  double get totalPrice {
    return _cart.fold(0.0, (sum, item) => sum + item.totalPrice);
  }
} 

