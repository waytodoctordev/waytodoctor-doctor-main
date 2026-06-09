import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_appointments_details/doctor_description_ctrl.dart';
import 'package:way_to_doctor_doctor/model/doctor_descritption_model/doctor_descritption_model.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/ui/widgets/failed_widget.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class DoctorDescriptionScreen extends StatefulWidget {
  final String appointmentID;
  const DoctorDescriptionScreen({
    super.key,
    required this.appointmentID,
  });

  @override
  State<DoctorDescriptionScreen> createState() =>
      _DoctorDescriptionScreenState();
}

class _DoctorDescriptionScreenState extends State<DoctorDescriptionScreen> {
  late TextEditingController descriptionCtrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(DoctorDescriptionCtrl());
    DoctorDescriptionCtrl.find.initFetchDescriptions(widget.appointmentID);
    descriptionCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    descriptionCtrl.dispose();
    DoctorDescriptionCtrl.find.pickedFile = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'prescription'.tr,
        ),
      ),
      body: GetBuilder<DoctorDescriptionCtrl>(
        builder: (controller) => FutureBuilder<ReplaysModel?>(
          future: controller.initializeDescriptionFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const LoadingIndicator();
              case ConnectionState.done:
              default:
                if (snapshot.hasData) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // container add
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 37, vertical: 10),
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.bottomCenter,
                            children: [
                              CustomTextField(
                                textInputAction: TextInputAction.next,
                                controller: descriptionCtrl,
                                hintText: 'prescription'.tr,
                                horizontalPadding: 20,
                                maxLines: 8,
                                fillColor: MyColors.blue9D1,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  }
                                  if (value.length < 4) {
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                              Positioned(
                                bottom: -25,
                                child: CustomElevatedButton(
                                  title: 'Add'.tr,
                                  height: 40,
                                  width: 100,
                                  onPressed: () {
                                    if (controller.pickedFile != null &&
                                        _formKey.currentState!.validate()) {
                                      controller.createDescription(
                                        context: context,
                                        file: controller.pickedFile!,
                                        content: descriptionCtrl.text,
                                        date: DateTime.now().toString(),
                                        appointmentId: widget.appointmentID,
                                      );
                                    } else {
                                      if (controller.pickedFile == null) {
                                        AppConstants().showMsgToast(context,
                                            msg: 'You must attach a file'.tr);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 37,
                            left: 37,
                            top: 20,
                          ),
                          child: GestureDetector(
                            onTap: () => controller.getFile(context),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: MyColors.blue14B,
                                  radius: 12,
                                  child: SvgPicture.asset(
                                    MyIcons.clip,
                                    height: 10,
                                    width: 10,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'attached files'.tr,
                                  style: const TextStyle(
                                    color: MyColors.blue14B,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        controller.pickedFile == null
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 37, vertical: 5),
                                child: Text(
                                  controller.pickedFile!.path.split('/').last,
                                  style: const TextStyle(
                                    color: MyColors.blue14B,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 37, left: 37, top: 5, bottom: 10),
                          child: GestureDetector(
                            onTap: () => controller.getFile(context),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    MySharedPreferences.language == 'ar'
                                        ? 'يجب ارفاق صورة عن النسخة الاصلية للوصفة الطبية موقعة ومختومة بالختم الرسمي للطبيب'
                                        : "A copy of the original copy of the medical prescription must be attached, signed and stamped with the doctor's official seal",
                                    style: const TextStyle(
                                      color: MyColors.blue14B,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 37, vertical: 20),
                            itemCount: snapshot.data!.data!.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    // height: 50,
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: MyColors.fillColor,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Text(
                                      snapshot.data!.data![index].content!,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(
                                      snapshot.data!.data![index].date
                                          .toString()
                                          .split(' ')[0],
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: MyColors.textColor),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return const FailedWidget();
                }
            }
          },
        ),
      ),
    );
  }
}
