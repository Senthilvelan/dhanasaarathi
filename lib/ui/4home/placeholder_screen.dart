import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;

  PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "$title Placeholder",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
