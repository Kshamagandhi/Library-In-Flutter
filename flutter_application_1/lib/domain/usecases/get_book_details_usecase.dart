import 'package:flutter_application_1/data/repositories/book_repository.dart';
import 'package:flutter_application_1/domain/entities/book.dart';

class GetBookDetailsUseCase {
  final BookRepository repository;

  GetBookDetailsUseCase(this.repository);

  Future<Book> execute(String isbn) async {
    //final bookData = await repository.fetchBookDetails(isbn);
    //return Book.fromJson(bookData['records'].values.first['data']);
    return await repository.fetchBookDetails(isbn);
  }
}