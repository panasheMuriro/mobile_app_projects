import 'package:flutter/material.dart';
import 'services/todo_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoService _todoService = TodoService();
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await _todoService.getTodos();
    setState(() {
      _todos = todos;
    });
  }

  Future<void> _addTodo() async {
    final String task = _controller.text.trim();

    if (task.isEmpty) return;

    final newTodo = {'task': task, 'completed': false};
    setState(() {
      _todos.add(newTodo);
    });

    await _todoService.saveTodos(_todos);
    _controller.clear();
  }

  Future<void> _toggleTodoCompletion(int index) async {
    setState(() {
      _todos[index]['completed'] = !_todos[index]['completed'];
    });

    await _todoService.saveTodos(_todos);
  }

  Future<void> _deleteTodo(int index) async {
    setState(() {
      _todos.removeAt(index);
    });

    await _todoService.saveTodos(_todos);
  }

  final DateTime now = DateTime.now();  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(now.),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter a task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final todo = _todos[index];
                  return ListTile(
                    title: Text(
                      todo['task'],
                      style: TextStyle(
                        decoration: todo['completed']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    leading: Checkbox(
                      value: todo['completed'],
                      onChanged: (_) => _toggleTodoCompletion(index),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteTodo(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
