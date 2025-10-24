import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mandir/model/result.dart';
import 'package:mandir/utils/const.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/utils/notification_helper.dart';
import 'package:mandir/utils/preference.dart';
// import 'package:kalpjyotish/modals/notification_model.dart' as my;

import 'api_provider.dart';

class Repository extends ApiProvider {
  static Repository? _instance;

  static Repository get instance {
    if (_instance == null) {
      _instance = Repository._init();
    }
    return _instance!;
  }

  Repository._init();

  void onFlutterError(FlutterErrorDetails flutterErrorDetails) {
    String information = '';

    reportError(
      tag: flutterErrorDetails.toStringShort(),
      value: flutterErrorDetails.exceptionAsString(),
      context: flutterErrorDetails.context?.value?.toString() ?? '',
      stack: flutterErrorDetails.stack.toString(),
      information: information,
    );
  }

  void reportError({
    required String tag,
    required String value,
    String context = '',
    String stack = '',
    String information = '',
  }) {
    if (!kDebugMode) {
      Map<String, dynamic> error = {
        'tag': tag,
        'value': value,
        'context': context,
        'userEmail':
            Preference.isAvailable && Preference.isLogin
                ? Preference.user.email.nullSafe
                : '',
        'stack': stack,
        'information': information,
      };
      super.postDynamic('reportError', parameters: error);
    }
  }

  Future<dynamic> signup(
    String name,
    String email,
    String phone,
    String password,
    String fcmToken,
  ) async {
    return super.postDynamic(
      'register',
      parameters: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'date_of_birth': "2004-02-12",
        "city": "Dehradun",
        "address": "123, Ring Road, Satellite",
        "pincode": "380015",
        "state": "Uttarakhand",
        "country": "India",
        "gender": "Male",
        "image":
            "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341",
        'fcm_token': fcmToken,
      },
    );
  }

  Future<dynamic> sendNotification() async {
    return super.postDynamic(
      'sendnotification',
      parameters: {
        "title": "Hello User",
        "body": "Your notification Firebase!",
      },
    );
  }

  Future<dynamic> createOrder(amount) async {
    return super.postDynamic(
      'donation/create-order',
      parameters: {"amount": amount},
    );
  }

  Future<dynamic> verifyPayment(paymentId, orderId, signature) async {
    return super.postDynamic(
      'donation/verify-payment',
      parameters: {
        "razorpay_payment_id": paymentId ?? '',
        "razorpay_order_id": orderId ?? '',
        "razorpay_signature": signature ?? '',
      },
    );
  }

  Future<dynamic> login(String email, String password, fcmToken) async {
    return super.postDynamic(
      'login',
      parameters: {'email': email, 'password': password, 'fcm_token': fcmToken},
    );
  }

  Future<dynamic> getBanner() async {
    return super.getDynamic('admin/banners', parameters: {});
  }

  Future<dynamic> getBlogs() async {
    return super.getDynamic('blogs');
  }

  Future<dynamic> getDonations() async {
    return super.getDynamic('donations');
  }

  Future<dynamic> getHomeData() async {
    return super.getDynamic('home-data');
  }

  Future<dynamic> getCategory() async {
    return super.getDynamic('category');
  }

  // Future<dynamic> getTestToken() async {
  //   return super.postDynamic('getTestToken');
  // }
  //
  // Future<dynamic> searchAstro() async {
  //   return super.getDynamic('astrologer/all');
  // }
  //
  // Future<dynamic> getAstrologer() async {
  //   return super.getDynamic('astrologer/all');
  // }
  //
  // Future<dynamic> getPooja() async {
  //   return super.getDynamic('all-poojas');
  // }
  //
  // Future<dynamic> getShopItems() async {
  //   return super.getDynamic('products/all');
  // }
  //
  // Future<dynamic> getLiveAstro() async {
  //   return super.postDynamic('liveAstrologer/get');
  // }
  //
  // Future<dynamic> updateUser({id}) async {
  //   return super.postDynamic('user/update/$id', parameters: {'name': 'ajajaj'});
  // }
  //
  // // Future<dynamic> getBanner() {
  // //   return super.getDynamic('banners/get-banner');
  // // }
  //
  // Future<dynamic> getTransit() async {
  //   return super.getDynamic('transits/get-trasnsit');
  // }
  //
  // Future<List<dynamic>> getFeatures() {
  //   return super.getList('f952-3bb7-43fd-b6ba');
  // }
  //
  // Future<dynamic> getFAQ() async {
  //   return super.getDynamic('astrologer/all');
  // }
  //
  // // Future<List<Map<String, dynamic>>> getMessages(String chatId) async {
  // //   final snapshot = await FirebaseFirestore.instance
  // //       .collection('chats')
  // //       .doc(chatId)
  // //       .collection('messages')
  // //       .orderBy('timestamp', descending: false)
  // //       .get();
  // //
  // //   return snapshot.docs.map((doc) => doc.data()).toList();
  // // }
  //
  // Future<dynamic> deleteMessages(uid) async {
  //   return super.postDynamic('deleteMessage', parameters: {'uid': uid});
  // }
  //
  // Future<dynamic> socialLogin(
  //   String socialId,
  //   String authType,
  //   String name,
  //   String email,
  //   String profilePic,
  // ) async {
  //   return super.postDynamic(
  //     'socialLogin',
  //     parameters: {
  //       'socialId': socialId,
  //       'authType': authType,
  //       'name': name,
  //       'email': email,
  //       'profilePic': profilePic,
  //     },
  //   );
  // }
  //
  // Future<dynamic> testerLogin(String email) async {
  //   return super.postDynamic('testerLogin', parameters: {'email': email});
  // }
  //
  //
  //
  // // Future<dynamic> login(String email, String password) async {
  // //   return super.postJson(
  // //     'login'
  // //     // parameters: {'email': email, 'password': password},
  // //     parameters: {'email': email},
  // //   );
  // // }
  //
  // Future<dynamic> agoraToken(
  //   String channelName,
  //   String userId,
  //   String callType,
  // ) async {
  //   return super.postJson(
  //     'agora/generate-token',
  //     parameters: {
  //       "channelName": channelName,
  //       "userId": userId,
  //       "callType": callType,
  //     },
  //   );
  // }
  //
  // Future<dynamic> validateOtp(String phone, String fcmToken) async {
  //   return super.postDynamic('validateOtp', parameters: {'phone': phone});
  // }
  //
  // Future<dynamic> sendOtp(String email) async {
  //   return super.postDynamic('auth/send-otp', parameters: {'email': email});
  // }

  Future<List<int>?> hitUrl(String url) {
    return super.hitUrl(url);
  }

  Future<dynamic> saveFcmToken(String fcmToken) async {
    return super.postDynamic(
      'notification/save-token',
      parameters: {
        'userId': Preference.user.id,
        'fcmToken': fcmToken,
        'userType': 'UserDetail',
        'deviceType': "Android",
      },
    );
  }

  void unreadNotificationCount() async {
    Result result = await getResult(
      'unreadNotificationCount',
      enableResponseLogs: false,
      enableParamsLogs: false,
      reportError: false,
    );
    if (result.success) {
      Const.notificationCount.value = result.data.toInt;
    }
  }

  Future<List<dynamic>> getTickets() {
    return super.getList('getTickets');
  }

  Future<Result> saveVoicemailType(
    String? message,
    String? file,
    String? type,
  ) {
    return super.getResult(
      'setVoiceMailType',
      parameters: {'message': message, 'file': file, 'type': type},
    );
  }
}
