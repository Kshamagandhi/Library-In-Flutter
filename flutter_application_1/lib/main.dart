import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/data/repositories/book_repository.dart';
import 'package:flutter_application_1/domain/usecases/get_book_details_usecase.dart';
import 'package:flutter_application_1/presentation/cubit/book_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'dart:io';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Details',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => BookCubit(GetBookDetailsUseCase(BookRepository())),
        child: BookPage(),
      ),
    );
  }
}

class BookPage extends StatelessWidget {
  //const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final TextEditingController _controller = TextEditingController();

  @override
  //State<MyHomePage> createState() => _MyHomePageState();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter ISBN',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final isbn = _controller.text;
                context.read<BookCubit>().fetchBookDetails(isbn);
              },
              child: Text('Get Book Details'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<BookCubit, BookState>(
                builder: (context, state) {
                  if (state is BookLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is BookLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Title: ${state.book.title}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('Authors: ${state.book.authors.join(', ')}', style: TextStyle(fontSize: 16)),
                        Text('Published: ${state.book.publishDate}', style: TextStyle(fontSize: 16)),
                        state.book.coverImageUrl.isNotEmpty
                          ? Image.network(state.book.coverImageUrl)
                          : Container(),
                      ],
                    );
                  } else if (state is BookError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Center(child: Text('Enter an ISBN to get book details'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  