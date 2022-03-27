import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  final Widget? retryButton;
  final Function()? retry;
  final Color? textColor;
  const ErrorScreen(
      {Key? key,
      required this.message,
      this.retryButton,
      this.retry,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 20, color: textColor ?? Colors.black),
            ),
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                retryButton ?? Container(),
                Text('Refresh')
              ],
            )
          ],
        ),
      ),
    );
  }
}
