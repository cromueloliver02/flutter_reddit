import 'package:flutter/material.dart';

class RedditApp extends StatelessWidget {
  const RedditApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddit',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Scaffold(
        body: Center(
          child: Text('REDDIT CLONE APP'),
        ),
      ),
    );
  }
}
