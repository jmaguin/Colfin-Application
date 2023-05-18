import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter_finance_app/purchase.dart';

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
        createdAt INTEGER,
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
  static Future<void> addPurchase(Purchase p) async {
    final db = await Database.db();

    await db.insert('items', p.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  // Return all purchases in database
  Future<List<Purchase>> getPurchases() async {
    // Get a reference to the database.
    final db = await Database.db();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('items');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Purchase(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        category: maps[i]['category'],
        createdAt: maps[i]['createdAt'],
      );
    });
  }

  // Get single purchase by ID
  static Future<List<Map<String, dynamic>>> getPurchaseByID(int id) async {
    final db = await Database.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Get all purchases in specified category
  static Future<List<Map<String, dynamic>>> getPurchaseByCategory(
      String category) async {
    final db = await Database.db();
    return db.query('items',
        where: "category = ?", whereArgs: [category], orderBy: "id");
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

  // Delete all purchases from database
  static Future<void> deleteAllPurchases() async {
    final db = await Database.db();
    try {
      await db.delete("items");
    } catch (err) {
      debugPrint("ERROR: Unable to delete purchases. $err");
    }
  }
}
