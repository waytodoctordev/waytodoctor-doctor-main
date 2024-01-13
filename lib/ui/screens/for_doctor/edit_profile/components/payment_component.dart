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
                  MySharedPreferences.language == 'ar'
                      ? 'طرق الدفع'
                      : 'Payment Methods',
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
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => const AddPaymentDialog(),
              ),
              icon: const Icon(
                CupertinoIcons.add_circled_solid,
                color: MyColors.blue14B,
              ),
            ),
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
                        if (MySharedPreferences.language == 'ar') {
                          AppConstants().showMsgToast(context,
                              msg: 'يجب أن يوجد طريقة دفع واحدة على الأقل');
                        } else {
                          AppConstants().showMsgToast(context,
                              msg: 'One payment method at least');
                        }
                      } else {
                        await DoctorDetailsCtrl.find.deletePayment(
                            context: context,
                            id: doctor!.data!.payments![index].id.toString());
                      }
                    },
                    // onTap: () async => await DoctorDetailsCtrl.find
                    //     .deletePayment(
                    //         context: context,
                    //         id: doctor!.data!.payments![index].id.toString()),
                    child: Stack(
                      children: [
                        Container(
                          // height: 100,
                          // width: 100,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: MyColors.blue9D1),
                          child: Text(
                              doctor!.data!.payments![index].name.toString()),
                        ),
                        // Container(
                        //   width: 100,
                        //   height: 100,
                        //   padding: const EdgeInsets.all(40),
                        //   decoration: BoxDecoration(
                        //       color: MyColors.grey5d8.withOpacity(0.4),
                        //       borderRadius: BorderRadius.circular(24)),
                        //   child: const Icon(
                        //     CupertinoIcons.trash,
                        //     color: MyColors.red,
                        //   ),
                        // )
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
