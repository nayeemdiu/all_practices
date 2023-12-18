import 'dart:async';
import 'dart:io';
import 'package:all_practices/follow_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConostructure();
  // database instanse
  static final DatabaseHelper instance = DatabaseHelper._privateConostructure();
  // database create
  static Database? _database;
  // database get

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    //  mobile storage path directory
    Directory documentDirectory = await getApplicationSupportDirectory();

    String path =
        join(documentDirectory.path, 'followup.db'); // database name todos
    // return korbe database create
    return await openDatabase(
      path,
      version: 1,
      // oncreate
      onCreate: _onCreate,
    );
  }

  FutureOr _onCreate(Database db, int version) async {
    // database TABLE name todos
    await db.execute("""
            CREATE TABLE followup(
            id INTEGER PRIMARY KEY,
            company TEXT,
            number Text,
            note Text,
            createDate Text,
            call_status Text,
            status Text,
            follow_type TEXT,
            followup_date TEXT,
            creator TEXT,
           )""");
  }

  // database data inseart
  ///
  Future<int> addFolloup(followUpModel todo) async {
    Database db = await instance.database;
    return await db.insert('followup', todo.toJMap());
  }

  /// database query
  Future<List<followUpModel>> getFollowUp() async {
    // data base get
    Database db = await instance.database;
    var followup = await db.query('followup', orderBy: "id");
    List<followUpModel> _todos = followup.isNotEmpty
        ? followup.map((todo) => followUpModel.fromMap(todo)).toList()
        : [];
    return _todos;
  }

  ///mazed vai

  // storeLeadContacts(List<followUpModel> contacts) async {
  //   try {
  //     Database? db = await instance.database;
  //     await db!.delete(followup);
  //     for (var element in contacts){
  //       await db!.insert(followup,);
  //     }
  //   } catch (e) {}
  // }
  //
  // // Get lead contacts list
  // Future<List<Map<String, dynamic>>> leadContacts() async {
  //   Database? db = await instance.database;
  //   return await db!.query(followup);
  // }
  //

  // Delete
  Future deleteFollowUp(int id) async {
    Database db = await instance.database;
    return await db.delete('followup', where: 'id=?', whereArgs: [id]);
  }

  /// insert follwup
  insertFollowUp(List<followUpModel> insertfollowup) async {
    Database db = await instance.database;
    await db!.delete("followup");

    for (var element in insertfollowup) {
      await db.insert("followup", element.toJMap());
    }
  }

  /// Get followup
  Future<List<Map<String, dynamic>>> getfollowuplist() async {
    Database? db = await instance.database;
    return await db!.query("followup");
  }
}
