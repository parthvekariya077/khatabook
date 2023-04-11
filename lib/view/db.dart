// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// ignore: camel_case_types
class dbClient {
  Database? db;

  Future<Database> checkDatabase() async {
    if (db != null) {
      return db!;
    } else {
      return await creatDatabase();
    }
  }

  Future<Database> creatDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String path = join(folder.path, "khatabook.db");
    return openDatabase(path, version: 1, onCreate: (db, version) {
      String query =
          "CREATE TABLE Client(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,number TEXT,address TEXT)";
      String query1 =
          "CREATE TABLE Product(pid INTEGER PRIMARY KEY AUTOINCREMENT,productname TEXT,price INTEGER,currentDate TEXT,paymentStatus INTEGER,time TEXT,clientID INTEGER)";
      db.execute(query);

      db.execute(query1);
    });
  }

  void insertData(String n1, String m1, String a1) async {
    db = await checkDatabase();
    db!.insert("Client", {"name": n1, "number": m1, "address": a1});
  }

  Future<List<Map>> readData() async {
    db = await checkDatabase();
    String query = "SELECT * FROM Client";
    List<Map> Product = await db!.rawQuery(query, null);
    return Product;
  }

  void deleteData(String id) async {
    db = await checkDatabase();
    db!.delete("Client", where: "id = ?", whereArgs: [int.parse(id)]);
  }

  void update(String name, String number, String add, String id) async {
    db = await checkDatabase();
    db!.update("Client", {"name": name, "number": number, "address": add},
        where: "id = ? ", whereArgs: [int.parse(id)]);
  }

  //=============================================================//

  Future<Database> productchekDatabase() async {
    if (db != null) {
      return db!;
    } else {
      return await creatDatabase();
    }
  }

  void productinsertData(String name, String price, String date, String time,
      int clientid, int status) async {
    db = await productchekDatabase();
    db!.insert("Product", {
      "productname": name,
      "price": price,
      "currentDate": date,
      "time": time,
      "clientID": clientid,
      "paymentStatus": status
    });
  }

  void productDelete(String id) async {
    db = await checkDatabase();
    db!.delete("Product", where: "clientID = ?", whereArgs: [int.parse(id)]);
  }

  Future<List<Map>> productreadData({String? id}) async {
    db = await productchekDatabase();
    String query = "";
    if (id != null) {
      query = "SELECT * FROM Product where clientID = $id";
    } else {
      query = "SELECT * FROM Product";
    }
    List<Map> Product = await db!.rawQuery(query, null);
    return Product;
  }

//===================================================================//

  Future<List<Map>> filterRead(String date) async {
    db = await checkDatabase();
    String query = "SELECT * FROM Product where current currentDate = ?";
    List<Map> productList = await db!.rawQuery(query, [date]);

    return productList;
  }

  void productupdateData(
      String id, String n1, String a1, String d1, String t1) async {
    db = await checkDatabase();
    db!.update(
        "Product", {"name": n1, "amount": a1, "currentDate": d1, "time": t1},
        where: "id = ?", whereArgs: [int.parse(id)]);
  }
}
