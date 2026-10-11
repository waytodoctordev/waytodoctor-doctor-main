import 'package:flutter/material.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_shimmer_loading.dart';

class DoctorLoadingItem extends StatelessWidget {
  const DoctorLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomShimmerLoading(
          radius: 50,
          width: 100,
          height: 100,
        ),
        SizedBox(height: 10),
        CustomShimmerLoading(
          radius: 8,
          width: 70,
          height: 10,
        ),
      ],
    );
  }
}