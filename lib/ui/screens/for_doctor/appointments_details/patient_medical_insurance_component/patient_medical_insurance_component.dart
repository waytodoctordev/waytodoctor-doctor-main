import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class PatientMedicalInsuranceComponent extends StatelessWidget {
  final String userMedicalInsurance;
  final String hasInsurance;

  const PatientMedicalInsuranceComponent({
    super.key,
    required this.userMedicalInsurance,
    required this.hasInsurance,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 37, right: 37, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(
            'Medical Insurance'.tr,
            style: const TextStyle(
              color: MyColors.blue14B,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          hasInsurance != '0'
              ? CustomTextField(
                  hintText: userMedicalInsurance,
                  horizontalPadding: 20,
                  readOnly: true,
                  fillColor: MyColors.blue9D1,
                  maxLines: 2,
                )
              : Text(
                  'No items'.tr,
                  style: const TextStyle(
                    color: MyColors.blue14B,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ],
      ),
    );
  }
}
