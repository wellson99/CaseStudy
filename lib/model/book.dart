class Book {
  final int bookId;
  final String bookName;
  final int bookPages;
  final String bookDesc;
  final String bookPicture;

  Book({
    this.bookId, this.bookName, this.bookPages, this.bookDesc, this.bookPicture
  });

  //Convert JSON to book object
  factory Book.fromJson(Map<String, dynamic> json) => Book(
      bookId: json["book_id"],
      bookName: json["book_name"],
      bookPages: json["book_pages"],
      bookDesc: json["book_desc"],
      bookPicture: json["book_picture"],
  );

  //Convert book object to JSON format
  Map<String, dynamic> toJson() => {
      "book_id": bookId,
      "book_name": bookName,
      "book_pages": bookPages,
      "book_desc": bookDesc,
      "book_picture": bookPicture,
  };
}