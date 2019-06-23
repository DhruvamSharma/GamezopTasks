import '../model/task.dart';
import 'database.dart';

class TaskApiProvider {
  Future<int> createTask(Task task) async {
    final db = await DBProvider.db.database;
    int id = await db.insert("tasks", Task.toMap(task));
    return id;
  }

  // This method fetch all the tasks.
  // Status of the task is stated by the argument: @isCompleted
  // This method also updates the status of the task that are completed
  Future<List<Task>> getAllTasks(int isCompleted) async {
    updateAllTaskCompletionStatus();

    final db = await DBProvider.db.database;
    List<Map<String, dynamic>> map = await db
        .rawQuery('SELECT * FROM tasks where is_completed = $isCompleted');
    return Task.fromMap(map);
  }

  // This method checks for the tasks that have been completed.
  // This method runs whenever a query to fetch a task is made.
  void updateAllTaskCompletionStatus() async {
    final db = await DBProvider.db.database;
    List<Map<String, dynamic>> map = await db
        .rawQuery('SELECT * FROM tasks where is_completed = 0');

    List<Task> taskList = Task.fromMap(map);

    for (int i = 0; i < taskList.length; i++ ) {
      Task task = taskList[i];
      bool isCompleted = task.dueDate.isBefore(DateTime.now());
      if (isCompleted) {
        task.setFinishedDate(DateTime.now());
        task.setIsCompleted(true);
        updateTask(task);
      }
    }
  }

  // This method updates the task with the required @args
  Future<int> updateTask(Task task) async {
    print('${task.isCompleted}');
    final db = await DBProvider.db.database;
    return await db.update(
      'tasks',
      Task.toMap(task),
      where: 'task_id = ?',
      whereArgs: [task.taskId],
    );
  }

  // This method deletes the task with it's id.
  Future<int> deleteTask(Task task) async {
    final db = await DBProvider.db.database;
    return await db.delete(
      'tasks',
      where: 'task_id = ?',
      whereArgs: [task.taskId],
    );
  }

  changeTaskState(Task task) {
    updateTask(task);
  }
}

final taskApiProvider = TaskApiProvider();
