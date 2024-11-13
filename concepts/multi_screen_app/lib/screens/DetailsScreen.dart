

import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DetailsScreen Page')),
      body: Center(
        child: ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Back to HomeScreen")),
      ),
    );
  }
}