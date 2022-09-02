// ignore_for_file: unused_import

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> TaskList = <Task>[].obs;

  Future<int> addTask({Task? task}) {
    return DBHelper.Insert(task!);
  }

  Future<void> getTask() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    TaskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void Delete(Task task) async {
    await DBHelper.Delete(task);
    getTask();
  }

  void deleteAll() async {
    await DBHelper.DeleteAll();
    getTask();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.upDate(id);
    getTask();
  }
}
