import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_appointments_details/doctor_replays_ctrl.dart';
import 'package:way_to_doctor_doctor/model/doctor_descritption_model/doctor_descritption_model.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/ui/widgets/failed_widget.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';

class DoctorReplayScreen extends StatefulWidget {
  final String appointmentID;
  const DoctorReplayScreen({
    super.key,
    required this.appointmentID,
  });

  @override
  State<DoctorReplayScreen> createState() => _DoctorReplayScreenState();
}

class _DoctorReplayScreenState extends State<DoctorReplayScreen> {
  late TextEditingController replaysCtrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(DoctorreplaysCtrl());
    DoctorreplaysCtrl.find.initFetchReplays(widget.appointmentID);
    replaysCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    replaysCtrl.dispose();
    DoctorreplaysCtrl.find.pickedFile = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'doctor\'s explanations'.tr,
        ),
      ),
      body: GetBuilder<DoctorreplaysCtrl>(
        builder: (controller) => FutureBuilder<ReplaysModel?>(
          future: controller.initializeReplaysFuture,
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
                                controller: replaysCtrl,
                                hintText: 'doctor\'s explanations'.tr,
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
                                    if (_formKey.currentState!.validate()) {
                                      controller.createReplay(
                                        context: context,
                                        file: controller.pickedFile,
                                        content: replaysCtrl.text,
                                        date: DateTime.now().toString(),
                                        appointmentId: widget.appointmentID,
                                      );
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
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
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
