import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mandir/utils/helper.dart';

class Toasty {
  static void success(String msg, {duration = 2}) {
    // Fluttertoast.showToast(
    //   msg: msg,
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.TOP,
    //   timeInSecForIosWeb: duration,
    //   backgroundColor: Colors.green,
    //   textColor: Colors.white,
    //   fontSize: 16,
    // );

    Get.showSnackbar(
      GetSnackBar(
        message: msg,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        borderRadius: 12,
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(16),
        duration: Duration(seconds: duration),
        icon: Icon(Icons.check_circle, color: Colors.white),
      ),
    );
  }

  static void failed(String msg, {duration = 2}) {
    // Fluttertoast.showToast(
    //   msg: msg,
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.TOP,
    //   timeInSecForIosWeb: duration,
    //   backgroundColor: Colors.red,
    //   textColor: Colors.white,
    //   fontSize: 16,
    // );
    Get.showSnackbar(
      GetSnackBar(
        message: msg,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        borderRadius: 12,
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(16),
        duration: Duration(seconds: duration),
        icon: Icon(Icons.error, color: Colors.white),
        isDismissible: true,
      ),
    );
  }

  static void info(String msg, {duration = 2}) {
    // Fluttertoast.showToast(
    //   msg: msg,
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.TOP,
    //   timeInSecForIosWeb: duration,
    //   backgroundColor: const Color(0xFFD8C40D),
    //   textColor: Colors.white,
    //   fontSize: 16,
    // );

    Get.showSnackbar(
      GetSnackBar(
        message: msg,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFD8C40D),
        borderRadius: 12,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        duration: Duration(seconds: duration),
        icon: const Icon(Icons.info, color: Colors.white),
      ),
    );
  }

  static void normal(String msg, {duration = 2}) {
    //   Fluttertoast.showToast(
    //     msg: msg,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.TOP,
    //     timeInSecForIosWeb: duration,
    //     fontSize: 16,
    //   );
    // }

    Get.showSnackbar(
      GetSnackBar(
        message: msg,
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        duration: Duration(seconds: duration),
      ),
    );
  }
}
