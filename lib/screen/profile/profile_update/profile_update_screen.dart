import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mandir/screen/profile/profile_update/controller.dart';
import 'package:mandir/utils/helper.dart';

class ProfileUpdateScreen extends StatelessWidget {
  const ProfileUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileUpdateController());

    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: ThemeColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ThemeColors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: ThemeColors.white,
            fontSize: 4.w,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Picture Section
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ThemeColors.primaryColor,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ThemeColors.greyColor.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child:
                                  controller.selectedImage.value != null
                                      ? Image.file(
                                        controller.selectedImage.value!,
                                        fit: BoxFit.cover,
                                      )
                                      : controller
                                          .profileImageUrl
                                          .value
                                          .isNotEmpty
                                      ? CachedNetworkImage(
                                        imageUrl:
                                            controller.profileImageUrl.value,
                                        fit: BoxFit.cover,
                                        placeholder:
                                            (context, url) =>
                                                CircularProgressIndicator(),
                                        errorWidget:
                                            (context, url, error) =>
                                                _buildDefaultAvatar(),
                                      )
                                      : _buildDefaultAvatar(),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: controller.showImagePickerOptions,
                              child: Container(
                                padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                  color: ThemeColors.primaryColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: ThemeColors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: ThemeColors.white,
                                  size: 4.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    3.h.vs,

                    // Name Field
                    _buildSectionTitle('Personal Information'),
                    2.h.vs,
                    _buildTextField(
                      controller: controller.nameController,
                      label: 'Full Name',
                      icon: Icons.person_outline,
                      validator: controller.validateName,
                    ),
                    2.h.vs,

                    // Phone Field
                    _buildTextField(
                      controller: controller.phoneController,
                      label: 'Phone Number',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: controller.validatePhone,
                    ),
                    2.h.vs,

                    // Date of Birth Field
                    GestureDetector(
                      onTap: () => controller.selectDateOfBirth(context),
                      child: AbsorbPointer(
                        child: _buildTextField(
                          controller: controller.dateOfBirthController,
                          label: 'Date of Birth',
                          icon: Icons.calendar_today_outlined,
                          validator:
                              (value) => controller.validateRequired(
                                value,
                                'Date of Birth',
                              ),
                        ),
                      ),
                    ),
                    2.h.vs,

                    // Gender Selection
                    Text(
                      'Gender',
                      style: TextStyle(
                        fontSize: 3.5.w,
                        fontWeight: FontWeight.w600,
                        color: ThemeColors.defaultTextColor,
                      ),
                    ),
                    1.h.vs,
                    Row(
                      children: [
                        Expanded(
                          child: _buildGenderOption('Male', 'male', controller),
                        ),
                        2.w.hs,
                        Expanded(
                          child: _buildGenderOption(
                            'Female',
                            'female',
                            controller,
                          ),
                        ),
                        2.w.hs,
                        Expanded(
                          child: _buildGenderOption(
                            'Other',
                            'other',
                            controller,
                          ),
                        ),
                      ],
                    ),

                    3.h.vs,
                    _buildSectionTitle('Address Information'),
                    2.h.vs,

                    // City Field
                    _buildTextField(
                      controller: controller.cityController,
                      label: 'City',
                      icon: Icons.location_city_outlined,
                      validator:
                          (value) => controller.validateRequired(value, 'City'),
                    ),
                    2.h.vs,

                    // Address Field
                    _buildTextField(
                      controller: controller.addressController,
                      label: 'Address',
                      icon: Icons.home_outlined,
                      maxLines: 3,
                      validator:
                          (value) =>
                              controller.validateRequired(value, 'Address'),
                    ),
                    2.h.vs,

                    // State and Pincode Row
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildTextField(
                            controller: controller.stateController,
                            label: 'State',
                            icon: Icons.map_outlined,
                            validator:
                                (value) =>
                                    controller.validateRequired(value, 'State'),
                          ),
                        ),
                        2.w.hs,
                        Expanded(
                          child: _buildTextField(
                            controller: controller.pincodeController,
                            label: 'Pincode',
                            icon: Icons.pin_outlined,
                            keyboardType: TextInputType.number,
                            validator: controller.validatePincode,
                          ),
                        ),
                      ],
                    ),
                    2.h.vs,

                    // Country Field
                    _buildTextField(
                      controller: controller.countryController,
                      label: 'Country',
                      icon: Icons.public_outlined,
                      validator:
                          (value) =>
                              controller.validateRequired(value, 'Country'),
                    ),

                    4.h.vs,

                    // Update Button
                    SizedBox(
                      width: double.infinity,
                      height: 6.h,
                      child: ElevatedButton(
                        onPressed:
                            controller.isLoading.value
                                ? null
                                : controller.updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.w),
                          ),
                          elevation: 3,
                        ),
                        child: Text(
                          'Update Profile',
                          style: TextStyle(
                            fontSize: 3.5.w,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.white,
                          ),
                        ),
                      ),
                    ),

                    2.h.vs,
                  ],
                ),
              ),
            ),

            // Loading Overlay
            if (controller.isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      color: ThemeColors.white,
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: ThemeColors.primaryColor,
                        ),
                        2.h.vs,
                        Text(
                          'Updating Profile...',
                          style: TextStyle(
                            fontSize: 3.5.w,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: ThemeColors.primaryColor.withOpacity(0.1),
      child: Icon(Icons.person, size: 15.w, color: ThemeColors.primaryColor),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 4.w,
        fontWeight: FontWeight.bold,
        color: ThemeColors.defaultTextColor,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: TextStyle(fontSize: 3.2.w, color: ThemeColors.defaultTextColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 3.w, color: ThemeColors.greyColor),
        prefixIcon: Icon(icon, color: ThemeColors.primaryColor, size: 5.w),
        filled: true,
        fillColor: ThemeColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.w),
          borderSide: BorderSide(color: ThemeColors.greyColor.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.w),
          borderSide: BorderSide(color: ThemeColors.greyColor.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.w),
          borderSide: BorderSide(color: ThemeColors.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.w),
          borderSide: BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: maxLines > 1 ? 2.h : 0,
        ),
      ),
    );
  }

  Widget _buildGenderOption(
    String label,
    String value,
      ProfileUpdateController controller,
  ) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.selectedGender.value = value,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          decoration: BoxDecoration(
            color:
                controller.selectedGender.value == value
                    ? ThemeColors.primaryColor
                    : ThemeColors.white,
            borderRadius: BorderRadius.circular(2.w),
            border: Border.all(
              color:
                  controller.selectedGender.value == value
                      ? ThemeColors.primaryColor
                      : ThemeColors.greyColor.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 3.w,
                fontWeight: FontWeight.w500,
                color:
                    controller.selectedGender.value == value
                        ? ThemeColors.white
                        : ThemeColors.defaultTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
