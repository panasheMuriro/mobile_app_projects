

import 'package:flutter/material.dart';
import 'package:multi_screen_app/screens/DetailsScreen.dart';

class Homescreen extends StatelessWidget{
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("HomeScreen Page")),
    
    body: Center(
      child: ElevatedButton(onPressed: () {Navigator.push(
        context, 
        MaterialPageRoute(builder: (context)=> DetailsScreen())
      );}
      , child: const Text("Go to DetailsScreen")),
    ),
    );
  }

}