import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class TaskCards extends StatelessWidget {
  final int isCompleted;
  TaskCards({this.isCompleted}):assert(isCompleted != null);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Draggable(
        feedback: Container(
          height: 200,
          width: 200,
          child: Card(
            child: Text('This is a card'),
          ),
        ),
        child: Container(
          height: 200,
          width: 200,
          child: Card(
            child: Text('This is a card'),
          ),
        ),
      ),
    );
  }
}
