import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter_finance_app/purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Persistent data
// Stores all purchase information
class Database {
  // Database constants
  static const _dbName = 'purchases.db';
  static const _dbVersion = 1;

  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        price REAL,
        category TEXT,
        createdAt INTEGER,
        year INTEGER,
        month INTEGER,
        day INTEGER,
        weekday TEXT
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
  static Future<void> addPurchase(Purchase p) async {
    final db = await Database.db();

    await db.insert('items', p.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    incrementItemCount();
  }
  
static Future<List<Map<String, dynamic>>> getPurchases2() async {
    // Reference database
    final db = await Database.db();

    // Query table for all purchases
    final List<Map<String, dynamic>> maps =
        await db.query('items', orderBy: "createdAt");

    return maps;
    // Convert List<Map<String, dynamic> -> List<Purchase>
  //   List<Purchase> dataObjects = maps.map((purchase) {
  //   return Purchase(
  //     id: purchase['id'].toInt(),
  //     name: purchase['name'].toString(),
  //     price: purchase['price'].toDouble(),
  //     category: purchase['category'].toString(),
  //     createdAt: purchase['createdAt'].toInt()
  //   );
  // }).toList();
  // return dataObjects;
    // Convert List<Map<String, dynamic> -> List<Purchase>
    // return List.generate(maps.length, (i) {
    //   return Purchase(
    //     id: maps[i]['id'],
    //     name: maps[i]['name'],
    //     price: maps[i]['price'],
    //     category: maps[i]['category'],
    //     createdAt: maps[i]['createdAt'],
    //   );
    // });
  }

  // Return all purchases in database
  // Orders returned List<Purchase> by creation time
  // If no purchases returns empty list
  static Future<List<Purchase>> getPurchases() async {
    // Reference database
    final db = await Database.db();

    // Query table for all purchases
    final List<Map<String, dynamic>> maps =
        await db.query('items', orderBy: "createdAt");

    if (maps.isEmpty) return <Purchase>[];

    // Convert List<Map<String, dynamic> -> List<Purchase>
    return List.generate(maps.length, (i) {
      return Purchase(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'].toDouble(),
        category: maps[i]['category'],
        createdAt: maps[i]['createdAt'],
        year: maps[i]['year'],
        month: maps[i]['month'],
        day: maps[i]['day'],
        weekday: maps[i]['weekday'],
      );
    });
  }

  // Get single purchase by ID
  // Converts List<Map<String, dynamic> -> List<Purchase> -> Purchase
  static Future<Purchase> getPurchaseByID(int id) async {
    // Reference database
    final db = await Database.db();

    // Query table for matching purchase
    final List<Map<String, dynamic>> maps =
        await db.query('items', where: "id = ?", whereArgs: [id], limit: 1);

    // if (maps.isEmpty) return null;

    // Convert List<Map<String, dynamic> -> List<Purchase>
    List<Purchase> pList = List.generate(maps.length, (i) {
      return Purchase(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        category: maps[i]['category'],
        createdAt: maps[i]['createdAt'],
        year: maps[i]['year'],
        month: maps[i]['month'],
        day: maps[i]['day'],
        weekday: maps[i]['weekday'],
      );
    });

    // Return Purchase from List<Purchase>
    return pList.elementAt(0);
  }

  // Get all purchases in specified category and time
  // Orders returned List<Purchase> by creation time
  static Future<List<Purchase>> getPurchaseRange(
      String category, String time) async {
    // Reference database
    final db = await Database.db();

    final List<Map<String, dynamic>> maps;

    // Limit search to specified category
    if (category == "All") {
      // Query table for matching purchases
      maps = await db.query('items', orderBy: "createdAt");
    } else {
      // Query table for matching purchases
      maps = await db.query('items',
          where: "category = ?", whereArgs: [category], orderBy: "createdAt");
    }

    // Convert List<Map<String, dynamic> -> List<Purchase>
    List<Purchase> tempList = List.generate(maps.length, (i) {
      return Purchase(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        category: maps[i]['category'],
        createdAt: maps[i]['createdAt'],
        year: maps[i]['year'],
        month: maps[i]['month'],
        day: maps[i]['day'],
        weekday: maps[i]['weekday'],
      );
    });

    // Limit search to specified time range
    dynamic filteredList;
    DateTime now = new DateTime.now();
    DateTime currentDate = new DateTime(now.year, now.month, now.day);
    if (time == "year") {
      filteredList = tempList.where((item) {
        DateTime itemDate = DateTime.fromMillisecondsSinceEpoch(item.createdAt);
        return itemDate.year == currentDate.year;
      });
    } else if (time == "month") {
      filteredList = tempList.where((item) {
        DateTime itemDate = DateTime.fromMillisecondsSinceEpoch(item.createdAt);
        return itemDate.month == currentDate.month;
      });
    } else {
      filteredList = tempList.where((item) {
        DateTime itemDate = DateTime.fromMillisecondsSinceEpoch(item.createdAt);
        return itemDate.day == currentDate.day;
      });
    }

    return filteredList.toList();
  }

  // Update purchase
  static Future<void> updatePurchase(Purchase p) async {
    // Reference database
    final db = await Database.db();

    await db.update(
      'items',
      p.toMap(),
      // Find matching ID
      where: 'id = ?',
      whereArgs: [p.id],
    );
  }

  // Delete purchase from database
  static Future<void> deletePurchase(int id) async {
    final db = await Database.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("ERROR: Unable to delete purchase. $err");
    }

    decrementItemCount();
  }

  // Delete purchase from database
  static Future<void> deleteAllPurchases() async {
    final db = await Database.db();
    try {
      await db.delete("items");
    } catch (err) {
      debugPrint("ERROR: Unable to delete purchase. $err");
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('itemCount', 0);
  }

  static void incrementItemCount() async {
    final prefs = await SharedPreferences.getInstance();
    int itemCount = prefs.getInt('itemCount') ?? 0;
    itemCount++;
    prefs.setInt('itemCount', itemCount);
  }

  static void decrementItemCount() async {
    final prefs = await SharedPreferences.getInstance();
    int itemCount = prefs.getInt('itemCount') ?? 0;
    itemCount--;
    prefs.setInt('itemCount', itemCount);
  }
}
