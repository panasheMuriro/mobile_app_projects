import 'package:flutter/material.dart';
import 'package:todo_list/AddTaskPage.dart';
import 'package:todo_list/TaskDetailsPage.dart';

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
  final List<Map<String, dynamic>> _todoItems = [];

  void _addTodoItem(String title, String description) {
    setState(() {
      _todoItems.add({
        'task': title,
        'description': description,
        'completed': false,
      });
    });
  }

  void _toggleTask(int index) {
    setState(() {
      _todoItems[index]['completed'] = !_todoItems[index]['completed'];
    });
  }

  void _navigateToAddTaskPage() async {
    // Navigate to AddTaskPage and wait for result
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddTaskPage(),
      ),
    );

    if (newTask != null) {
      _addTodoItem(newTask['title'], newTask['description']);
    }
  }

  void _navigateToTaskDetailsPage(Map<String, dynamic> task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailsPage(task: task),
      ),
    );
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
                    onTap: () => _navigateToTaskDetailsPage(task),
                    trailing: IconButton(
                      icon: Icon(
                        task['completed']
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: task['completed'] ? Colors.green : null,
                      ),
                      onPressed: () => _toggleTask(index),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _navigateToAddTaskPage,
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}