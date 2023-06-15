import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

class Utils {
  void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocusNode) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  showTostMessage(
      {required BuildContext context,
      required String message,
      bool? isError = false}) {
    FlutterToastr.show(message, context,
        duration: FlutterToastr.lengthShort,
        position: FlutterToastr.bottom,
        backgroundColor: isError == true ? Colors.red : Colors.black);
  }

  // showProgressIndicator(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => const CircularProgressIndicator(),
  //   );
  // }
}
