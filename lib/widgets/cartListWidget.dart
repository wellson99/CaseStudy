import 'package:case_study/model/cart.dart';
import 'package:flutter/material.dart';

class CardListWidget extends StatelessWidget {
  final CartGet cart;
  final Function delete, press;
  const CardListWidget({ Key key, @required this.cart, @required this.delete, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(15, 15),
            blurRadius: 20,
            spreadRadius: 15,
            color: Color(0xFFE6E6E6),
          ),
        ],
      ),
      child: InkWell(
        onTap: press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: Center(
                  child: Image.network(cart.bookPicture, height: MediaQuery.of(context).size.height * 1, width: 100,)
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: 10,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 6),
                              width: double.infinity,
                              child: Text(
                                cart.bookName,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  cart.bookDesc,
                                  textAlign: TextAlign.left,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.035,
                                    color: Colors.black.withOpacity(0.65),
                                  )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
            Flexible(
              flex: 1,
              child: Container(
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,), 
                      onPressed: delete,
                    )
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}