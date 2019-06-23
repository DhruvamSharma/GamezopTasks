import 'package:flutter/material.dart';
import 'package:gamez_taskop/src/bloc/home_screen_bloc.dart';
import 'package:gamez_taskop/src/model/task.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController(),
      _imageController = TextEditingController();

  File _image;
  DateTime selectedDate = DateTime.now();
  TimeOfDay dueTime = TimeOfDay.now();
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");

  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _image = image;
      _imageController.text = _image.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Create A New Task',
          style: Theme.of(context).textTheme.title,
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(helperText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(helperText: 'Description'),
            ),
            IconButton(
              onPressed: () {
                getImage(true);
              },
              icon: Icon(Icons.camera_alt),
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(helperText: 'Image'),
            ),

            DateTimePickerFormField(
              format: dateFormat,
              dateOnly: false,
              onChanged: (date) {
                selectedDate = date;
              },
            ),
            MaterialButton(
                child: Text(
                  'Create',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.indigo,
                onPressed: () async {
                  int taskId = await homeScreenBloc.createTask(Task.fromTask(
                    _titleController.text,
                    _descriptionController.text,
                    false,
                    _imageController.text,
                    DateTime.now(),
                    selectedDate,
                    DateTime.now().add(Duration(days: 100)),
                  ));

                  if (taskId > 0) {
                    // TODO provide humane feedback
                  }
                })
          ],
        ),
      ),
    );
  }
}
