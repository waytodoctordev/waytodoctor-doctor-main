import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class FinishedCustomDialogBox extends StatefulWidget {
  const FinishedCustomDialogBox({
    Key? key,
  }) : super(key: key);

  @override
  State<FinishedCustomDialogBox> createState() => _FinishedCustomDialogBoxState();
}

class _FinishedCustomDialogBoxState extends State<FinishedCustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Alert'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: MyColors.blue14B,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "You cannot access the patient's file after the appointment".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: MyColors.blue14B,
                // fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              width: 100,
              child: Center(
                child: CustomElevatedButton(
                  title: 'Ok'.tr,
                  textColor: MyColors.white,
                  onPressed: () {
                    Get.back();
                  },
                  color: MyColors.blue14B,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
