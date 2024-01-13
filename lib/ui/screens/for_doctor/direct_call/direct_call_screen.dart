import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/direct_call/widgets/confirm_accept_call.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/direct_call/widgets/confirm_cancel_call.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/direct_call/widgets/confirm_start_call.dart';

import '../../../../controller/direct_call_ctrl.dart';
import '../../../../model/call_model.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/icons.dart';
import '../../../widgets/custom_network_image.dart';
import '../../../widgets/loading_indicator.dart';

class DirectCallScreen extends StatefulWidget {
  const DirectCallScreen({super.key});

  @override
  State<DirectCallScreen> createState() => _DirectCallScreenState();
}

class _DirectCallScreenState extends State<DirectCallScreen> {
  @override
  void initState() {
    Get.put(DirectCallCtrl());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Direct Call'.tr),
      ),
      body: SafeArea(child: GetBuilder<DirectCallCtrl>(
        builder: (controller) {
          return StreamBuilder(
            stream: controller.getMyDirectCalls(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const LoadingIndicator();
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingIndicator();
              }

              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(AppConstants.noItems),
                );
              }
              return SizedBox(
                // height: 160,
                child: ListView.separated(
                  itemCount: snapshot.data!.docs.length,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  // scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final call = snapshot.data!.docs[index].data();

                    return Container(
                      // height: 120,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        color: MyColors.grey7f8,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              CustomNetworkImage(
                                url: call.patientImage,
                                radius: 24,
                                width: 80,
                                height: 80,
                              ),
                              call.callStatus.toString() ==
                                          AppConstants.finished ||
                                      call.callStatus.toString() ==
                                          AppConstants.finished.tr
                                  ? Container(
                                      width: 80,
                                      height: 80,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade800
                                              .withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      child: Text(
                                        AppConstants.finished.tr,
                                        style: const TextStyle(
                                          color: MyColors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              call.callStatus.toString() ==
                                          AppConstants.canceled ||
                                      call.callStatus.toString() ==
                                          AppConstants.canceled.tr
                                  ? Container(
                                      width: 80,
                                      height: 80,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade800
                                              .withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      child: Text(
                                        AppConstants.canceled.tr,
                                        style: const TextStyle(
                                          color: MyColors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  call.patientName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: MyColors.blue14B,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                // const SizedBox(height: 5),
                                // Text(
                                //   call.callStatus.tr,
                                //   style: const TextStyle(
                                //     fontSize: 14,
                                //     color: MyColors.blue14B,
                                //   ),
                                // ),
                                const SizedBox(height: 5),
                                Text(
                                  DateFormat('dd/MM/yyyy h:mm a')
                                      .format(call.createdAt.toDate()),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: MyColors.grey5d8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          _toggleIcon(call.callStatus, call),
                          const SizedBox(width: 10),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      )),
    );
  }

  Widget _toggleIcon(String currentStatus, CallModel callModel) {
    if (currentStatus == AppConstants.approved) {
      return InkWell(
        onTap: () async {
          showDialog(
            context: context,
            builder: (context) => ConfirmStartCallDialog(callModel: callModel),
          );
        },
        child: SvgPicture.asset(
          MyIcons.call,
          width: 16,
          color: MyColors.blue14B,
        ),
      );
    } else if (currentStatus == AppConstants.binding) {
      return Row(
        children: [
          InkWell(
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return ConfirmAcceptCallDialog(
                      patientId: callModel.patientId);
                },
              );
            },
            child: SvgPicture.asset(
              MyIcons.call,
              width: 16,
              color: MyColors.blue14B,
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) =>
                    ConfirmCancelcallDialog(patientId: callModel.patientId),
              );
            },
            child: SvgPicture.asset(
              MyIcons.trash,
              width: 16,
              color: MyColors.blue14B,
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
