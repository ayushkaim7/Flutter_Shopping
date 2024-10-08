import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_assignment/bottom_navigation.dart';
import 'package:shopping_app_assignment/cartpage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: BottomNavigation(),
    ),);
}


