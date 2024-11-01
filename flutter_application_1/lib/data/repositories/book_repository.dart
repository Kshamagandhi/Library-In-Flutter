import 'package:flutter_application_1/domain/entities/book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/entities/book.dart';


class BookRepository {
  Future<Book> fetchBookDetails(String isbn) async {
    final response = await http.get(Uri.parse('http://192.168.29.112:3000/api/volumes/brief/isbn/$isbn'));
print('Response status: ${response.statusCode}');
print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load book details');
    }
  }
}