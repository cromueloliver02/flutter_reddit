import 'package:flutter/material.dart';

class RDTLoader extends StatelessWidget {
  const RDTLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 50),
          Text('LOADING'),
        ],
      ),
    );
  }
}
