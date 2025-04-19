import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/task_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'To Do App'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title)
      ),
      body: Center(
          child: BlocProvider(
        create: (context) => TaskBloc(),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            final bloc = context.read<TaskBloc>();
            return Column(
              children: [
                const SizedBox(height: 20),
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'Enter Task',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isEmpty) {
                      return;
                    }
                    bloc.add(TaskAddEvent(controller.text));

                    controller.clear();
                  },
                  child: const Text('Add Task'),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.tasksList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.tasksList[index].title),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                              value: state.tasksList[index].isCompleted,
                              onChanged: (value) {
                                bloc.add(
                                    TaskToggleEvent(state.tasksList[index].id));
                              }),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              bloc.add(
                                  TaskRemoveEvent(state.tasksList[index].id));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      )),
    );
  }
}
