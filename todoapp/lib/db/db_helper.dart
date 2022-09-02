// ignore_for_file: unused_import, prefer_const_declarations, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String tableName = 'Task';

  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint('not null db');
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'task.db';
        debugPrint('in database path');

        _db = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
          debugPrint('Create new one');

          // When creating the db, create the table
          await db.execute(
            'CREATE TABLE $tableName '
            '(id INTEGER PRIMARY KEY AUTOINCREMENT,'
            ' tittle STRING, note TEXT, date STRING ,'
            'startTime STRING , endTime STRING ,'
            'remind INTEGER , repeat STRING ,'
            'color INTEGER ,'
            'isCompleted INTEGER)',
          );
        });
        print('Database Created');
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int> Insert(Task? task) async {
    try {
      print('insert is called');
      return await _db!.insert(tableName, task!.toJson());
    } catch (e) {
      print(e);
      return 90000;
    }
  }

  static Future<int> Delete(Task task) async {
    print('delete is called');
    return await _db!.delete(tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<int> DeleteAll() async {
    print('deleteAll is called');
    return await _db!.delete(tableName);
  }

  static Future<int> upDate(int id) async {
    print('Update is called');
    try {
      return await _db!.rawUpdate(
        '''
    UPDATE Task
    SET isCompleted = ?
    WHERE id = ? 
''',
        [1, id],
      );
    } catch (e) {
      print(e);
      return 0000;
    }
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('query is called');
    return await _db!.query(tableName);
  }
}
