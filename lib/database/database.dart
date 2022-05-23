


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection{
  Future<Database> setDatabase()async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'to_do');

    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  Future<void> _onCreate(Database database, int version)async{
    String userData = "CREATE TABLE users (id INTEGER PRIMARY KEY,userName TEXT,fullName TEXT,email TEXT, password TEXT);";
    String task = "CREATE TABLE task_descriptions (id INTEGER PRIMARY KEY,taskTitle TEXT,taskDescription TEXT);";
    String pics = "CREATE TABLE pics_save (id INTEGER PRIMARY KEY,title TEXT,picture BLOB);";
    await database.execute(userData);
    await database.execute(task);
    await database.execute(pics);
  }
}