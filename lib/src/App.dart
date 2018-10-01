import 'package:flutter/material.dart';
import 'package:movie_flutter_bloc_pattern/src/ui/movie_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MovieList(),
      ),
    );
  }
}
