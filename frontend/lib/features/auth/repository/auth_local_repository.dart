// import 'package:frontend/models/user_model.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class AuthLocalRepository {
//   String tableName = "users";

//   Database ? _database;

//   Future <Database>get database async {
//     if (_database != null){
//       return _database!;

//     }
//     _database = await _initDb();
//     return _database!;
//   }

//   Future <Database> _initDb() async{
//     final dbPath =  await getDatabasesPath();
//     final path =join(dbPath,"auth.db");
//     return openDatabase(path, version: 1,onCreate: (db,version){
//       db.execute("
//       CREATE TABLE $tablename(
//         id text primary key ,
//         email text not null,
//         token text not null,
//         name text not null,
//         createdAt int not null,
//         updatedAt int not null
//       )
//       ")
//     });
//   }

//   Future<void> insertUser(UserModel usermodel) async {
//     final db = await database;
//     await db.insert($tablename, usermodel.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//   Future<UserModel?> getUser() async{
//     final db = await database;
//     final result =  await db.query($tablename,limit: 1);
//     if (result.isNotEmpty){

//       return UserModel.fromJson(result.first)
//     }
//     return null;

//   }
// }

import 'package:frontend/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AuthLocalRepository {
  static const String tableName = 'users'; // ✅ made static & const

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'auth.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // ✅ fixed variable name and added async/await
        await db.execute('''
          CREATE TABLE $tableName (
            id TEXT PRIMARY KEY,
            email TEXT NOT NULL,
            token TEXT NOT NULL,
            name TEXT NOT NULL,
            createdAt INTEGER NOT NULL,
            updatedAt INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertUser(UserModel userModel) async {
    final db = await database;
    await db.insert(
      tableName, // ✅ now using $tableName correctly
      userModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<UserModel?> getUser() async {
    final db = await database;
    final result = await db.query(tableName, limit: 1);
    if (result.isNotEmpty) {
      return UserModel.fromJson(result.first); // ✅ added semicolon
    }
    return null;
  }

  // Optional: close database
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
