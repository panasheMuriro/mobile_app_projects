import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_counter/providers/counter_provider.dart';
import 'package:state_management_counter/screens/CounterScreen.dart';
import 'package:state_management_counter/screens/CounterScreenProvider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CounterProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CounterScreenProvider());
  }
}