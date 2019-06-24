import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:gamez_taskop/src/bloc/home_screen_bloc.dart';
import 'package:gamez_taskop/src/model/task.dart';

// This widget creates a list of tasks in form of stacked cards
// @isCompleted argument make sure that the
// list of the completed or incomplete tasks.
class TaskCards extends StatefulWidget {
  final int isCompleted;
  TaskCards({this.isCompleted}) : assert(isCompleted != null);

  @override
  _TaskCardsState createState() => _TaskCardsState();
}

class _TaskCardsState extends State<TaskCards> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeScreenBloc.getAllTasks(widget.isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
        stream: widget.isCompleted == 0
            ? homeScreenBloc.incompleteTaskStream
            : homeScreenBloc.completeTaskStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Container(
                width: MediaQuery.of(context).size.width,
                child: TinderSwapCard(
                  orientation: AmassOrientation.BOTTOM,
                  totalNum: snapshot.data.length,
                  stackNum: 3,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                  maxHeight: MediaQuery.of(context).size.width * 0.9,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  minHeight: MediaQuery.of(context).size.width * 0.8,
                  cardBuilder: (context, i) {
                    return Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.network(
                            'https://mdl.ferlicot.fr/files/MDLDemoLibrary/metaphor.png',
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(snapshot.data[i].title,
                                    style: Theme.of(context).textTheme.title),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  swipeCompleteCallback: (orientation) {
                    if (orientation == CardSwipeOrientation.LEFT) {
                      print('left');
                    } else if (orientation == CardSwipeOrientation.RIGHT) {
                      //changeTaskState(snapshot.data[i], widget.isCompleted == 0 ? true : false);
                    } else if (orientation == CardSwipeOrientation.TOP) {
                      print('top');
                    } else if (orientation == CardSwipeOrientation.BOTTOM) {
                      print('bottom');
                    }
                  },
                ));
          }
        });
  }

  void changeTaskState(Task task, bool isCompleted) {
    if (isCompleted) {
      task.setFinishedDate(DateTime.now());
      homeScreenBloc.changeTaskState(task);
    } else {
      task.setDueDate(DateTime.now().add(Duration(days: 1)));
      task.setFinishedDate(null);
    }
    task.setIsCompleted(isCompleted);
    homeScreenBloc.changeTaskState(task);
  }
}
