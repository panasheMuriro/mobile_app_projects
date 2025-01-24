import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/AddTaskPage.dart';
import 'package:todo_list/TaskDetailsPage.dart';
import 'task_bloc.dart';
// Main.dart (including Bloc implementation)
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'task_bloc.dart'; // Make sure you import your task_bloc

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'TO.DO'),
      ),
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
  void _navigateToAddTaskPage() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskPage()),
    );

    if (newTask != null) {
      context.read<TaskBloc>().add(AddTask({
            'task': newTask['title'],
            'description': newTask['description'],
            'completed': false,
          }));
    }
  }

  void _navigateToTaskDetailsPage(Map<String, dynamic> task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailsPage(task: task)),
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
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskInitial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TaskLoaded) {
                    if (state.tasks.isEmpty) {
                      return const Center(child: Text('No tasks available.'));
                    }
                    return ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];
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
                            onPressed: () {
                              context.read<TaskBloc>().add(ToggleTask(index));
                              print(task);
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: Text('No tasks available.'));
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
