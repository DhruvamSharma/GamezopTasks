import 'package:gamez_taskop/src/model/task.dart';
import 'package:gamez_taskop/src/resources/task_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class SingleTaskScreenBloc {


  void updateTask(Task task) async {
    await taskApiProvider.updateTask(task);
  }

  Future<int> deleteTask(Task task) async {
    return await taskApiProvider.deleteTask(task);
  }

  void dispose() {

  }
}

var singleTaskBloc = SingleTaskScreenBloc();