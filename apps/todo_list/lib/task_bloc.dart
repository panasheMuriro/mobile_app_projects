import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<AddTask>(_onAddTask);
    on<ToggleTask>(_onToggleTask);
    on<LoadTasks>(_onLoadTasks);

    _loadTasks(); // Load tasks when the BLoC is initialized
  }

  // Load tasks from SharedPreferences
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? tasks = prefs.getStringList('tasks');
    if (tasks != null) {
      final loadedTasks = tasks.map((taskString) {
        final taskDetails = taskString.split('|');
        return {
          'task': taskDetails[0],
          'description': taskDetails[1],
          'completed': taskDetails[2] == 'true'
        };
      }).toList();
      // Emit loaded tasks state after loading from SharedPreferences
      add(LoadTasks(tasks: loadedTasks));
    } else {
      // Emit initial empty task state if no tasks were found
      emit(TaskLoaded([]));
    }
  }

  // Save tasks to SharedPreferences
  Future<void> _saveTasks(List<Map<String, dynamic>> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> taskStrings = tasks.map((task) {
      return '${task['task']}|${task['description']}|${task['completed']}';
    }).toList();
    await prefs.setStringList('tasks', taskStrings);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    if (state is TaskLoaded) {
      final updatedTasks = List<Map<String, dynamic>>.from(state.tasks)
        ..add(event.task);
      emit(TaskLoaded(updatedTasks));
      await _saveTasks(updatedTasks);
    }
  }

  void _onToggleTask(ToggleTask event, Emitter<TaskState> emit) async {
    print("Working");


    if (state is TaskLoaded) {
      final updatedTasks = List<Map<String, dynamic>>.from(state.tasks);
      final task = updatedTasks[event.index];
      task['completed'] = !task['completed'];
      // print(task);
      emit(TaskLoaded(updatedTasks));
      await _saveTasks(updatedTasks);
    }
  }

  void _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) {
    emit(TaskLoaded(event.tasks));
  }
}
