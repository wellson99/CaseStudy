class Cart {
  final int bookId;
  final String bookName;
  final int bookPages;
  final String bookDesc;
  final String bookPicture;

  Cart({
    this.bookId, this.bookName, this.bookPages, this.bookDesc, this.bookPicture
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    bookId: json["bookID"],
    bookName: json["bookName"],
    bookPages: json["bookPage"],
    bookDesc: json["bookDesc"],
    bookPicture: json["bookImgURL"],
  );

  //Convert book object to JSON format
  Map<String, dynamic> toJson() => {
    "bookID": bookId,
    "bookName": bookName,
    "bookPage": bookPages,
    "bookDesc": bookDesc,
    "bookImgURL": bookPicture,
  };

}

class CartGet {
  final int cartId;
  final int bookId;
  final String bookName;
  final int bookPages;
  final String bookDesc;
  final String bookPicture;

  CartGet({
    this.cartId, this.bookId, this.bookName, this.bookPages, this.bookDesc, this.bookPicture
  });

  factory CartGet.fromJson(Map<String, dynamic> json) => CartGet(
    cartId: json["cartID"],
    bookId: json["bookID"],
    bookName: json["bookName"],
    bookPages: json["bookPage"],
    bookDesc: json["bookDesc"],
    bookPicture: json["bookImgURL"],
  );

  //Convert book object to JSON format
  Map<String, dynamic> toJson() => {
    "cartID": cartId,
    "bookID": bookId,
    "bookName": bookName,
    "bookPage": bookPages,
    "bookDesc": bookDesc,
    "bookImgURL": bookPicture,
  };

}