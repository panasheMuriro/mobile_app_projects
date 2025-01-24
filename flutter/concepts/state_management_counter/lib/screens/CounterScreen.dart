import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {

  int _counter = 0;

  void _incrementCounter(){
    setState(() {
      _counter++;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Counter App"),),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("You pressed the button this many times: "),
          Text('$_counter',
          style: const TextStyle(
            fontSize: 40, fontWeight: FontWeight.bold
          ),),
          ElevatedButton(onPressed: ()=> _incrementCounter(), child: const Text("Add Count"))
        ],
      ),),
    );

  }
}