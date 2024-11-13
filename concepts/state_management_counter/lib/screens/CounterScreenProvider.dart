import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_counter/providers/counter_provider.dart';

class CounterScreenProvider extends StatelessWidget {
  const CounterScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Counter Screen Provider")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You pressed this button this many times"),
            Consumer<CounterProvider>(builder: (context, counterProvider, child){
              return Text('${counterProvider.counter}',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),);
            }),
            SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              context.read<CounterProvider>().incrementCounter();
            }, child: Text("increment"))

          ],
        ),
      ),
    );
  }
}