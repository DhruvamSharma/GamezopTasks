import 'package:flutter/material.dart';
import 'package:gamez_taskop/src/bloc/home_screen_bloc.dart';
import 'package:gamez_taskop/src/model/task.dart';
import 'package:gamez_taskop/src/ui/single_task_screen.dart';
import 'package:intl/intl.dart';


class CompletedTaskList extends StatefulWidget {
  final int isCompleted;
  CompletedTaskList({this.isCompleted}) : assert(isCompleted != null);
  @override
  _CompletedTaskListState createState() => _CompletedTaskListState();
}

class _CompletedTaskListState extends State<CompletedTaskList> {

  List<bool> taskStatus = List<bool>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeScreenBloc.getAllTasks(widget.isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
        stream: homeScreenBloc.completeTaskStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return Center(child: Text('No Tasks Presents'));
            }
            snapshot.data.forEach((task) {
              taskStatus.add(task.isCompleted);
            });
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return ListTile(
                  key: Key('${snapshot.data[i].taskId} $i'),
                  title: Text('${snapshot.data[i].title}'),
                  trailing: Checkbox(
                      value: taskStatus[i],
                      onChanged: (value) {
                        setState(() {
                          changeTaskState(snapshot.data[i], value);
                          taskStatus[i] = value;
                        });
                      }),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SingleTaskScreen(task: snapshot.data[i]);
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

  void changeTaskState(Task task, bool isCompleted) {
    task.setIsCompleted(isCompleted);
    task.setDueDate(DateTime.now().add(Duration(days: 1)));
    task.setFinishedDate(null);
    homeScreenBloc.changeTaskState(task);
  }
}
