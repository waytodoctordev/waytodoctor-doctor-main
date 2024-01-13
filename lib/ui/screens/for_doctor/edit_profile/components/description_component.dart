import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/edit_profile/widgets/edit_description_dialog.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/icons.dart';

class DescriptionComponent extends StatelessWidget {
  final String description;

  const DescriptionComponent({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Description'.tr,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                color: MyColors.blue14B,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => const EditDescriptionDialog(),
              ),
              icon: SvgPicture.asset(
                MyIcons.edit,
                height: 14,
                width: 14,
                color: MyColors.blue14B,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          // 'طبيبة متمرسة واخصائية قلب وشرايين في مستشفى حاصلة على دورات عديدة في مجالات مختلفة ، افتخر بقيادتي اكثر من 100 عملية بنسبة نجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاحنجاح تجاوزت 98% ، لا تتردد بالتواصل معي',
          description.toString(),
          style: const TextStyle(
            fontSize: 16,
            color: MyColors.textColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
