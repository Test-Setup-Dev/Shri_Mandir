import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/data_handler/repository.dart';
import 'package:mandir/screen/donation/history/controller.dart';
import 'package:mandir/screen/donation/top_donor/controller.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/utils/logger.dart';
import 'package:mandir/utils/toasty.dart';
import 'dart:convert';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayController {
  final Razorpay _razorpay = Razorpay();

  RazorpayController() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWalletSelected);
  }

  Future<Map<String, dynamic>?> createOrder(int amount) async {
    try {
      final response = await Repository.instance.createOrder(amount);
      return response;
    } catch (e) {
      Logger.m(tag: 'Create Order Error', value: e.toString());
      return null;
    }
  }

  void startPayment({
    required String amount,
    required String name,
    required String description,
    required String email,
    required String contact,
    required String orderId,
    required String razorpayKey,
  }) {
    var options = {
      'key': razorpayKey,
      'amount': int.parse(amount),
      'name': 'appName'.t,
      'description': description,
      'order_id': orderId,
      'prefill': {'contact': contact, 'email': email},
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      Toasty.failed('Payment initialization failed');
    }
  }

  void _handlePaymentErrorResponse(PaymentFailureResponse response) {
    Toasty.failed('Payment failed: ${response.message}');
    Logger.m(tag: 'Payment Error', value: response.message ?? '');
  }

  void _handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    Logger.m(tag: 'Payment Success', value: response.paymentId ?? '');
    try {
      final verifyResponse = await Repository.instance.verifyPayment(
        response.paymentId,
        response.orderId,
        response.signature,
      );

      if (verifyResponse != null && verifyResponse['status'] == true) {
        // Toasty.success('Payment verified successfully');
        await TopDonorsController().fetchTopDonors();
      } else {
        Logger.e(tag: 'Payment Error', value: 'Signature verification failed');
      }
    } catch (e) {
      Toasty.failed('Payment verification failed');
      Logger.e(tag: 'Payment Error', value: e.toString());
    }
  }

  void _handleExternalWalletSelected(ExternalWalletResponse response) {
    Toasty.info('External Wallet Selected: ${response.walletName}');
  }

  void dispose() {
    _razorpay.clear();
  }
}

class RazorpayHelper {
  final Razorpay _razorpay = Razorpay();

  RazorpayHelper() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWalletSelected);
  }

  void openCheckout(Map<String, dynamic> options) {
    _razorpay.open(options);
  }

  void clear() {
    _razorpay.clear();
  }

  // ---------------- Event Handlers ----------------

  void _handlePaymentErrorResponse(PaymentFailureResponse response) {
    Logger.e(tag: 'Handle Payment Error', value: response.message ?? '');
    Toasty.failed('Payment failed: ${response.message}');
  }

  void _handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    Logger.m(tag: 'Payment Success', value: response.paymentId ?? '');
    await _verifySignature(
      paymentId: response.paymentId!,
      orderId: response.orderId!,
      signature: response.signature!,
    );
  }

  void _handleExternalWalletSelected(ExternalWalletResponse response) {
    Logger.m(tag: 'External Wallet Selected', value: response.walletName);
    Toasty.info('External Wallet Selected: ${response.walletName}');
  }

  // ---------------- Signature Verification ----------------

  Future<void> _verifySignature({
    required String paymentId,
    required String orderId,
    required String signature,
  }) async {
    try {
      Logger.m(tag: 'Payment Signature', value: signature);

      final response = await Repository.instance.verifyPayment(
        paymentId,
        orderId,
        signature,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          Toasty.success('Payment verified successfully');
        } else {
          Toasty.failed('Payment verification failed');
        }
      } else {
        Logger.e(
          tag: 'Payment Error',
          value: 'Server error: ${response.statusCode}',
        );
      }
    } catch (e) {
      Logger.e(
        tag: 'Payment Error',
        value: 'Signature verification failed: $e',
      );
      Toasty.failed('Payment verification failed');
    } finally {
      Get.back();
    }
  }
}
