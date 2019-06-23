import 'package:flutter/material.dart';
import 'package:gamez_taskop/src/bloc/home_screen_bloc.dart';
import 'package:gamez_taskop/src/model/task.dart';
import 'package:gamez_taskop/src/resources/task_api_provider.dart';
import 'package:gamez_taskop/src/ui/task_cards.dart';

import 'package:gamez_taskop/src/ui/task_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    homeScreenBloc.setListOrCard(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: StreamBuilder<bool>(
            stream: homeScreenBloc.listCardStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                if (snapshot.data) {
                  return TaskList();
                } else {
                  return TaskCards();
                }
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeScreenBloc.createTask(Task.fromTask(
            'title',
            'description',
            false,
            'image_path',
            DateTime.now(),
            DateTime.now().add(Duration(days: 5)),
            DateTime.now().add(Duration(days: 100)),
          ));
        },
        tooltip: 'Create a task',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
