import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandir/data_handler/repository.dart';
import 'package:mandir/model/user.dart';
import 'package:mandir/utils/preference.dart';
import 'package:mandir/utils/toasty.dart';
import 'package:mandir/values/theme_colors.dart';

class ProfileUpdateController extends GetxController {
  // Form Controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final pincodeController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

  // Observable variables
  final isLoading = false.obs;
  final selectedImage = Rx<File?>(null);
  final selectedGender = 'male'.obs;
  final profileImageUrl = ''.obs;

  // Form Key
  final formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    // Load existing profile data if available
    loadProfileData();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    dateOfBirthController.dispose();
    cityController.dispose();
    addressController.dispose();
    pincodeController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.onClose();
  }

  // Load existing profile data
  void loadProfileData() {
    User user = Preference.user;
    nameController.text = user.name ?? '';
    phoneController.text = user.phone ?? '+';
    dateOfBirthController.text = user.dob ?? '';
    cityController.text = user.city ?? '';
    addressController.text = user.address ?? '';
    pincodeController.text = user.pinCode ?? '';
    stateController.text = user.state ?? '';
    countryController.text = user.country ?? '';
    selectedGender.value = user.gender ?? 'male';
  }

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      Toasty.failed('Failed to pick image: $e');
    }
  }

  // Pick image from camera
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      Toasty.failed('Failed to capture image: $e');
    }
  }

  // Show image picker options
  void showImagePickerOptions() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Photo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(
                Icons.photo_library,
                color: ThemeColors.primaryColor,
              ),
              title: Text('Choose from Gallery'),
              onTap: () {
                Get.back();
                pickImageFromGallery();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: ThemeColors.primaryColor),
              title: Text('Take a Photo'),
              onTap: () {
                Get.back();
                pickImageFromCamera();
              },
            ),
            if (selectedImage.value != null || profileImageUrl.value.isNotEmpty)
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Remove Photo'),
                onTap: () {
                  selectedImage.value = null;
                  profileImageUrl.value = '';
                  Get.back();
                },
              ),
          ],
        ),
      ),
    );
  }

  // Select Date of Birth
  Future<void> selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2005, 2, 12),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ThemeColors.primaryColor,
              onPrimary: Colors.white,
              onSurface: ThemeColors.defaultTextColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dateOfBirthController.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  // Validate and Update Profile
  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) {
      Toasty.info('Please fill all required fields correctly');
      return;
    }

    try {
      isLoading.value = true;

      dio.FormData formData = dio.FormData.fromMap({
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'date_of_birth': dateOfBirthController.text.trim(),
        'city': cityController.text.trim(),
        'address': addressController.text.trim(),
        'pincode': pincodeController.text.trim(),
        'state': stateController.text.trim(),
        'country': countryController.text.trim(),
        'gender': selectedGender.value,
      });

      if (selectedImage.value != null) {
        String fileName = selectedImage.value!.path.split('/').last;
        formData.files.add(
          MapEntry(
            'files',
            await dio.MultipartFile.fromFile(
              selectedImage.value!.path,
              filename: fileName,
            ),
          ),
        );
      }

      // Make API Request
      var response = await Repository.instance.updateProfile(formData);

      if (response.statusCode == 200) {
        Toasty.success('Profile updated successfully');

        // Handle successful response
        print('Response: ${response.data}');

        // You can navigate back or update local storage here
        // Get.back();
      } else {
        Toasty.failed(response.statusMessage ?? 'Failed to update profile');
      }
    } catch (e) {
      Toasty.success('An unexpected error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Validators
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\+?[0-9]{10,13}$').hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? validatePincode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Pincode is required';
    }
    if (!RegExp(r'^[0-9]{6}$').hasMatch(value.trim())) {
      return 'Enter a valid 6-digit pincode';
    }
    return null;
  }
}
