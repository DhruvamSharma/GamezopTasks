import 'package:flutter/material.dart';
import 'package:gamez_taskop/src/bloc/home_screen_bloc.dart';
import 'package:gamez_taskop/src/ui/task_cards.dart';
import 'package:gamez_taskop/src/ui/task_list.dart';
import 'package:gamez_taskop/src/ui/user_profile.dart';
import 'create_task_screen.dart';

// This widgets makes up the layout of the whole application
// Appbar actions like showing tasks in cards or list or showing profile page.
// An Extended FAB for creating new task.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    homeScreenBloc.setListOrCard(true);
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list,), onPressed: () {
            homeScreenBloc.setListOrCard(true);
          }),
          IconButton(icon: Icon(Icons.style), onPressed: () {
            homeScreenBloc.setListOrCard(false);
          }),

          IconButton(icon: Icon(Icons.account_circle), onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return UserProfileScreen();
            }));
          }),
        ],
        title: Text(
          'Gamezop Tasks',
          style:
              Theme.of(context).textTheme.title.copyWith(color: Colors.white),
        ),
        bottom: TabBar(
          controller: _tabController,
            tabs: [
          Tab(
            text: 'Incomplete',
          ),
          Tab(
            text: 'Completed',
          )
        ]),
        //backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            // This widget appears for the tasks that are incomplete.
            child: StreamBuilder<bool>(
                stream: homeScreenBloc.listCardStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    if (snapshot.data) {
                      return TaskList(isCompleted: 0, );
                    } else {
                      return TaskCards(isCompleted: 0);
                    }
                  }
                }),
          ),
          Center(
            // This widget appears for the tasks that are complete already.
            child: StreamBuilder<bool>(
                stream: homeScreenBloc.listCardStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    if (snapshot.data) {
                      return TaskList(isCompleted: 1,);
                    } else {
                      return TaskCards(isCompleted: 1,);
                    }
                  }
                }),
          ),
        ],
      ),
      // This widgets helps in creating new tasks
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Create a Task'),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return CreateTaskScreen();
          }));
        },
        tooltip: 'Create a task',
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
