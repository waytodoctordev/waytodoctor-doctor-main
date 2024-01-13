import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../../../controller/for_doctor/doctor_details/doctor_details_ctrl.dart';

class EditDescriptionDialog extends StatefulWidget {
  const EditDescriptionDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<EditDescriptionDialog> createState() => _EditDescriptionDialogState();
}

class _EditDescriptionDialogState extends State<EditDescriptionDialog> {
  TextEditingController descriptionCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Description'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.blue14B,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: MySharedPreferences.description.toString(),
                controller: descriptionCtrl,
                horizontalPadding: 20,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "".tr;
                  }
                  // if (value.isEmpty) {
                  //   return "".tr;
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          title: 'Cancel'.tr,
                          textColor: MyColors.blue14B,
                          onPressed: () {
                            Get.back();
                          },
                          color: MyColors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomElevatedButton(
                          title: 'Approve'.tr,
                          textColor: MyColors.white,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await DoctorDetailsCtrl.find
                                  .updateDoctorDescription(
                                      description: descriptionCtrl.text,
                                      context: context)
                                  .whenComplete(() => Get.back());
                            }
                          },
                          color: MyColors.blue14B,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
