import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TO.DO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// List to hold the to-do items

  final List<Map<String, dynamic>> _todoItems = [];
  final TextEditingController _controller =
      TextEditingController(); // Controller for input

  void _addTodoItem() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _todoItems.add({
          'task': _controller.text,
          'completed': false, // Initially, the task is not completed
        });
      });
      _controller.clear(); // Clear the input field after adding
    }
  }

  void _toggleTask(int index) {
    setState(() {
      _todoItems[index]['completed'] = !_todoItems[index]['completed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: _todoItems.length,
                    itemBuilder: (context, index) {
                      final task = _todoItems[index];
                      return ListTile(
                        title: Text(
                          task['task'],
                          style: TextStyle(
                            decoration: task['completed']
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            task['completed']
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: task['completed'] ? Colors.green : null,
                          ),
                          onPressed: () =>
                              _toggleTask(index), // Toggle completion state
                        ),
                      );
                    })),
            Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                        
                      controller: _controller,
                
                      decoration:
                          const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            labelText: "Enter Task"),
                    )),
                    CircleAvatar(
                        backgroundColor: Colors.green,
                        child: IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: _addTodoItem,
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
