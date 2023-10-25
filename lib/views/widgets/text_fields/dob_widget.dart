import 'package:flutter/material.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_validators.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:ionicons/ionicons.dart';

class DobWidget extends StatelessWidget {
  const DobWidget({
    super.key,
    required this.dobController,
  });

  final TextEditingController dobController;

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      labelText: "DATE OF BIRTH",
      controller: dobController,
      validator: AppValidators.notEmpty,
      hintText: 'Select your birth date',
      readOnly: true,
      prefixIcon: IconButton(
        icon: const Icon(
          Ionicons.calendar_outline,
          color: AppColors.darkGrey,
        ),
        onPressed: () {
          // show date picker
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          ).then((value) {
            if (value != null) {
              // set date to controller
              dobController.text = value.toIso8601String();
            }
          });
        },
      ),
    );
  }
}