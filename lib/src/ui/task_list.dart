import 'package:flutter/material.dart';
import 'package:gamez_taskop/src/bloc/home_screen_bloc.dart';
import 'package:gamez_taskop/src/model/task.dart';

import 'update_task.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  bool checkedState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeScreenBloc.getAllTasks(0);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
        stream: homeScreenBloc.taskStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text('${snapshot.data[i].title}'),
                  trailing: Checkbox(
                      value: snapshot.data[i].isCompleted,
                      onChanged: (value) {
                        changeTaskState(snapshot.data[i].taskId, value);
                      }),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                          return UpdateTaskScreen(task: snapshot.data[i]);
                    }));
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Some error, please try again later');
          }
        });
  }

  void changeTaskState(int taskId, bool isCompleted) {
    setState(() {
      isCompleted = true;
    });
    homeScreenBloc.changeTaskState(taskId, isCompleted);
  }
}
