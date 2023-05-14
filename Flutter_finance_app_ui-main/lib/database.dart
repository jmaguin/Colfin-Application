import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

// Persistent data
// Stores all purchase information
class Database {
  // Contants to store database name & version
  static const _dbName = 'purchases.db';
  static const _dbVersion = 1;

  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        price INTEGER,
        category TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  // Open database
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      _dbName,
      version: _dbVersion,
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      },
    );
  }

  // Add purchase to database
  // Return ID of purchase
  static Future<int> addPurchase(
      String name, double price, String category) async {
    final db = await Database.db();

    final data = {'name': name, 'price': price, 'category': category};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Return all purchases in database
  static Future<List<Map<String, dynamic>>> getPurchase() async {
    final db = await Database.db();
    return db.query('items', orderBy: "id");
  }

  // Get single purchase by ID
  static Future<List<Map<String, dynamic>>> getPurchaseByID(int id) async {
    final db = await Database.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update purchase by ID
  static Future<int> updateItem(
      int id, String name, double price, String category) async {
    final db = await Database.db();

    final data = {
      'name': name,
      'price': price,
      'category': category,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete purchase from database
  static Future<void> deletePurchase(int id) async {
    final db = await Database.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("ERROR: Unable to delete purchase. $err");
    }
  }
}
