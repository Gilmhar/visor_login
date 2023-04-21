import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:toast/toast.dart';

alertDialog(BuildContext context, String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM_LEFT,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.amber[700],
      textColor: Colors.white,
      fontSize: 15);
}

// validateCurp(String curp) {
//   final curpReg = RegExp(r"^([a-zA-Z]{4})+(\d{6})+([a-zA-Z]{6})+(\d{2})$");
//   return curpReg.hasMatch(curp);
// }

validateEmail(String email) {
  final emailReg = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailReg.hasMatch(email);
}
