import 'dart:async';
import 'dart:io';

import 'package:spending_tracker/models/transaction.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableTransaction = "transactionTable";
  final String columnId = "id";
  final String columnSummary = "summary";
  final String columnDate = "date";
  final String columnAmount = "amount";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(
        documentDirectory.path, "maindb.db"); //home://directory/files/maindb.db

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  /*
     id | summary | date | amount
  */

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableTransaction($columnId INTEGER PRIMARY KEY, $columnSummary TEXT, $columnDate TEXT, $columnAmount REAL)");
  }

  Future<int> saveTransaction(Transaction transaction) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableTransaction", transaction.toMap());
    return res;
  }

  Future<List> getAllTransactions() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableTransaction");

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
      await dbClient.rawQuery("SELECT COUNT(*) FROM $tableTransaction"));
  }

  Future<double> getSum() async {
    List lst = await getAllTransactions();
    double ret = 0;
    for(var item in lst){
      ret += Transaction.fromMap(item).amount;
    }
    return ret;
  }

  Future<Transaction> getTransaction(int id) async {
     var dbClient = await db;

     var result = await dbClient.rawQuery("SELECT * FROM $tableTransaction WHERE $columnId = $id");
     if (result.length == 0) return null;
     return new Transaction.fromMap(result.first);
  }

  Future<int> deleteTransaction(int id) async {
     var dbClient = await db;

    return await dbClient.delete(tableTransaction,
     where: "$columnId = ?", whereArgs: [id]);
  }


  Future<int> updateTransaction(Transaction transaction) async {
    var dbClient = await db;
    return await dbClient.update(tableTransaction,
     transaction.toMap(), where: "$columnId = ?", whereArgs: [transaction.id]);
  }

  Future close() async {
     var dbClient = await db;
     return dbClient.close();
  }

}
