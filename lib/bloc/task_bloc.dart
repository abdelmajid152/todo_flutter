import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/Task_model.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    _loadTasks();
    on<TaskAddEvent>(_taskAdd);
    on<TaskRemoveEvent>(_taskRemove);
    on<TaskToggleEvent>(_taskToggle);
  }

  Future<void> _taskAdd(TaskAddEvent event, Emitter<TaskState> emit) async {
    TaskModel task = TaskModel(
      title: event.title,
      id: const Uuid().v4(),
      isCompleted: false,
    );

  final  newList=[...state.tasksList, task];
    emit(TaskUpdate(newList));


    await _saveTasks(newList);
  }

  Future<void> _taskRemove(
      TaskRemoveEvent event, Emitter<TaskState> emit) async {
    final List<TaskModel> tasks = List.from(state.tasksList);

    tasks.removeWhere((task) => task.id == event.id);
    emit(TaskUpdate(tasks));
    await _saveTasks(tasks);
  }

  Future<void> _taskToggle(
      TaskToggleEvent event, Emitter<TaskState> emit) async {
    final List<TaskModel> tasks = state.tasksList
        .map((task) => task.id == event.id
            ? task.copyWith(isCompleted: !task.isCompleted)
            : task)
        .toList();
    emit(TaskUpdate(tasks));
    await _saveTasks(tasks);
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasksList');
    if (tasksJson != null) {
      final List<dynamic> tasksMap = jsonDecode(tasksJson);
      final tasks = tasksMap.map((task) => TaskModel.fromJson(task)).toList();
      emit(TaskUpdate(tasks));
    }
  }

  Future<void> _saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString('tasksList', tasksJson);
  }
}
