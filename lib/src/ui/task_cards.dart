import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:gamez_taskop/src/bloc/home_screen_bloc.dart';
import 'package:gamez_taskop/src/model/task.dart';

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
      stream: widget.isCompleted == 0 ? homeScreenBloc.incompleteTaskStream : homeScreenBloc.completeTaskStream,
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
                      children: <Widget>[
                        Image.network(
                          'https://mdl.ferlicot.fr/files/MDLDemoLibrary/metaphor.png',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  );
                },
                swipeCompleteCallback: (orientation) {
                  if (orientation == CardSwipeOrientation.LEFT) {
                    print ('left');
                  } else if (orientation == CardSwipeOrientation.RIGHT) {
                    print ('right');
                  } else if (orientation == CardSwipeOrientation.TOP) {
                    print('top');
                  } else if (orientation == CardSwipeOrientation.BOTTOM) {
                    print('bottom');
                  }
                },
              ));
        }
        }
    );
  }
}
