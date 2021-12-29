import 'package:case_study/model/book.dart';
import 'package:case_study/model/cart.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:convert';

final String bookTable = "books";
final String bookID = "bookID";
final String bookName = "bookName";
final String bookPage = "bookPage";
final String bookDesc = "bookDesc";
final String bookImgURL = "bookImgURL";

final String cartTable = "carts";
final String cartId = "cartID";

class DatabaseHelper{
  static Database _database;
  static DatabaseHelper _databaseHelper;

  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async{
    if (_database == null) {
      _database = await initDatabase();
    }
    return _database;
  }

  Future<Database> initDatabase() async{
    var dir = await getDatabasesPath();
    var path = dir + "caseStudy.db";

    var database = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
          create table if not exists $bookTable($bookID integer primary key, $bookName text, $bookPage integer, $bookDesc text, $bookImgURL text);
        ''');
      db.execute('''
          create table if not exists $cartTable($cartId integer primary key autoincrement not null, $bookID integer, $bookName text, $bookPage integer, $bookDesc text, $bookImgURL text);
        ''');
    },);
    return database;
  }

  Future<void> populateDummyData() async{
    var db = await this.database;
    Batch batch = db.batch();
    int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $bookTable'));
    print(count.toString());

    if(count == 0){
      batch.insert(bookTable, {'$bookID':1, '$bookName':'Harry Potter', '$bookPage':285, '$bookDesc':'This is a Harry Potter Book. This is a Harry Potter Book. This is a Harry Potter Book. This is a Harry Potter Book. This is a Harry Potter Book. This is a Harry Potter Book. This is a Harry Potter Book.', '$bookImgURL':'https://m.media-amazon.com/images/M/MV5BNjQ3NWNlNmQtMTE5ZS00MDdmLTlkZjUtZTBlM2UxMGFiMTU3XkEyXkFqcGdeQXVyNjUwNzk3NDc@._V1_FMjpg_UX1000_.jpg'});
      batch.insert(bookTable, {'$bookID':2, '$bookName':'Hobbit', '$bookPage':375, '$bookDesc':'This is a Hobbit Book. This is a Hobbit Book. This is a Hobbit Book. This is a Hobbit Book. This is a Hobbit Book. This is a Hobbit Book. This is a Hobbit Book.', '$bookImgURL':'https://m.media-amazon.com/images/M/MV5BMTcwNTE4MTUxMl5BMl5BanBnXkFtZTcwMDIyODM4OA@@._V1_FMjpg_UX1000_.jpg'});
      batch.insert(bookTable, {'$bookID':3, '$bookName':'Spiderman Comic', '$bookPage':26, '$bookDesc':'This is a Spiderman Comic Book. This is a Spiderman Comic Book. This is a Spiderman Comic Book. This is a Spiderman Comic Book. This is a Spiderman Comic Book. This is a Spiderman Comic Book. This is a Spiderman Comic Book.', '$bookImgURL':'https://static.wikia.nocookie.net/marvelcinematicuniverse/images/b/b0/Spider-Man_FFH_Profile.jpg/revision/latest?cb=20190917181733'});
      batch.insert(bookTable, {'$bookID':4, '$bookName':'Peter Pan', '$bookPage':35, '$bookDesc':'This is a Peter Pan Book. This is a Peter Pan Book. This is a Peter Pan Book. This is a Peter Pan Book. This is a Peter Pan Book. This is a Peter Pan Book. This is a Peter Pan Book.', '$bookImgURL':'https://lumiere-a.akamaihd.net/v1/images/p_peterpan_19755_96e77c5b.jpeg?region=0%2C0%2C540%2C810'});
      batch.insert(bookTable, {'$bookID':5, '$bookName':'Mickey Mouse', '$bookPage':20, '$bookDesc':'This is a Mickey Mouse Book. This is a Mickey Mouse Book. This is a Mickey Mouse Book. This is a Mickey Mouse Book. This is a Mickey Mouse Book. This is a Mickey Mouse Book. This is a Mickey Mouse Book.', '$bookImgURL':'https://m.media-amazon.com/images/M/MV5BMTdiNDIyMGEtNWJjMi00ODlhLWJhM2EtYjJjMjFlMjNhNDEwXkEyXkFqcGdeQXVyODg3NDc1OTE@._V1_.jpg'});
      batch.insert(bookTable, {'$bookID':6, '$bookName':'Book Title example 1', '$bookPage':99, '$bookDesc':'This is a Book Title example Book. This is a Book Title example Book. This is a Book Title example Book. This is a Book Title example Book. This is a Book Title example Book. This is a Book Title example Book. This is a Book Title example Book.', '$bookImgURL':'https://static.wikia.nocookie.net/marvelcinematicuniverse/images/b/b0/Spider-Man_FFH_Profile.jpg/revision/latest?cb=20190917181733'});
      batch.insert(bookTable, {'$bookID':7, '$bookName':'Book Title example 2', '$bookPage':999, '$bookDesc':'This is a Book Title example Book. This is a Book Title example Book. This is a Book Title example Book. This is a Book Title example Book. This is a Book Title example Book. This is a Book Title example Book. This is a Book Title example Book.', '$bookImgURL':'https://static.wikia.nocookie.net/marvelcinematicuniverse/images/b/b0/Spider-Man_FFH_Profile.jpg/revision/latest?cb=20190917181733'});
      batch.insert(bookTable, {'$bookID':8, '$bookName':'Book Title example 3', '$bookPage':9999, '$bookDesc':'This is a Book Title example Book. This is a Book Title example Book. This is a Book Title example Book. This is a Book Title example Book. This is a Book Title example Book. This is a Book Title example Book. This is a Book Title example Book.', '$bookImgURL':'https://static.wikia.nocookie.net/marvelcinematicuniverse/images/b/b0/Spider-Man_FFH_Profile.jpg/revision/latest?cb=20190917181733'});
      
      batch.commit();
      print("Data successfully added");
    }else{
      print("Data already exists in database.");
    }

    int n = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $cartTable'));
    String te = "after commit"+ n.toString();
    print(te);
  }

  Future<List<Book>> getBooks() async{
    var db = await this.database;
    final List<Map<String, dynamic>> maps = await db.query(bookTable);

    return List.generate(maps.length, (i) {
      return Book(
        bookId: maps[i]['bookID'], bookName: maps[i]['bookName'], bookPages: maps[i]['bookPage'],
          bookDesc: maps[i]['bookDesc'], bookPicture: maps[i]['bookImgURL']);
    });
  }

  void addToCart(Cart cart) async{
    var db = await this.database;
    // int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $cartTable'));

    // if(count != 0){
      
    // }
    // CartGet c = CartGet(cartId: count, bookId: cart.bookId, bookName: cart.bookName, bookPages: cart.bookPages, bookDesc: cart.bookDesc, bookPicture: cart.bookPicture);
    var result = await db.insert(cartTable, cart.toJson());
    print('result : $result');
  }

  Future<List<CartGet>> getCarts() async{
    var db = await this.database;
    final List<Map<String, dynamic>> maps = await db.query(cartTable);

    return List.generate(maps.length, (i) {
      return CartGet(
        cartId: maps[i]['cartID'], bookId: maps[i]['bookID'], bookName: maps[i]['bookName'], 
          bookPages: maps[i]['bookPage'], bookDesc: maps[i]['bookDesc'], bookPicture: maps[i]['bookImgURL']);
    });
  }

  Future<int> deleteCart(int id) async{
    var db = await this.database;
    return await db.delete(cartTable, where: '$cartId = ?', whereArgs: [id]);
  }

}