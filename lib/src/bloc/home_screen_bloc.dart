import 'package:gamez_taskop/src/model/task.dart';
import 'package:gamez_taskop/src/resources/task_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreenBloc {


  Stream<bool> get listCardStream => _listCardSubject.stream;
  final _listCardSubject = BehaviorSubject<bool>();

  Stream<List<Task>> get taskStream => _taskSubject.stream;
  final _taskSubject = BehaviorSubject<List<Task>>();

  void getAllTasks(int isCompleted) async {
    List<Task> tasks = await taskApiProvider.getAllTasks(isCompleted);
    if (isCompleted == 0) {
      _taskSubject.sink.add(tasks);
    }
  }

  Future<int> createTask(Task task) async {
    int taskId = await taskApiProvider.createTask(task);
    getAllTasks(0);
    return taskId;
  }

  void setListOrCard (bool listOrCard) {
    _listCardSubject.sink.add(listOrCard);
  }

  void dispose() {
    _listCardSubject.close();
    _taskSubject.close();
  }

  void changeTaskState(int taskId, bool isCompleted) async {
    //await taskApiProvider.changeTaskState(taskId, isCompleted);
    getAllTasks(0);
  }
}

var homeScreenBloc = HomeScreenBloc();