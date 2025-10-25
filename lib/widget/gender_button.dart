import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: Gender.values.map((gender) {
          final isSelected = controller.selectedGender.value == gender;
          return GestureDetector(
            onTap: () => controller.selectGender(gender),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey.shade400,
                  width: 1.5,
                ),
              ),
              child: Text(
                gender.name.capitalizeFirst ?? '',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}
