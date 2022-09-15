import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class SQLHelper {

  static Future<Database> initDb() async {
    return sql.openDatabase(
      'plant.db', //database name
      version: 1, //version number
      onCreate: (Database database, int version) async {
        await createTable(database);
      },
    );
  }

  static Future<void> createTable(Database database) async {
    await database.execute("""
    CREATE TABLE plants(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT
      )
      """);
    debugPrint("table Created");
  }



  //add
  static Future<int> addPlant(String title, String description) async {
    //open database
    final db = await SQLHelper.initDb();
    //create data in map
    final data = {'title': title, 'description': description};
    //insert
    final id = await db.insert('plants', data);
    debugPrint("Data Added");
    return id;
  }

//read all plants
  static Future<List<Map<String, dynamic>>> getPlants() async {
    final db = await SQLHelper.initDb();
    return db.query('plants', orderBy: "id");
  }




  //get plant by id
  static Future<List<Map<String, dynamic>>> getPlant(int id) async {
    final db = await SQLHelper.initDb();
    return db.query('plants', where: "id = ?", whereArgs: [id]);
  }


  //update
  static Future<int> updatePlant(
      int id, String title, String? description) async {
    final db = await SQLHelper.initDb();
    final data = {
      'title': title,
      'description': description,
    };

    final result =
        await db.update('plants', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deletePlant(int id) async {
    final db = await SQLHelper.initDb();
    try {
      await db.delete("plants", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when : $err");
    }
  }
}
