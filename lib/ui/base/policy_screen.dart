import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/policy/policy_ctrl.dart';
import 'package:way_to_doctor_doctor/model/pages_model.dart';
import 'package:way_to_doctor_doctor/ui/widgets/failed_widget.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: MySharedPreferences.language == 'ar'
              ? RotationTransition(
                  turns: const AlwaysStoppedAnimation(270 / 360),
                  child: SvgPicture.asset(
                    MyIcons.angleSmallRight,
                    height: 7,
                    width: 7,
                    color: MyColors.blue14B,
                  ),
                )
              : RotationTransition(
                  turns: const AlwaysStoppedAnimation(90 / 360),
                  child: SvgPicture.asset(
                    MyIcons.angleSmallRight,
                    height: 7,
                    width: 7,
                    color: MyColors.blue14B,
                  ),
                ),
        ),
        leadingWidth: 80,
        title: Text(
          'Return policy'.tr,
        ),
      ),
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // appbar
            Expanded(
              child: FutureBuilder<PageModel?>(
                  future: PolicyCtrl.find.initializePageFuture,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const LoadingIndicator();
                      case ConnectionState.done:
                      default:
                        if (snapshot.hasData) {
                          return ListView(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            padding: const EdgeInsets.symmetric(horizontal: 37),
                            children: [
                              Text(
                                snapshot.data!.data!.title!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: MyColors.blue14B,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                snapshot.data!.data!.content!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  // fontWeight: FontWeight.w800,
                                  color: MyColors.textColor,
                                ),
                              )
                            ],
                          );
                        } else {
                          return const FailedWidget();
                        }
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
