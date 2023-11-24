import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import '../utils/constants.dart';

class LocalDataBase {
  // this method for open dataBase if not exist yet
  Future<Database> _initDatabase(
      {required String dbName,
      required String tabelName,
      required bool isOrder}) async {
    String path = p.join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await _creatDb(db, tabelName, isOrder);
    });
  }

  // this method for created table of dataBase
  Future _creatDb(Database db, String tabelName, bool isOrder) async {
    if (isOrder) {
            await db.execute('''
create table $tabelName (
  $id integer primary key autoincrement,
  $kNewOrder text not null
  )
''');
    } else {
      await db.execute('''
create table $tabelName (
  $id integer primary key autoincrement,
  $name text not null,
  $type text not null,
  $price integer not null,
  $img text not null
  )
''');
    }
  }

  // this method for insert new data to dataBase
  Future<int> setDataToDataBase(
      {required String dbName,
      required String tabelName,
      required Map<String, dynamic> map,
      bool? isOrder}) async {
    final db = await _initDatabase(
        dbName: dbName, tabelName: tabelName, isOrder: isOrder ?? false);
    return await db.insert(tabelName, map,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future readData(
      {required String dbName,
      required String tabelName,
      bool? isOrder}) async {
    // final val = Provider.of<EmployeeStateMangment>(context, listen: false);
    final db = await _initDatabase(
        dbName: dbName, tabelName: tabelName, isOrder: isOrder ?? false);
    List<Map<String, dynamic>> data = await db.query(tabelName);
    return data;
  }

  // this method for delete one item from database
  Future<int> deleteOneItem(
      {required String dbName,
      required String tabelName,
      required int idItem,
      bool? isOrder}) async {
    final db = await _initDatabase(
        dbName: dbName, tabelName: tabelName, isOrder: isOrder ?? false);
    return await db.delete(tabelName, where: '$id = ?', whereArgs: [idItem]);
  }

  // this method for delete data base from device
  Future deleteAll({required String dbName}) async {
    final dbPath = await getDatabasesPath();
    String path = p.join(dbPath, dbName);
    await deleteDatabase(path);
  }
}
