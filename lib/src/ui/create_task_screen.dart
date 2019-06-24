import 'package:flutter/material.dart';
import 'package:gamez_taskop/src/bloc/home_screen_bloc.dart';
import 'package:gamez_taskop/src/model/task.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';


// This widget appears when we click on the extended fab.
// It helps in creating a new task.
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

    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            title: Text('Task Detail'),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  getImage(true);
                },
                icon: Icon(Icons.camera_alt),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _image == null
                  ? Image.network(
                'https://mdl.ferlicot.fr/files/MDLDemoLibrary/metaphor.png',
                fit: BoxFit.cover,
              )
                  : Image.file(_image, fit: BoxFit.cover,),
            ),
          ),

          SliverList(delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),

                  DateTimePickerFormField(
                    format: dateFormat,
                    decoration: InputDecoration(labelText: 'Due Date'),
                    dateOnly: false,
                    onChanged: (date) {
                      selectedDate = date;
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: MaterialButton(
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
                              null,
                            ));

                            if (taskId > 0) {
                              // TODO provide humane feedback
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ])),
        ],
      ),
    );

  }
}
