import 'package:flutter/material.dart';

class FutureProgressDialog extends StatelessWidget {
  final Future future;
  final BoxDecoration decoration;
  final double opacity;
  final Widget progress;
  final Widget message;

  FutureProgressDialog({
    Key key,
    @required this.future,
    this.message,
    this.decoration,
    this.progress,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    future.then((value) => Navigator.of(context).pop(value)).catchError((e) {
      print(e.toString());
      return Navigator.of(context).pop();
    });

    return WillPopScope(
      child: _buildDialog(context),
      onWillPop: () {
        return Future<bool>.value(false);
      },
    );
  }

  _buildDialog(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Opacity(
        opacity: opacity,
        child: Center(
          child: Container(
            height: 100,
            width: (message == null) ? 100 : double.infinity,
            alignment: Alignment.center,
            decoration: decoration ??
                BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
            child: (message == null)
                ? SizedBox.shrink()
                : Expanded(
                    flex: 1,
                    child: message,
                  ),
          ),
        ),
      ),
    );
  }
}
