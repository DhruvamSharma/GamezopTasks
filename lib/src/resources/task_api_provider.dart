import '../model/task.dart';
import 'database.dart';

class TaskApiProvider {
  Future<int> createTask(Task task) async {
    final db = await DBProvider.db.database;
    int id = await db.insert("tasks", Task.toMap(task));
    return id;
  }

  Future<List<Task>> getAllTasks(int isCompleted) async {
    final db = await DBProvider.db.database;
    List<Map<String, dynamic>> map = await db
        .rawQuery('SELECT * FROM tasks where is_completed = $isCompleted');
    return Task.fromMap(map);
  }

  Future<int> updateTask(Task task) async {
    final db = await DBProvider.db.database;
    return await db.update(
      'tasks',
      Task.toMap(task),
      where: 'task_id = ?',
      whereArgs: [task.taskId],
    );
  }

  Future<int> deleteTask(Task task) async {
    final db = await DBProvider.db.database;
    return await db.delete(
      'tasks',
      where: 'task_id = ?',
      whereArgs: [task.taskId],
    );
  }
}

final taskApiProvider = TaskApiProvider();
