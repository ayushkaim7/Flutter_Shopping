import 'package:flutter/material.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Me' , style: TextStyle(fontFamily: 'Poppins'),),

      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Only categories page is the main page" , style: TextStyle(fontFamily: 'Poppins' , fontSize: 16),),
            SizedBox(height: 10,),
            Text("Go to categories , Then only fruits \n and vegetables have products ", style: TextStyle(fontFamily: 'Poppins' , fontSize: 16)),
            SizedBox(height: 10,),
            Text("can search for fruits or vegetables \n from search bar \n can add the products into cart", style: TextStyle(fontFamily: 'Poppins' , fontSize: 16))
          ],
        ),
      ),
    );
  }
}