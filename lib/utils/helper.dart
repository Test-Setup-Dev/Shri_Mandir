import 'dart:async';
import 'dart:math';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:gaamraam/dialogs/alert_dialog.dart';
// import 'package:gaamraam/screen/auth/login/login_screen.dart';
// import 'package:gaamraam/utils/const.dart';
// import 'package:gaamraam/utils/logger.dart';
// import 'package:gaamraam/utils/preference.dart';
// import 'package:gaamraam/values/size_config.dart';
// import 'package:gaamraam/values/strings.dart';
import 'package:get/get.dart';
import 'package:mandir/dialogs/alert_dialog.dart';
import 'package:mandir/model/home_data.dart';
import 'package:mandir/screen/auth/login/login_screen.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/utils/logger.dart';
import 'package:mandir/utils/preference.dart';
import 'package:mandir/values/strings.dart';

import 'const.dart';

// import 'package:intl/intl.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// export '../utils/const.dart';
// export '../utils/logger.dart';
// export '../utils/preference.dart';
// export '../values/dimen.dart';
export '../values/size_config.dart';
export '../values/theme_colors.dart';

typedef RefreshCallback = void Function();

class Helper {
  // static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String DATE_FORMAT_1 = "yyyy_MM_dd_HH_mm_ss";
  static const String DATE_FORMAT_2 = "yyyy-MM-dd HH:mm:ss";
  static const String DATE_FORMAT_3 = "dd MMM yyyy, hh:mm a";
  static const String DATE_FORMAT_4 = "dd MMM yyyy";
  static const String DATE_FORMAT_5 = "EEE, dd MMM, hh:mm a";
  static const String DATE_FORMAT_6 = "EEE, dd MMM yy";
  static const String DATE_FORMAT_7 = "EEE, dd MMM, hh:mm a";
  static const String DATE_FORMAT_8 = "EEE, dd MMM, yyyy";
  static const String DATE_FORMAT_9 = "EEE, dd MMM\nhh:mm a";
  static const String TIME_FORMAT_1 = "hh:mm a";
  static const String TIME_FORMAT_2 = "hh:mm:ss";
  static Map<String, RefreshCallback> fastRefreshCallbacks =
      <String, RefreshCallback>{};
  static Map<String, RefreshCallback> refreshCallbacks =
      <String, RefreshCallback>{};
  static GlobalKey<ScaffoldState> appBarKey = GlobalKey<ScaffoldState>();

  static Timer? _timer;
  static double buttonWidth = 70.w;

  static final RxBool networkAvailable = true.obs;
  static final RxString errorTitle = ''.obs;
  static final RxString errorMessage = ''.obs;
  static String currentDeviceId = '';

  // static String getTimeAgo(String dateString) {
  //   // Parse the input date string
  //   DateTime dateTime = DateTime.parse(dateString);
  //
  //   // Get the current date and time
  //   DateTime now = DateTime.now();
  //
  //   // Calculate the difference between the two dates
  //   Duration difference = now.difference(dateTime);
  //
  //   if (difference.inDays > 0) {
  //     if (difference.inDays == 1) {
  //       return '1 day ago';
  //     } else {
  //       return '${difference.inDays} days ago';
  //     }
  //   } else if (difference.inHours > 0) {
  //     return '${difference.inHours} hours ago';
  //   } else if (difference.inMinutes > 0) {
  //     return '${difference.inMinutes} minutes ago';
  //   } else if (difference.inSeconds > 0) {
  //     return '${difference.inSeconds} seconds ago';
  //   } else {
  //     return 'Just now';
  //   }
  // }

  static void init() async {
    var deviceInfo = DeviceInfoPlugin();
    if (PlatformType.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      currentDeviceId = androidDeviceInfo.id; // unique ID on Android
    } else if (PlatformType.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      currentDeviceId =
          iosDeviceInfo.identifierForVendor ?? ''; // unique ID on iOS
    }
  }

  static setError(String title, String message) {
    errorTitle.value = title;
    errorMessage.value = message;
  }

  static String getCategoryName(int categoryId, List<CategoryData> categories) {
    try {
      final category = categories.firstWhere((cat) => cat.id == categoryId);
      return category.name;
    } catch (e) {
      return 'Unknown';
    }
  }

  static clearError() {
    errorTitle.value = '';
    errorMessage.value = '';
  }

  static void openDrawer() async {
    appBarKey.currentState?.openDrawer();
  }

  static String getProfileImageUrl(String? imagePath) {
    if (imagePath == null || imagePath == 'Image Not Available') {
      return 'https://www.gaamraam.ngo/public/student/backend/male.jpeg';
    } else if (imagePath.contains('https://www.gaamraam.ngo/public')) {
      return imagePath;
    } else {
      return 'https://www.gaamraam.ngo/public/$imagePath';
    }
  }

  static const List<String> validImageExtensions = [
    'png',
    'jpg',
    'jpeg',
    'webp',
  ];

  // static void initAutoRefreshTimer({int delayInSeconds = 4}) {
  //   if (_timer != null) {
  //     _timer?.cancel();
  //   }
  //
  //   _timer = Timer.periodic(Duration(seconds: delayInSeconds), (timer) {
  //     if (Const.lifecycleState == AppLifecycleState.resumed &&
  //         Helper.networkAvailable.isTrue) {
  //       // int sleep = (delayInSeconds * 1000) ~/ fastRefreshCallbacks.length;
  //       int sleep = 400;
  //
  //       // Logger.m(tag: "TIME STATUS CHECK : " + Helper.currentMillis.toString());
  //
  //       fastRefreshCallbacks.forEach((key, value) async {
  //         value.call();
  //         await Future.delayed(Duration(milliseconds: sleep));
  //         //Logger.m(tag: "TIME STATUS CHECK REC : " + Helper.currentMillis.toString());
  //       });
  //
  //       if (timer.tick.isOdd) {
  //         refreshCallbacks.forEach((key, value) async {
  //           value.call();
  //           await Future.delayed(Duration(milliseconds: sleep));
  //         });
  //       }
  //     }
  //   });
  // }

  static String hideEmail(String email) {
    if (!email.contains('@')) return email;

    final parts = email.split('@');
    final name = parts[0];
    final domain = parts[1];

    String hiddenName;
    if (name.length <= 2) {
      hiddenName = '${name[0]}*';
    } else {
      hiddenName = name[0] + '*' * (name.length - 2) + name[name.length - 1];
    }

    return '$hiddenName@$domain';
  }

  static void addRefreshCallback(
    String key,
    VoidCallback callback, {
    bool fastRefresh = false,
  }) {
    if (fastRefresh) {
      if (!fastRefreshCallbacks.containsKey(key)) {
        fastRefreshCallbacks.putIfAbsent(key, () => callback);
      } else {
        Logger.m(
          tag: '!!!!!!!!!! Callback already exist !!!!!!!!!!',
          value: key,
        );
      }
    } else {
      if (!refreshCallbacks.containsKey(key)) {
        refreshCallbacks.putIfAbsent(key, () => callback);
      } else {
        Logger.m(
          tag: '!!!!!!!!!! Callback already exist !!!!!!!!!!',
          value: key,
        );
      }
    }
  }

  static void removeAutoRefreshCallback(String key) {
    if (fastRefreshCallbacks.containsKey(key)) fastRefreshCallbacks.remove(key);
    if (refreshCallbacks.containsKey(key)) refreshCallbacks.remove(key);
    Logger.m(tag: 'Removed From Refresh Callback', value: key);
  }

  static int parseInt(dynamic value) {
    if (value == null || value.toString().empty) {
      // Logger.m(tag: 'INTEGER PARSE ERROR', value: 'NULL VALUE');
      return 0;
    }

    if (value is int) {
      return value;
    }

    if (value is String) {
      try {
        return value.isNotEmpty ? int.parse(value) : 0;
      } catch (e) {
        Logger.m(tag: 'INTEGER PARSE ERROR', value: e);
      }
    }

    if (value is double) {
      return value.toInt();
    }

    return 0;
  }

  static double parseDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    }

    if (value is int) {
      return value.toDouble();
    }

    if (value is String) {
      try {
        return value.isNotEmpty ? double.parse(value) : 0;
      } catch (e) {
        return 0.0;
      }
    }

    if (value is double) {
      return value;
    }

    return 0.0;
  }

  static String parseString(dynamic value) {
    if (value == null) {
      return '';
    }

    if (value is String) {
      return value;
    }

    return value.toString();
  }

  static String checkNull(String? value, {String defaultValue = ''}) {
    if (!isEmpty(value)) {
      return value.nullSafe;
    }
    return defaultValue.nullSafe;
  }

  static bool isEmpty(String? value) {
    return value == null || value == '' || value.isEmpty || value == 'null';
  }

  static bool isEmptyAny(List<String>? values) {
    if (values == null) {
      return true;
    }

    for (int i = 0; i < values.length; i++) {
      if (isEmpty(values[i])) {
        return true;
      }
    }
    return false;
  }

  // static Future<bool> requestStoragePermission() async {
  //   DeviceInfoPlugin plugin = DeviceInfoPlugin();
  //   AndroidDeviceInfo android = await plugin.androidInfo;
  //   Permission p =
  //       android.version.sdkInt < 33 ? Permission.storage : Permission.photos;
  //
  //   var permission = await p.request();
  //
  //   if (permission != PermissionStatus.granted) {
  //     permission = await p.request();
  //   }
  //
  //   return permission == PermissionStatus.granted;
  // }
  //
  // static Future<bool> getStoragePermission() async {
  //   DeviceInfoPlugin plugin = DeviceInfoPlugin();
  //   AndroidDeviceInfo android = await plugin.androidInfo;
  //   if (android.version.sdkInt < 33) {
  //     if (await Permission.storage.request().isGranted) {
  //       return true;
  //     } else if (await Permission.storage.request().isPermanentlyDenied) {
  //       await openAppSettings();
  //     } else if (await Permission.audio.request().isDenied) {
  //       return false;
  //     }
  //   } else {
  //     if (await Permission.photos.request().isGranted) {
  //       return true;
  //     } else if (await Permission.photos.request().isPermanentlyDenied) {
  //       await openAppSettings();
  //     } else if (await Permission.photos.request().isDenied) {
  //       return false;
  //     }
  //   }
  //   return false;
  // }

  static bool isValidUrl(
    String path, {
    String imageName = '',
    List<String> validExtensions = const [
      'png',
      'jpg',
      'jpeg',
      'webp',
      'pdf',
      'doc',
      'docx',
    ],
  }) {
    if (isEmpty(path)) {
      return false;
    }

    path = path + imageName.nullSafe;

    String ext = path.split('.').last;

    if (path.startsWith('http') && validExtensions.contains(ext)) {
      return true;
    }

    return false;
  }

  static BoxDecoration dialogBoxDecoration([double radius = 20]) =>
      BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 5,
        //     blurRadius: 7,
        //     offset: Offset(0, 3),
        //   )
        // ],
      );

  static String getEveryFirstDigit(String? name) {
    if (Helper.isEmpty(name)) {
      return '?';
    }

    List<String> li = name!.trim().split(' ');

    String str = '';

    if (li.length == 1 && li[0].length >= 2) {
      return li[0].substring(0, 2).toUpperCase();
    }

    li.forEach((element) => str += element.substring(0, 1));

    return str.toUpperCase();
  }

  // static void openUrl(String url,
  //     {bool includeHttp = false,
  //     void Function()? success,
  //     void Function(String s)? onError,
  //     LaunchMode launchMode = LaunchMode.inAppWebView}) async {
  //   if (url.notEmpty) {
  //     try {
  //       if (includeHttp && !url.startsWith('https://')) {
  //         url = 'https://$url';
  //       }
  //
  //       await launchUrlString(url, mode: launchMode).then((value) {
  //         Logger.m(tag: 'OPEN URL', value: value);
  //       });
  //
  //       if (success != null) success.call();
  //     } catch (e) {
  //       Logger.m(tag: 'openUrl', value: "'$url' Can't be launch! $e");
  //       if (onError != null) onError.call(e.toString());
  //     }
  //   } else {
  //     if (onError != null) onError.call("Can't launch url!");
  //   }
  // }

  static String getTimeAgo(dynamic time) {
    if (time == null) {
      return '';
    }

    try {
      Duration diff;

      if (time.toString().isNumeric) {
        diff = DateTime.now().difference(
          DateTime.fromMillisecondsSinceEpoch(time.toString().toInt),
        );
      } else {
        diff = DateTime.now().difference(DateTime.parse(time));
      }

      if (diff.inDays > 365)
        return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
      if (diff.inDays > 30)
        return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
      if (diff.inDays > 7)
        return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
      if (diff.inDays > 0)
        return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
      if (diff.inHours > 0)
        return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
      if (diff.inMinutes > 0)
        return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
      return "Just now";
    } catch (e) {
      Logger.ex(
        tag: 'GET TIME AGO',
        value: e.toString() + ' (' + time.toString() + ')',
      );
      return time;
    }
  }

  static double calculateDistance(
    double? lat1,
    double? lon1,
    double? lat2,
    double? lon2,
  ) {
    if (lat1 == null ||
        lat2 == null ||
        lon1 == null ||
        lon2 == null ||
        lat1 <= 0.0 ||
        lat2 <= 0 ||
        lon1 <= 0 ||
        lon2 <= 0) {
      return -1;
    }

    var p = 0.017453292519943295;
    var c = cos;
    var a =
        0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static int get currentMillis => DateTime.now().microsecondsSinceEpoch;

  //
  // static String getCurrentDate(String format) {
  //   final DateFormat formatter = DateFormat(format);
  //   return formatter.format(DateTime.now());
  // }
  //
  // static String formatDate(DateTime dateTime, String format) {
  //   final DateFormat formatter = DateFormat(format);
  //   return formatter.format(dateTime);
  // }
  //
  // static String formatMilliseconds(int milli, String format) {
  //   final DateFormat formatter = DateFormat(format);
  //   return formatter.format(DateTime.fromMillisecondsSinceEpoch(milli));
  // }
  //
  // static String format(String dateTime, String format) {
  //   try {
  //     final DateFormat formatter = DateFormat(format);
  //     return formatter.format(DateTime.parse(dateTime.trim()));
  //   } catch (e) {
  //     Logger.e(tag: "DATE FORMAT : ", value: e.toString());
  //     return dateTime.nullSafe;
  //   }
  // }

  static DateTime formatDateTime(String dateTime) {
    try {
      return DateTime.parse(dateTime);
    } catch (e) {
      Logger.e(tag: "DATE FORMAT : ", value: e.toString());
      return DateTime(1990);
    }
  }

  static int convertToMillis(String dateTime) {
    try {
      return DateTime.parse(dateTime).millisecondsSinceEpoch;
    } catch (e) {
      Logger.e(tag: "DATE FORMAT : ", value: e.toString());
      return DateTime(1990).millisecondsSinceEpoch;
    }
  }

  // static String getDay(String dateTime) {
  //   try {
  //     final DateFormat formatter = DateFormat('d');
  //     return formatter.format(DateTime.parse(dateTime));
  //   } catch (e) {
  //     Logger.e(tag: "DATE FORMAT : ", value: e.toString());
  //     return '';
  //   }
  // }

  static String createGroupId(String first, String second) {
    if (first.hashCode > second.hashCode) {
      return first + '__' + second;
    } else {
      return second + '__' + first;
    }
  }

  static bool isContainKeyword(String keyword, List<String?>? values) {
    if (!Helper.isEmpty(keyword) && values != null && values.length != 0) {
      for (int i = 0; i < values.length; i++) {
        if (!Helper.isEmpty(values[i]) &&
            values[i]!.toLowerCase().contains(keyword.toLowerCase())) {
          return true;
        }
      }
    }
    return false;
  }

  // static void shareApp() => Share.share(
  //     'Please download App From here   https://play.google.com/store/apps/details?id=com.mkctv.app');

  static void shareApp() =>
      'Please download App From here   https://play.google.com/store/apps/details?id=com.mkctv.app';

  static int get generateNumber => Random().nextInt(900000) + 100000;

  static List<String> toList(String? s) {
    if (isEmpty(s)) {
      return <String>[];
    }

    List<String> li = s!.split(',');
    return li.where((element) => !isEmpty(element)).toList();
  }

  static String formatResponseTime(int minutes) {
    Duration duration = Duration(minutes: minutes);
    int twoDigits(int n) => n.toString().padLeft(2, '0').toInt;
    int twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    // int twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    String time;
    if (minutes >= 60) {
      time = twoDigits(duration.inHours).toString() + 'h ';
    } else {
      time = '';
    }

    if (twoDigitMinutes > 0) {
      time += twoDigitMinutes.toString() + 'min';
    }

    return time;
  }

  // static void currencyFormatter(
  //     String value, TextEditingController controller) {
  //   int dotCount = value.charCount('.');
  //   int allowedDigitBeforeDot = 8;
  //   int allowedDigitAfterDot = 4;
  //
  //   if (dotCount > 1) {
  //     var v = value.split('.');
  //
  //     value = v[0] + '.' + v[1];
  //
  //     controller.value = TextEditingValue(
  //         text: value,
  //         selection: TextSelection.collapsed(offset: value.length));
  //   }
  //
  //   if (dotCount > 0) {
  //     var v = value.split('.');
  //
  //     if (v[0].length > allowedDigitBeforeDot) {
  //       v[0] = v[0].substring(0, allowedDigitBeforeDot);
  //     }
  //
  //     if (v[1].length > allowedDigitAfterDot) {
  //       v[1] = v[1].substring(0, allowedDigitAfterDot);
  //     }
  //
  //     value = v[0] + '.' + v[1];
  //
  //     controller.value = TextEditingValue(
  //         text: value,
  //         selection: TextSelection.collapsed(offset: value.length));
  //   } else if (value.length > allowedDigitBeforeDot) {
  //     value = value.substring(0, allowedDigitBeforeDot);
  //     controller.value = TextEditingValue(
  //         text: value,
  //         selection: TextSelection.collapsed(offset: value.length));
  //   }
  // }

  static void logOut() {
    MyAlertDialog()
        .setButtonAlignment(Alignment.bottomCenter)
        .setTitleAlignment(Alignment.bottomCenter)
        .setMessageAlignment(Alignment.bottomCenter)
        .setFirstSpacing(30)
        .setSecondSpacing(15)
        .setTitle('${Strings.get('logout')}?')
        .setMessage(Strings.get('youWantToLogOut'))
        .setPositiveButton('yes'.t, logOutWithoutAlert)
        .setNegativeButton('no'.t, null)
        .show();
  }

  static Future<void> logOutWithoutAlert() async {
    await Preference.setLogin(false);
    await Preference.clear();
    // await AppDb.instance.clearAllTables();
    Helper.refreshCallbacks.clear();
    Helper.fastRefreshCallbacks.clear();
    await Get.deleteAll();
    // Const.reset();
    // Get.back();
    Get.offAll(() => LoginScreen());
  }

  static void exitAlert() {
    MyAlertDialog()
        .setButtonAlignment(Alignment.bottomCenter)
        .setTitleAlignment(Alignment.bottomCenter)
        .setMessageAlignment(Alignment.bottomCenter)
        .setFirstSpacing(30)
        .setSecondSpacing(15)
        .setTitle(Strings.get('exit'))
        .setMessage(Strings.get('youWantToExitFromApp'))
        .setPositiveButton('yes'.t, () {
          SystemNavigator.pop();
          return;
        })
        .setNegativeButton('no'.t, null)
        .show();
  }

  static bool get isTester {
    return kDebugMode;
  }

  // static Future<CroppedFile?> cropImageFile(
  //   String path, {
  //   List<CropAspectRatioPreset> cropAspectRatioPresets = const [
  //     CropAspectRatioPreset.original,
  //     CropAspectRatioPreset.square,
  //     CropAspectRatioPreset.ratio3x2,
  //     CropAspectRatioPreset.ratio4x3,
  //     CropAspectRatioPreset.ratio16x9
  //   ],
  //   CropAspectRatio? aspectRatio,
  // }) async {
  //   CroppedFile? croppedFile = await ImageCropper().cropImage(
  //     sourcePath: path,
  //     aspectRatio: aspectRatio,
  //     uiSettings: [
  //       AndroidUiSettings(
  //         toolbarTitle: 'crop'.tr,
  //         toolbarColor: ThemeColors.colorPrimary,
  //         toolbarWidgetColor: Colors.white,
  //         initAspectRatio: CropAspectRatioPreset.ratio4x3,
  //         lockAspectRatio: true,
  //       ),
  //       IOSUiSettings(
  //         title: 'crop'.tr,
  //         minimumAspectRatio: 1.0,
  //         aspectRatioLockEnabled: true,
  //       ),
  //     ],
  //   );
  //   return croppedFile;
  // }

  static String numberToString(int number) {
    switch (number) {
      case 0:
        return 'First';
      case 1:
        return 'Second';
      case 2:
        return 'Third';
      default:
        return (number + 1).toString() + "th";
    }
  }

  static formatNumber(String? s, {bool withPlus = false}) {
    if (s.empty) {
      return '';
    }

    for (String c in [' ', '+', '-', '(', ')']) {
      s = s!.replaceAll(c, '');
    }

    return (withPlus ? '+' : '') + s.nullSafe;
  }

  // static String getFileNamePrefix(String pathType) {
  //   switch (pathType) {
  //     case FileUploadType.FILE:
  //       return 'FILE_';
  //     case FileUploadType.PROFILE_IMG:
  //       return 'PROFILE_';
  //     case FileUploadType.SMS_MEDIA:
  //       return 'SMS_IMG_';
  //   }
  //   return 'UNKNOWN_';
  // }

  static String starred(String str, int count) {
    if (str.empty) return '';

    if (str.length < count) return str;

    return str.substring(0, count) +
        List.generate(min(str.length - count, 20), (index) => '*').join('');
  }

  // static bool hasAccess(String featureName) {
  //   //TODO:
  //   // if (Helper.isTester) {
  //   //   Toasty.normal('Working in test mode');
  //   //   return true;
  //   // }
  //
  //   if (!Const.featuresStatus.containsKey(featureName)) {
  //     MyAlertDialog()
  //         .setTitle('Error!')
  //         .setMessage(
  //             'Something is wrong with this feature!\nPlease contact to the support and try again later')
  //         .setPositiveButton('OK', null)
  //         .show();
  //     return false;
  //   }
  //
  //   FeatureStatus status = Const.featuresStatus[featureName]!;
  //
  //   Logger.m(tag: "ON TRIAL : ", value: Const.onTrial.isTrue);
  //   Logger.m(tag: "FEATURE SS : " + featureName, value: status.toString());
  //
  //   if (status.isPremium) {
  //     if ((Const.onTrial.isTrue && status.isAccessibleInTrial) ||
  //         status.hasAccess) {
  //       return true;
  //     }
  //   } else {
  //     return true;
  //   }
  //
  //   // SubscriptionAlertSheet(status.message);
  //   return false;
  // }

  // static String getVerboseDateTimeRepresentation(String date) {
  //   try {
  //     int dateTime = DateTime.parse(date).millisecondsSinceEpoch;
  //     int now = DateTime.now().millisecondsSinceEpoch;
  //
  //     int diff = now - dateTime;
  //
  //     if (diff < 12 * 60 * 60 * 1000) {
  //       return Helper.formatMilliseconds(dateTime, 'hh:mm a');
  //     } else if (diff < 365 * 24 * 60 * 60 * 1000) {
  //       return Helper.formatMilliseconds(dateTime, 'MMM dd');
  //     } else {
  //       return Helper.formatMilliseconds(dateTime, 'dd MMM, yyyy');
  //     }
  //   } catch (e) {
  //     Logger.e(tag: 'DateTimeRepresentation', value: e);
  //     return '';
  //   }
  // }

  static String? emptyValidator(String str) {
    return str.empty ? 'Please fill this field!' : null;
  }

  // static bool isSupportedMime(File file) {
  //   String mimeType = lookupMimeType(file.path) ?? '';
  //   return Const.allSupportedMimeType.contains(mimeType);
  // }
  //
  // static bool isImage(File file) {
  //   String mimeType = lookupMimeType(file.path) ?? '';
  //   return Const.supportedImageType.contains(mimeType);
  // }
  //
  // static bool isAudio(File file) {
  //   String mimeType = lookupMimeType(file.path) ?? '';
  //   return Const.supportedAudioType.contains(mimeType);
  // }
  //
  // static bool isVideo(File file) {
  //   String mimeType = lookupMimeType(file.path) ?? '';
  //   return Const.supportedVideoType.contains(mimeType);
  // }

  static String fileIcon(String path) {
    List<String> parts = path.nullSafe.split('.');

    if (parts.length > 1) {
      String ext = parts.last;

      switch (ext.toUpperCase()) {
        //FOR IMAGE
        case 'PNG':
        case 'JPG':
        case 'JPEG':
        case 'GIF':
        case 'WEBP':
          return 'assets/icons/check_outline.png';
        //FOR EXCEL
        case 'CSV':
          return 'assets/icons/csv.png';
        case 'XLS':
        case 'XLSX':
          return 'assets/icons/xls.png';
        //FOR VIDEO
        case 'MPEG':
        case 'MP4':
        case 'QUICKTIME':
        case 'WEBM':
        case '3GPP':
        case '3GPP2':
        case '3GPP-TT':
        case 'H261':
        case 'H263':
        case 'H263-1998':
        case 'H263-2000':
        case 'H264':
          return 'assets/icons/video.png';
        //FOR AUDIO
        case 'BASIC':
        case 'L24':
        case 'MP4':
        case 'MPEG':
        case 'OGG':
        case '3GPP':
        case '3GPP2':
        case 'AC3':
        case 'WEBM':
        case 'AMR-NB':
        case 'AMR':
        case 'MP3':
          return 'assets/icons/audio.png';
      }
    }

    return 'assets/icons/alert_round.png';
  }

  // static void openSupportWhatsapp() {
  //   var whatsappAndroid = "https://wa.me/${Const.config.value.wss}/?text=";
  //   Helper.openUrl(whatsappAndroid, onError: (e) {
  //     Toasty.failed('WhatsApp not installed!');
  //   }, launchMode: LaunchMode.externalApplication);
  // }
}

extension StringExtensions on String? {
  String get inCaps =>
      notEmpty && this!.length > 0
          ? '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}'
          : '';

  String get capitalizeFirstOfEach =>
      notEmpty
          ? this!
              .replaceAll(RegExp(' +'), ' ')
              .split(' ')
              .map((str) => str.inCaps)
              .join(' ')
          : '';

  String get everyFirstDigit => Helper.getEveryFirstDigit(this);

  // String get nullSafe => Helper.checkNull(this);
  String get nullSafe => this ?? '';

  String placeholder(String? def) => empty ? def.nullSafe : nullSafe;

  String get nullStr => this ?? '------';

  bool get notEmpty => !Helper.isEmpty(this);

  bool get empty => Helper.isEmpty(this);

  int get toInt => Helper.parseInt(this);

  double get toDouble => Helper.parseDouble(this);

  void get copy => Clipboard.setData(ClipboardData(text: this.nullSafe));

  List<String> get toList => Helper.toList(this);

  String get t => Strings.get(this);

  bool get isNumeric => this.notEmpty && double.tryParse(this ?? '0') != null;

  String get formatNumber => Helper.formatNumber(this ?? '0');

  String get formatNumberWithPlus =>
      Helper.formatNumber(this ?? '0', withPlus: true);

  String get starred => Helper.starred(nullSafe, 6);

  int charCount(String char) =>
      notEmpty
          ? nullSafe
              .split('')
              .fold<int>(
                0,
                (previousValue, ch) => previousValue + (ch == char ? 1 : 0),
              )
          : 0;

  String take(int length) {
    if (this.notEmpty && nullSafe.length > length) {
      return nullSafe.substring(0, length) + '...';
    }
    return this.nullSafe;
  }
}
