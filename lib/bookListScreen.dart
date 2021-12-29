import 'package:case_study/bookViewScreen.dart';
import 'package:case_study/dbHelper.dart';
import 'package:case_study/model/book.dart';
import 'package:case_study/widgets/bookListWidget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class BookListScreen extends StatefulWidget {
  // const BookListScreen({ Key? key }) : super(key: key);

  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  Future<List<Book>> _books;

  @override
  void initState() {
    super.initState();
    _databaseHelper.initDatabase().then((value) => print("Database successfully initialized."));
    _databaseHelper.populateDummyData();
    loadBooks();
  }

  void loadBooks(){
    _books = _databaseHelper.getBooks();
    if(mounted){
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Books",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
      body: FutureBuilder(
        future: _books,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Book book = snapshot.data[index];
                return BookListWidget(
                  book: book,
                  press: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => BookViewScreen(
                        book: book,
                        bookID: book.bookId,
                        databaseHelper: _databaseHelper,
                      ))
                    );
                  },
                );
              },
            );
          }

        },
        
      )
    );
  }
}