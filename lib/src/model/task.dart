import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
class Task {
  @JsonKey(name: 'task_id')
  int _taskId;
  @JsonKey(name: 'title')
  String _title;
  @JsonKey(name: 'description')
  String _description;
  @JsonKey(name: 'is_completed')
  bool _isCompleted;

  set createdDate(DateTime value) {
    _createdDate = value;
  }

  @JsonKey(name: 'image_path')
  String _imagePath;
  @JsonKey(name: 'created_date')
  DateTime _createdDate;
  @JsonKey(name: 'due_date')
  DateTime _dueDate;
  @JsonKey(name: 'finished_date')
  DateTime _finishedDate;
//  @JsonKey(name: 'due_time')
//  TimeOfDay _dueTime;


  int get taskId => _taskId;

  Task.fromTask(this._title, this._description, this._isCompleted, this._imagePath,
      this._createdDate, this._dueDate, this._finishedDate);

  Task(this._taskId, this._title, this._description, this._isCompleted,
      this._imagePath, this._createdDate, this._dueDate, this._finishedDate);

  static Map<String, dynamic> toMap(Task task) {
    return {
      'title': task._title,
      'description': task._description,
      'is_completed': task._isCompleted,
      'image_path': task._imagePath,
      'created_date': task._createdDate.toIso8601String(),
      'due_date': task._dueDate.toIso8601String(),
      'finished_date': task.finishedDate == null ? '': task._finishedDate.toIso8601String()
    };
  }

  static List<Task> fromMap(List<Map<String, dynamic>> map) {
    List<Task> taskList = List<Task>();
    for (int i = 0; i < map.length; i++) {
      Task task = Task(
          map[i]['task_id'],
          map[i]['title'],
          map[i]['description'],
          resolveIsCompleted(map[i]['is_completed']),
          map[i]['image_path'],
          resolveDate(map[i]['created_date']),
          resolveDate(map[i]['due_date']),
          map[i]['finished_date'].toString().isEmpty ? null :resolveDate(map[i]['finished_date'])
          //resolveTime(map[i]['due_time'])
      );
      taskList.add(task);
    }
    return taskList;
  }

  static bool resolveIsCompleted(int bit) {
    if (bit == 0) {
      return false;
    } else {
      return true;
    }
  }

  static DateTime resolveDate(String date) {
    return DateTime.parse(date);
  }

  String get title => _title;

  String get description => _description;

  bool get isCompleted => _isCompleted;

  String get imagePath => _imagePath;

  DateTime get createdDate => _createdDate;

  DateTime get dueDate => _dueDate;

  DateTime get finishedDate => _finishedDate;


  void setIsCompleted(bool value) {
    _isCompleted = value;
  }

  void setFinishedDate(DateTime value) {
    _finishedDate = value;
  }

  void setDueDate(DateTime value) {
    _dueDate = value;
  }

//  TimeOfDay get dueTime => _dueTime;
//
//  static TimeOfDay resolveTime(String dueTime) {
//    return
//  }
}
