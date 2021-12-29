import 'package:case_study/cartListScreen.dart';
import 'package:case_study/dbHelper.dart';
import 'package:case_study/model/book.dart';
import 'package:case_study/model/cart.dart';
import 'package:case_study/widgets/bookViewWidget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookViewScreen extends StatelessWidget {
  final DatabaseHelper databaseHelper;
  final Book book;
  final int bookID;
  const BookViewScreen({ Key key, @required this.book, @required this.bookID, @required this.databaseHelper }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            stretch: true,
            floating: false,
            pinned: true,
            snap: false,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              book.bookName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle
              ],
              background: Image.network(book.bookPicture, fit: BoxFit.cover,),
            ),
          ),
          SliverFillRemaining(
            child: SingleChildScrollView(
              child: Column(
              children: [
                Container(
                  child: BookViewPageWidget(
                    bookDesc: book.bookDesc,
                    bookPage: book.bookPages,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 13, right: 13, bottom: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: Colors.orange,
                      textColor: Colors.white,
                      onPressed: () {
                        Cart c = Cart(bookId: book.bookId, bookName: book.bookName, bookPages: book.bookPages, bookDesc: book.bookDesc, bookPicture: book.bookPicture);
                        databaseHelper.addToCart(c);
                        Fluttertoast.showToast(msg: "Book added to cart.");
                        Navigator.pop(context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => CartListScreen()));
                      },
                      child: Text(
                        "Add To Cart",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
                          ],
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                ),
              ],),
              
            ),
          )
          
        ],
        
        // 
      ),
    );
  }
}