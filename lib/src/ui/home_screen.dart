import 'package:flutter/material.dart';
import 'package:gamez_taskop/src/bloc/home_screen_bloc.dart';
import 'package:gamez_taskop/src/ui/task_cards.dart';
import 'package:gamez_taskop/src/ui/task_list.dart';
import 'create_task_screen.dart';

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
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Gamezop Tasks',
          style: Theme.of(context).textTheme.title.copyWith(
            color: Colors.white
          ),
        ),
        //backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
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

          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return CreateTaskScreen();
          }));

        },
        tooltip: 'Create a task',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
