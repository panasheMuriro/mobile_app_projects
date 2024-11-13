

import 'package:flutter/material.dart';
import 'package:multi_screen_app/screens/DetailsScreen.dart';

class Homescreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("HomeScreen Page")),
    
    body: Center(
      child: ElevatedButton(onPressed: () {Navigator.push(
        context, 
        MaterialPageRoute(builder: (context)=> DetailsScreen())
      );}
      , child: Text("Go to DetailsScreen")),
    ),
    );
  }

}