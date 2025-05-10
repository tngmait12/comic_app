import 'package:flutter/material.dart';
void showSnackBar(BuildContext context, {required String message, int second = 3}){
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: second),)
  );

}