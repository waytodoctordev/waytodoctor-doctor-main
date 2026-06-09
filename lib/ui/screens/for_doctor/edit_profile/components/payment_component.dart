import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/model/doctor_model/doctor_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/edit_profile/widgets/add_payment_dialog.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../../../controller/for_doctor/doctor_details/doctor_details_ctrl.dart';
import '../../../../../utils/colors.dart';

class PaymentComponent extends StatelessWidget {
  final DoctorDetailsModel? doctor;

  const PaymentComponent({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(
                  'Payment Methods'.tr,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    color: MyColors.blue14B,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const Spacer(),
            MySharedPreferences.isDoctor
                ? IconButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => const AddPaymentDialog(),
                    ),
                    icon: const Icon(
                      CupertinoIcons.add_circled_solid,
                      color: MyColors.blue14B,
                    ),
                  )
                : SizedBox(),
          ],
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 50,
          child: doctor!.data!.payments!.isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: doctor!.data!.payments!.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onLongPress: () async {
                      if (doctor!.data!.payments!.length == 1) {
                        MySharedPreferences.isDoctor
                            ? AppConstants().showMsgToast(context,
                                msg: 'One payment method at least'.tr)
                            : null;
                      } else {
                        MySharedPreferences.isDoctor
                            ? await DoctorDetailsCtrl.find.deletePaymentAndCertificateAndStudyAndPIC(
                                context: context,
                                id: doctor!.data!.payments![index].id
                                    .toString(),
                        isCertificate: false,
                        isStudy: false,
                        isPicture: false,
                        isPayment: true)
                            : null;
                      }
                    },
                    // onTap: () async => await DoctorDetailsCtrl.find
                    //     .deletePayment(
                    //         context: context,
                    //         id: doctor!.data!.payments![index].id.toString()),
                    child: Stack(
                      children: [
                        Container(
                          height: 100,
                          width: 120,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: MyColors.blue9D1),
                          child: Text(
                              doctor!.data!.payments![index].name.toString()),
                        ),
                        Container(
                          width: 120,
                          height: 50,
                          // padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                              color: MyColors.grey5d8.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(24)),
                          child: Center(
                            child: const Icon(
                              size: 20,
                              CupertinoIcons.trash,
                              color: MyColors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    'No items'.tr,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(fontSize: 14, color: MyColors.blue1dd4),
                  ),
                ),
        ),
      ],
    );
  }
}
