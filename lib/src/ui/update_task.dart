import 'package:flutter/material.dart';
import 'package:gamez_taskop/src/bloc/single_task_screen_bloc.dart';
import 'package:gamez_taskop/src/model/task.dart';

class UpdateTaskScreen extends StatefulWidget {
  final Task task;

  UpdateTaskScreen({this.task}) : assert(task != null);

  @override
  _UpdateTaskScreenState createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  TextEditingController _titleController,
      _descriptionController,
      _imageController;

  @override
  void initState() {
    // TODO: implement initState
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    _imageController = TextEditingController(text: widget.task.imagePath);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Your Task Details: ',
          style: Theme.of(context).textTheme.title,
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(helperText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(helperText: 'Description'),
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(helperText: 'Image'),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () async {
                      int deletedRowCount = await singleTaskBloc.deleteTask(
                          Task(
                            widget.task.taskId,
                            _titleController.text,
                            _descriptionController.text,
                            false,
                            _imageController.text,
                            widget.task.createdDate,
                            widget.task.dueDate,
                            widget.task.finishedDate,
                          ));
                      if (deletedRowCount > 0) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Delete',),
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () async {
                      int updatedRowCount = await singleTaskBloc.updateTask(
                          Task(
                              widget.task.taskId,
                              _titleController.text,
                              _descriptionController.text,
                              false,
                              _imageController.text,
                              widget.task.createdDate,
                              widget.task.dueDate,
                              widget.task.finishedDate,
                          ));
                      if (updatedRowCount > 0) {
                        // TODO show humane feedback
                      }
                    },
                    child: Text('Update',  style: TextStyle(color: Colors.white),),
                    color: Colors.indigo
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
