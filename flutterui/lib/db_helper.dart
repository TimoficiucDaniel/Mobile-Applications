import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper{
  static Future<void> createTables(sql.Database database) async{
    await database.execute("""CREATE TABLE listing(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        cost INTEGER,
        description TEXT,
        seller TEXT
        )""");
  }

  static Future<sql.Database> db()async{
    return sql.openDatabase(
      'listables.db',
      version: 1,
      onCreate: (sql.Database database, int version) async{
        await createTables(database);
      }
    );
  }

  static Future<int> createListing(String title, int cost, String? description, String seller) async{
    final db = await SQLHelper.db();

    final data = {'title':title, 'cost':cost,'description':description,'seller':seller};
    final id = await db.insert('listing', data,
    conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  
  static Future<List<Map<String,dynamic>>> getListings() async{
    final db = await SQLHelper.db();
    return db.query('listing',orderBy: 'id');
  }

  static Future<List<Map<String,dynamic>>> getListing(int id) async{
    final db = await SQLHelper.db();
    return db.query('listing',where:"id = ?",whereArgs: [id], limit:1);
  }

  static Future<int> updateListing(int id, String title, int cost, String? description, String seller) async{
    final db = await SQLHelper.db();
    final data = {'title':title, 'cost':cost,'description':description,'seller':seller};

    final result = await db.update('listing', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteListing(int id) async{
    final db = await SQLHelper.db();
    try{
      await db.delete('listing', where: "id = ?", whereArgs: [id]);
    }catch(e){
      debugPrint("Deleting item has gone wrong: $e");
    }
  }
}