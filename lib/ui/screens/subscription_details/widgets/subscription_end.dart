import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/icons.dart';

class SubscriptionEnd extends StatelessWidget {
  const SubscriptionEnd({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 37),
                child: Center(
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                        color: MyColors.grey7f8,
                        borderRadius: BorderRadius.circular(26)),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: -60,
                                child: CircleAvatar(
                                    radius: 70,
                                    backgroundColor: MyColors.white,
                                    child: SvgPicture.asset(
                                      MyIcons.appointmentDone,
                                      height: 100,
                                      width: 100,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Subscription completed successfully'.tr,
                          style: const TextStyle(
                            color: MyColors.blue14B,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
