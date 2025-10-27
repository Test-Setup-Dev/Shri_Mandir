import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/data_handler/repository.dart';
import 'package:url_launcher/url_launcher.dart';

// Support Model
class SupportContact {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String createdAt;
  final String updatedAt;

  SupportContact({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SupportContact.fromJson(Map<String, dynamic> json) {
    return SupportContact(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

// Controller
class SupportController extends GetxController {
  final isLoading = false.obs;
  final supportContacts = <SupportContact>[].obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSupportContacts();
  }

  // Fetch Support Contacts
  Future<void> fetchSupportContacts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      var response = await Repository.instance.userSupport();

      if (response['status'] == true) {
        final List<dynamic> dataList = response['data'] ?? [];

        supportContacts.value =
            dataList.map((e) => SupportContact.fromJson(e)).toList();

        if (supportContacts.isEmpty) {
          errorMessage.value = 'No support contacts available';
        }
      } else {
        errorMessage.value =
            response['message'] ?? 'Failed to fetch support contacts';
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred';
      print('💥 Error fetching support contacts: $e');
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Make Phone Call
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        Get.snackbar(
          'Error',
          'Could not launch phone dialer',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to make call: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Send Email
  Future<void> sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Support Request&body=Hello, I need help with...',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        Get.snackbar(
          'Error',
          'Could not launch email client',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send email: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Send WhatsApp Message
  Future<void> sendWhatsApp(String phoneNumber) async {
    // Remove any special characters and spaces
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    // Add country code if not present (assuming India +91)
    if (!cleanNumber.startsWith('91') && cleanNumber.length == 10) {
      cleanNumber = '91$cleanNumber';
    }

    final Uri whatsappUri = Uri.parse(
      'https://wa.me/$cleanNumber?text=Hello, I need support',
    );

    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'Error',
          'WhatsApp is not installed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to open WhatsApp: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Copy to Clipboard
  void copyToClipboard(String text, String label) {
    // You'll need to import 'package:flutter/services.dart'
    // Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied',
      '$label copied to clipboard',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
  }

  // Refresh Data
  Future<void> refreshData() async {
    await fetchSupportContacts();
  }
}
