import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {

  static Database? _db;

  Future<Database?> get db async{
    if(_db == null){
      _db = await initialDb();
      return _db;
    }else{
      return _db;
    }
  }


  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath,'test.db');
    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    return mydb;
}


  _onUpgrade(Database db, int oldversion ,int newversion) async {
    await db.execute("AlTER TABLE notes ADD COLUMN color TEXT");
    print("Upgraded");
  }

  _onCreate(Database db,int version) async{
    await db.execute('''
    CREATE TABLE "notes"(
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL
    )
    ''');
    print("Created Successfully");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deletedata(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  mydeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath,'test.db');
    await deleteDatabase(path);
  }


}