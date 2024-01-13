import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_appointments_details/doctor_appointments_details_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class PymentMethodDialogBox extends StatefulWidget {
  final String appointmentId;
  final String patiendId;
  const PymentMethodDialogBox(
      {Key? key, required this.appointmentId, required this.patiendId})
      : super(key: key);

  @override
  State<PymentMethodDialogBox> createState() => _PymentMethodDialogBoxState();
}

class _PymentMethodDialogBoxState extends State<PymentMethodDialogBox> {
  TextEditingController paymentCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // Get.put(ClinincAppointmentsDetailsCtrl());
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
              Text('Please specify the account number'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.blue14B,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: '',
                controller: paymentCtrl,
                horizontalPadding: 20,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "".tr;
                  }
                  if (value.length < 2) {
                    return "".tr;
                  }
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
                            // AppConstants().showMsgToast(context,
                            //     msg: MySharedPreferences.language == 'ar'
                            //         ? 'من فضلك قم بتحديد رقم الحساب'
                            //         : 'Please specify the account number');
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
                              await DoctorAppointmentsDetailsCtrl.find
                                  .updatePaymentMethod(
                                appointmentId: widget.appointmentId.toString(),
                                paymentAccount: paymentCtrl.text,
                                context: context,
                              )
                                  .whenComplete(() async {
                                Get.back();
                              });
                            } else {}
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
