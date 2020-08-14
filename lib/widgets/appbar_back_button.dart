import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.black87,
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black87,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
