part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TaskEvent {
  final Map<String, dynamic> task;

  const AddTask(this.task);

  @override
  List<Object> get props => [task];
}

class ToggleTask extends TaskEvent {
  final int index;

  const ToggleTask(this.index);

  @override
  List<Object> get props => [index];
}

class LoadTasks extends TaskEvent {
  final List<Map<String, dynamic>> tasks;

  const LoadTasks({required this.tasks});

  @override
  List<Object> get props => [tasks];
}
