import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class PatientPersonalInformationComponent extends StatelessWidget {
  final String fullName;
  final String userNationalId;
  final String userGender;
  final String userDateOfBirth;
  final String userMaritalStatus;
  // final String userSmoking;

  const PatientPersonalInformationComponent({
    super.key,
    required this.fullName,
    required this.userNationalId,
    required this.userGender,
    required this.userDateOfBirth,
    required this.userMaritalStatus,
    // required this.userSmoking,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.only(left: 37, right: 37, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(
            'Full Name'.tr,
            style: const TextStyle(
              color: MyColors.blue14B,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            hintText: fullName,
            horizontalPadding: 20,
            readOnly: true,
            fillColor: MyColors.blue9D1,
          ),
          const SizedBox(height: 10),
          Text(
            'ID Number'.tr,
            style: const TextStyle(
              color: MyColors.blue14B,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            hintText: userNationalId,
            horizontalPadding: 20,
            readOnly: true,
            fillColor: MyColors.blue9D1,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gender'.tr,
                      style: const TextStyle(
                        color: MyColors.blue14B,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      hintText: userGender.capitalize.toString().tr,
                      horizontalPadding: 20,
                      readOnly: true,
                      fillColor: MyColors.blue9D1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date of birth'.tr,
                      style: const TextStyle(
                        color: MyColors.blue14B,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      hintText: userDateOfBirth,
                      horizontalPadding: 20,
                      readOnly: true,
                      fillColor: MyColors.blue9D1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Marital status'.tr,
                      style: const TextStyle(
                        color: MyColors.blue14B,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      hintText: userMaritalStatus.tr,
                      horizontalPadding: 20,
                      readOnly: true,
                      fillColor: MyColors.blue9D1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ],
      ),
    );
  }
}
