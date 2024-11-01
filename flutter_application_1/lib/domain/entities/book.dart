class Book {
  final String title;
  final List<String> authors;
  final String publishDate;
  final String coverImageUrl;

  Book({
    required this.title,
    required this.authors,
    required this.publishDate,
    required this.coverImageUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    //var data = json['data'];
    return Book(
      title: json['title'],
      authors: json['author'] != null ? [json['author']] : [],
      publishDate: json['year'].toString(),
      coverImageUrl: '',
    );
  }
}