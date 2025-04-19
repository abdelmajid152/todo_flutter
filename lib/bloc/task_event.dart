part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class TaskAddEvent extends TaskEvent {
  final String title;

   TaskAddEvent(this.title);
}

class TaskRemoveEvent extends TaskEvent {
  final String id;

   TaskRemoveEvent(this.id);
}

class TaskToggleEvent extends TaskEvent {
  final String id;

   TaskToggleEvent(this.id);
}
