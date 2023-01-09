import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required String? text,
   ToastStatus? state,
})=> Fluttertoast.showToast(
    msg:text! ,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state!),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStatus{SUCCESS,ERROR,WARNING}

Color? chooseToastColor(ToastStatus state)
{
  Color color;
  switch(state)
  {

    case ToastStatus.SUCCESS: color = Colors.green;
    break;
    case ToastStatus.ERROR:color = Colors.red;
    break;
    case ToastStatus.WARNING:color = Colors.amber;
    break;
  }
  return color;
}