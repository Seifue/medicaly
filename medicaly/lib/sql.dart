import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String Dbpath = await getDatabasesPath();
    String path = join(Dbpath, 'medicine.db');
    Database myDb = await openDatabase(path, onCreate: _onCreate, version: 1);
    return myDb;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE "medicine" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,name INTEGER,frequancy INTEGER,time TEXT,timet TEXT,note TEXT,quantity INTEGER,type INTEGER,dose INTEGER,refill INTEGER)');
    await db.execute('CREATE TABLE "notes" (medicine TEXT,note TEXT)');
  }

  read(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  insert(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  delete(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  update(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }
}
