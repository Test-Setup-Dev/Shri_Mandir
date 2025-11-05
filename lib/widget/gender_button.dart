import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/utils/helper.dart';

enum Gender { male, female, other }

class GenderController extends GetxController {
  Rx<Gender?> selectedGender = Rx<Gender?>(null);

  void selectGender(Gender gender) {
    selectedGender.value = gender;
  }
}

class GenderToggleButton extends StatelessWidget {
  final GenderController controller = Get.put(GenderController());

  GenderToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.initWithContext(context);

    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            Gender.values.map((gender) {
              final bool isSelected = controller.selectedGender.value == gender;

              return GestureDetector(
                onTap: () => controller.selectGender(gender),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  width: 20.w,
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? ThemeColors.primaryColor
                            : ThemeColors.offWhite,
                    borderRadius: BorderRadius.circular(3.w),
                    border: Border.all(
                      color:
                          isSelected
                              ? ThemeColors.primaryColor
                              : ThemeColors.greyColor,
                      width: 0.4.w,
                    ),
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: ThemeColors.primaryColor.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      gender.name.capitalizeFirst ?? '',
                      style: TextStyle(
                        color:
                            isSelected
                                ? ThemeColors.white
                                : ThemeColors.defaultTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 3.w,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      );
    });
  }
}
