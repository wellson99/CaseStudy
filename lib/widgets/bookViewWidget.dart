import 'package:flutter/material.dart';

class BookViewPageWidget extends StatelessWidget {
  final int bookPage;
  final String bookDesc;
  const BookViewPageWidget({ Key key, @required this.bookPage, @required this.bookDesc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(15, 15),
              blurRadius: 20,
              spreadRadius: 15,
              color: Color(0xFFE6E6E6),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                // SvgPicture.asset(svgSrcDate, height: 23, width: 23,),
                Icon(Icons.book_rounded),
                Container(
                  padding: EdgeInsets.only(left: 10.0,),
                  child: Text(
                    "Total pages",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 15.0),
              child: Text(
                bookPage.toString() + " pages",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.black.withOpacity(0.65)
                ),
              ),
            ),
            SizedBox(height: 25.0,),
            Row(
              children: <Widget>[
                Icon(Icons.description_rounded),
                Container(
                  padding: EdgeInsets.only(left: 10.0,),
                  child: Text(
                    "Description",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 15.0),
              child: Text(
                bookDesc,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.black.withOpacity(0.65)
                ),
              ),
            ),    
          ],
        ), 
      ),
    );
  }
}

