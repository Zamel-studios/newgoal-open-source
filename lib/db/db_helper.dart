import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'tasks';
  static final String dbname = "tasks.db";

  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint("not null db");
      return;
    }
    try {
      String _path = await getDatabasesPath() + '$dbname';
      debugPrint("in database path");
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          debugPrint("creating a new one");
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, note TEXT, date STRING, "
            "startTime STRING, endTime STRING, "
            "remind INTEGER, repeat STRING, "
            "color INTEGER, "
            "ishabit INTEGER, "
            "isCompleted INTEGER)",
          );

          //UPDATE 1: ADDED COLUMN is_habit
        },
      );

      print("table  is cteated successfully =-=-=-=-=-=-=-=-=-=-");
    } catch (e) {
      print("table ERROROOROOROROROROROOROROOR=-=-=-=-=-=-=-=-=-=-");

      print(e);
    }
  }

  static Future<int> insert(Task task) async {
    print("insert function called");
    return await _db!.insert(_tableName, task.toJson());
  }

  static Future<int> delete(Task task) async =>
      await _db!.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return _db!.query(
      _tableName,
    );
    //where: "ishabit = 1"
  }

  static Future<int> update(int? id) async {
    print("update function called");
    return await _db!.rawUpdate(
        '''
    UPDATE tasks   
    SET isCompleted = ?
    WHERE id = ?
    ''',
        [1, id]);
  }

  deletDatabase() async {
    //this can be called  by a button to empty cart
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, '$dbname');
    print('deleted table***********************');
    await deleteDatabase(path); //built in function
  }

  static Future<int?> getTaskCount(var date) async {
    final List<Map<String, dynamic>> countResult = await _db!.rawQuery(
      'SELECT COUNT(*) FROM $_tableName  WHERE isCompleted =1 ', //
    );
    //retrieve the N.O tasks which have the same date and are completed

    return Sqflite.firstIntValue(countResult);
  }
}
