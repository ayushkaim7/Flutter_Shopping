import 'package:flutter/material.dart';
import 'package:shopping_app_assignment/pages/categories.dart';
import 'package:shopping_app_assignment/pages/favorite.dart';
import 'package:shopping_app_assignment/pages/home.dart';
import 'package:shopping_app_assignment/pages/more.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int _currentindex =1;


  final List<Widget> _pages = [
    Home(),
    Categories(),
    Favorite(),
    More(),
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      
        body: IndexedStack(
          index: _currentindex,
          children: _pages,
      
      
        ),
        bottomNavigationBar: Container(
          height: 80,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            
            currentIndex: _currentindex,
            type: BottomNavigationBarType.fixed,
            onTap: (int index){
              setState(() {
                _currentindex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined , size: 30,),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined ,size: 30),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline ,size: 30),
                label: "Favorite",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz ,size: 30),
                label: "More",
              ),
            ],
            selectedLabelStyle: TextStyle(fontFamily: 'Poppins' , fontSize: 14 , fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(fontFamily: 'Poppins' , fontSize: 14 , fontWeight: FontWeight.w500),
            selectedItemColor: Colors.blue.shade700,
            ),
        ),
      ),
    );
  }
}