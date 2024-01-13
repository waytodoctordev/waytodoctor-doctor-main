import 'package:flutter/material.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_shimmer_loading.dart';

class BaseVerticalListLoading extends StatelessWidget {
  const BaseVerticalListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(12, (index) {
        return Container(
          margin: index == 0 ? const EdgeInsets.only(bottom: 15.0) : const EdgeInsets.symmetric(vertical: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: const Color(0xFFFAF5E6).withOpacity(0.20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          child: Row(
            children: [
              const CustomShimmerLoading(
                radius: 17,
                width: 80,
                height: 80,
                margin: EdgeInsetsDirectional.only(end: 10),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomShimmerLoading(
                      radius: 17,
                      height: 10,
                      width: 130,
                      margin: EdgeInsetsDirectional.only(bottom: 10),
                    ),
                    CustomShimmerLoading(
                      radius: 17,
                      height: 10,
                      width: 200,
                      margin: EdgeInsetsDirectional.only(bottom: 15),
                    ),
                    CustomShimmerLoading(
                      radius: 17,
                      height: 10,
                      width: double.infinity,
                      margin: EdgeInsetsDirectional.only(end: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
