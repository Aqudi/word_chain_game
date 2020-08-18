import 'package:flutter/material.dart';

class BaseAuthButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final String buttonTitle;

  BaseAuthButton({this.onPressed, this.buttonTitle, this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: color ?? Colors.blueGrey,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        onPressed: onPressed,
        child: Text(
          buttonTitle ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
