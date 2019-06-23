import 'package:flutter/material.dart';
import 'package:gamez_taskop/src/bloc/home_screen_bloc.dart';
import 'package:gamez_taskop/src/model/task.dart';

import 'common/task_list.dart';

class IncompleteTaskList extends StatefulWidget {
  final int isCompleted;
  IncompleteTaskList({this.isCompleted}): assert(isCompleted != null);
  @override
  _IncompleteTaskListState createState() => _IncompleteTaskListState();
}

class _IncompleteTaskListState extends State<IncompleteTaskList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeScreenBloc.getAllTasks(widget.isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
        stream: homeScreenBloc.incompleteTaskStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {

            if (snapshot.data.length == 0) {
              return Center(child: Text('No Tasks Presents'));
            }
            return CommonTaskList(taskList: snapshot.data);
          } else if (snapshot.hasError) {
            return Text('Some error, please try again later');
          }
        });
  }
}
