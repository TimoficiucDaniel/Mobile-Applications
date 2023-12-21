import 'package:flutter/cupertino.dart';
import 'package:flutterui/model/listing.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper{
  static const _dbName = 'listables.db';
  static const _dbVer = 1;


  SQLHelper._privateConstructor();
  static final SQLHelper instance = SQLHelper._privateConstructor();

  late Database database;

   Future<void> db() async{
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _dbName);
    database = await openDatabase(
      path,
      version: _dbVer,
      onCreate: createTables,
    );
  }

  Future<void> createTables(Database database, int version) async{
    await database.execute("""CREATE TABLE listing(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        cost INTEGER,
        description TEXT,
        seller TEXT
        )""");
  }

   Future<int> createListing(Listing listing) async{
    return await database.insert('listing', listing.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace);
  }
  
   Future<List<Listing>> getListings() async{
    final List<Map<String,dynamic>> maps = await database.query('listing',orderBy: 'id');
    return List.generate(maps.length, (index) {
      return Listing(
        id: maps[index]['id']! as int,
        title: maps[index]['title'] as String,
        cost: maps[index]['cost'] as int,
        description: maps[index]['description'] as String,
        seller: maps[index]['seller'] as String,
      );
    });
  }

   Future<List<Listing>> getListing(int id) async{
     final List<Map<String,dynamic>> maps = await database.query('listing',where:"id = ?",whereArgs: [id], limit:1);
     return List.generate(maps.length, (index) {
       return Listing(
         id: maps[index]['id']! as int,
         title: maps[index]['title'] as String,
         cost: maps[index]['cost'] as int,
         description: maps[index]['description'] as String,
         seller: maps[index]['seller'] as String,
       );
     });
  }

   Future<void> updateListing(Listing listing) async{
     await database.update('listing', listing.toMap(), where: "id = ?", whereArgs: [listing.id]);
  }

   Future<void> deleteListing(int id) async{
    try{
      await database.delete('listing', where: "id = ?", whereArgs: [id]);
    }catch(e){
      debugPrint("Deleting item has gone wrong: $e");
    }
  }
}