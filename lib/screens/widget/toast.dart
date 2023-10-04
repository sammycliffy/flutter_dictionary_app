import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastResp {
  static toastMsgError({String? resp}) {
    return Fluttertoast.showToast(
        timeInSecForIosWeb: 4,
        msg: resp.toString(),
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14);
  }

  static toastMsgSuccess({String? resp}) {
    return Fluttertoast.showToast(
        timeInSecForIosWeb: 4,
        msg: resp.toString(),
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14);
  }
}
