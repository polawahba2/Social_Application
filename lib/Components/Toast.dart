import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ChooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
enum ToastStates { SUCESS, ERROR, WARRNING }

Color ChooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.SUCESS:
      color = Colors.green;
      break;
    case ToastStates.WARRNING:
      color = Colors.amber;
      break;
  }
  return color;
}
