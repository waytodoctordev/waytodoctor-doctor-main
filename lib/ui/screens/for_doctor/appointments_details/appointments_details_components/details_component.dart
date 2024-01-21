import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class DetailsComponent extends StatelessWidget {
  final String caseType;
  final String communication;
  final String place;
  final String date;
  final String time;
  final String avilaiblity;
  final String paymentMethod;
  final String paymentAccount;

  const DetailsComponent({
    super.key,
    required this.caseType,
    required this.communication,
    required this.place,
    required this.date,
    required this.time,
    required this.avilaiblity,
    required this.paymentAccount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '${'Case type'.tr}: ',
                style: GoogleFonts.tajawal(
                  fontSize: 15,
                  color: MyColors.blue14B,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: caseType.tr,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: MyColors.textColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Communication : '.tr,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: MyColors.blue14B,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: communication.tr,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: MyColors.textColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Date : '.tr,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: MyColors.blue14B,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: date,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: MyColors.textColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Time : '.tr,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: MyColors.blue14B,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: DateFormat('hh:mm a')
                    .format(DateFormat('HH:mm').parse(time)),
                //  int.parse(time.toString().split(':')[0]) > 12
                //     ? "PM ${int.parse(time.split(':')[0]) - 12}:${time.split(':')[1]}"
                //     : "AM $time",
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: MyColors.textColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Appointment : '.tr,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: MyColors.blue14B,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: avilaiblity,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: avilaiblity.tr != AppConstants.canceled.tr
                      ? MyColors.textColor
                      : MyColors.red,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Payment Method :'.tr,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: MyColors.blue14B,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text:
                    paymentMethod == '' ? AppConstants.noItems : paymentMethod,
                style: GoogleFonts.tajawal(
                    fontSize: 14, color: MyColors.textColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '${'account'.tr}: ',
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: MyColors.blue14B,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: paymentAccount == ''
                    ? AppConstants.noItems
                    : paymentAccount,
                style: GoogleFonts.tajawal(
                    fontSize: 14, color: MyColors.textColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
