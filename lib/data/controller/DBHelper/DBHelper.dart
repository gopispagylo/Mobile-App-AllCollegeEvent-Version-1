import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {

  static Database? _db;


  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  // -------- Open data base --------
  Future<Database> initDB() async{

  // -------- set path ----------
  String path = join(await getDatabasesPath(), 'ace.db');

  return await openDatabase(
    path,
    version: 3,
    onCreate: onCreate
  );
}

  // ---------------- Create Tables (Fresh Install) ----------------
  Future<void> onCreate(Database db, int version) async {

    // -------- Login Screen isLogin --------
    await db.execute('''
      CREATE TABLE IsLogin (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        isActive INTEGER
      )
    ''');

    // -------- Splash Screen isSplash ------------
    await db.execute('''
      CREATE TABLE IsSplash (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        isActive INTEGER
      )
    ''');

    // -------- Set a which user login -----------
    await db.execute('''
      CREATE TABLE UserSave (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
    ''');
  }

  // --------- IsLogin bool Insert Data ----------
  Future<int> insertIsLogin(String name, bool isActive) async{
    final dbClient = await db;
    return await dbClient.insert('IsLogin', {
      'name' : name,
      'isActive' : isActive ? 1 : 0
    });
  }

  // -------- IsLogin bool Get Data ---------
  Future<List<Map<String,dynamic>>> getIsLogin() async{
    final dbClient = await db;
    return await dbClient.query('IsLogin');
  }

  // ----------- IsLogin bool delete the table --------
  Future<int> deleteAllLoginData() async {
    final dbClient = await db;
    return await dbClient.delete('IsLogin');
  }

  // -----------------------------------------------------------------

  // ------- Inserting data -----------
  Future<int> insertingIsSplash(String name, bool isSplash) async{
    final dbClient = await db;
    return await dbClient.insert('IsSplash', {
      'name' : name,
      'isActive' : isSplash ? 1 : 0
    });
  }

  // ---------- Get data --------
  Future<List<Map<String,dynamic>>> getIsSplash() async{
    final dbClient = await db;
    return await dbClient.query('IsSplash');
  }


  // ------------------------------------------------------------------

  // -------- save user ----------
  Future<int> insertUser(String user) async{
      final dbClient = await db;
      return await dbClient.insert('UserSave', {
        'name' : user,
      });
  }

  // ----------- get user -----------
  Future<String?> getUser() async{
    final dbClient = await db;
    final result = await dbClient.query('UserSave');
    if(result.isNotEmpty){
      return result.first['name'] as String;
    }
    return null;
  }

  // -------- delete user ----------
  Future<int> deleteUser() async{
    final dbClient = await db;
    return await dbClient.delete('UserSave');
  }


}