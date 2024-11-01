import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/domain/entities/book.dart';
import 'package:flutter_application_1/domain/usecases/get_book_details_usecase.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  final GetBookDetailsUseCase getBookDetailsUseCase;

  BookCubit(this.getBookDetailsUseCase) : super(BookInitial());

  Future<void> fetchBookDetails(String isbn) async {
    try {
      emit(BookLoading());
      print('Fetching book details...');
      final book = await getBookDetailsUseCase.execute(isbn);
      emit(BookLoaded(book));
    } catch (_) {
      print('Error fetching book details: $_');
      emit(BookError('Failed to fetch book details'));
    }
  }
}