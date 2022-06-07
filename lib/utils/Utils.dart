import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static int? getValue(TextEditingController ctrl) {
    return ctrl.text.isEmpty ?
    null :
    int.parse(ctrl.text)
    ;
  }

  static showToast (String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade200,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }
}