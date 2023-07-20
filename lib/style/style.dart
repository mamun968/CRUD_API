import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_svg/flutter_svg.dart';

const colorRed = Color.fromARGB(231, 244, 9, 9);
const colorGreen = Color.fromARGB(231, 42, 230, 9);
const colorWhite = Color.fromARGB(231, 250, 255, 255);
const colorDarkBlue = Color.fromARGB(231, 1, 7, 57);

InputDecoration AppInputDeco(label) {
  return InputDecoration(
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorGreen, width: 1)),
    fillColor: colorWhite,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorWhite, width: 0)),
    border: const OutlineInputBorder(),
    labelText: label,
  );
}

// SvgPicture ScreenBack(context) {
//  return SvgPicture.asset(
//     "assets/images/svgBack.svg",
//     alignment: Alignment.center,
//     width: MediaQuery.of(context).size.width,
//     height: MediaQuery.of(context).size.height,
//     fit: BoxFit.cover,
//   );
// }
SuccessToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: colorGreen,
      textColor: Colors.white,
      fontSize: 16.0);
}

FailedToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: colorRed,
      textColor: Colors.white,
      fontSize: 16.0);
}

DecoratedBox AppDropDown(child) {
  return DecoratedBox(
    decoration: BoxDecoration(
        color: colorWhite,
        border: Border.all(width: 1, color: colorWhite),
        borderRadius: const BorderRadius.all(Radius.circular(5))),
    child: Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: child,
    ),
  );
}

ButtonStyle AppBtnS() {
  return ElevatedButton.styleFrom(
    backgroundColor: colorGreen,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  );
}
 // padding: EdgeInsets.symmetric(horizontal: 200, vertical: 20)