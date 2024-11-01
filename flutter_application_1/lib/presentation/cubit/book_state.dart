part of 'book_cubit.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final Book book;

  const BookLoaded(this.book);

  @override
  List<Object> get props => [book];
}

class BookError extends BookState {
  final String message;

  const BookError(this.message);

  @override
  List<Object> get props => [message];
}