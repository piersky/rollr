import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:rollr/models/execution.dart';
import 'package:intl/intl.dart';

class DatabaseHelper {
  static final int _version = 1;
  static final String _dbName = "roller_trai.db";
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  static final String tableExecution = 'execution';

  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    print("Direcoty DB = $path");
    var database = await openDatabase(
      path,
      version: _version,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $tableExecution ("
        "id INTEGER PRIMARY KEY,"
        "execution_time DATETIME DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),"
        "exercise TEXT,"
        "result INT,"
        "difficulty TEXT"
        ")");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    switch (oldVersion) {
      case 1:
        print("Versione 1");
        break;
      case 2:
        print("Versione 2");
        break;
    }
  }

  Future<int> insertExecution(Execution execution) async {
    print("Inserisco $execution");

    var dbClient = await db;
    int id = await dbClient.insert(tableExecution, execution.toMap());
    return id;
  }

  Future<Execution> queryExecutionById(int id) async {
    var dbClient = await db;

    List<Map> list = await dbClient.query(
      tableExecution,
      columns: ['id', 'execution_time', 'exercise', 'result', 'difficulty'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (list.length > 0) {
      return Execution.fromMap(list.first);
    }

    return null;
  }

  Future<List<Execution>> queryAllExecutions() async {
    var dbClient = await db;

    var result = await dbClient.query(
      tableExecution,
      orderBy: 'execution_time DESC',
    );

    List<Execution> list = result.isNotEmpty
        ? result.map((c) => Execution.fromMap(c)).toList()
        : null;

    for (Execution l in list) {
      print("ID ${l.id} - Data " +
          DateFormat("y-M-d").format(l.executionTime) +
          " | Difficoltà " +
          l.difficulty.toString() +
          " | Esercizio " +
          l.exercise +
          " | Risultato " +
          l.result.toString());
    }

    return list;
  }

  Future<List<Execution>> queryExecutions4History() async {
    var dbClient = await db;
    var query =
        "SELECT strftime('%Y%m%d', execution_time), difficulty, exercise, result, COUNT(*) FROM execution GROUP BY strftime('%Y%m%d', execution_time), difficulty, exercise, result ORDER BY strftime('%Y%m%d', execution_time) DESC, difficulty ASC, exercise ASC";
    print(query);
    var result = await dbClient.rawQuery(query);

    List<Execution> list = result.isNotEmpty
        ? result.map((c) => Execution.fromMap(c)).toList()
        : null;

    for (Execution l in list) {
      print("ID ${l.id} - Data " +
          DateFormat("y-M-d").format(l.executionTime) +
          " | Difficoltà " +
          l.difficulty.toString() +
          " | Esercizio " +
          l.exercise +
          " | Risultato " +
          l.result.toString());
    }

    return list;
  }

  /// https://stackoverflow.com/questions/51696478/datetime-flutter
  /// DateTime now = DateTime.now();
  /// String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
  ///
  /// https://api.flutter.dev/flutter/dart-core/DateTime-class.html
  Future<List<Execution>> queryExecutionsByDate(DateTime date) async {
    var dbClient = await db;
    var result = await dbClient.query(
      'execution',
      where: 'strftime(\'%Y-%m-%d\', execution_time) = ?',
      whereArgs: [DateFormat("Y-m-d").format(date)],
      orderBy: 'execution_time ASC',
    );

    List<Execution> list = result.isNotEmpty
        ? result.map((c) => Execution.fromMap(c)).toList()
        : null;

    for (Execution l in list) {
      print(
          "queryDate: ID ${l.id} - Execution time = ${l.executionTime} - Exercise ${l.exercise} - Result ${l.result} - Difficulty ${l.difficulty}");
    }

    return list;
  }

  Future<bool> deleteExecution(int id) async {
    var dbClient = await db;

    var deleted = await dbClient.delete(
      'execution',
      where: "id = ?",
      whereArgs: [id],
    );
    return (deleted > 0);
  }
}
