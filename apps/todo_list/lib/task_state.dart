part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  final List<Map<String, dynamic>> tasks;

  const TaskState(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskInitial extends TaskState {
  // const TaskInitial() : super([]);
   static const List<Map<String, dynamic>> _emptyList = [];
  const TaskInitial() : super(_emptyList);
}

class TaskLoaded extends TaskState {
  const TaskLoaded(List<Map<String, dynamic>> tasks) : super(tasks);
}
