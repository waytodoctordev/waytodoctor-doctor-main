import 'package:flutter/material.dart';

import '../../../../../utils/colors.dart';
import '../../../../widgets/custom_shimmer_loading.dart';

class DoctorDetailsShimmer extends StatelessWidget {
  const DoctorDetailsShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(right: 37, left: 37, bottom: 100),
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Row(
                      children: [
                        const CustomShimmerLoading(
                          radius: 24,
                          height: 125,
                          width: 125,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              CustomShimmerLoading(
                                radius: 24,
                                height: 12,
                                width: 120,
                              ),
                              SizedBox(height: 8),
                              CustomShimmerLoading(
                                radius: 24,
                                height: 12,
                                width: 80,
                              ),
                              SizedBox(height: 8),
                              CustomShimmerLoading(
                                radius: 24,
                                height: 12,
                                width: 110,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: 60,
                          ),
                          VerticalDivider(color: MyColors.blue1dd4, width: 5),
                          CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: 60,
                          ),
                          VerticalDivider(color: MyColors.blue1dd4, width: 5),
                          CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: 60,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomShimmerLoading(
                      radius: 24,
                      height: 10,
                      width: 120,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: MediaQuery.of(context).size.width),
                        const SizedBox(height: 5),
                        CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: MediaQuery.of(context).size.width - 100),
                        const SizedBox(height: 5),
                        CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: MediaQuery.of(context).size.width - 201),
                        const SizedBox(height: 5),
                        CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: MediaQuery.of(context).size.width - 160),
                        const SizedBox(height: 5),
                        CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: MediaQuery.of(context).size.width - 50),
                        const SizedBox(height: 5),
                        CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: MediaQuery.of(context).size.width - 111),
                        const SizedBox(height: 5),
                        CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: MediaQuery.of(context).size.width - 200),
                        const SizedBox(height: 5),
                        CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: MediaQuery.of(context).size.width),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomShimmerLoading(
                      radius: 24,
                      height: 10,
                      width: 120,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: MediaQuery.of(context).size.width),
                        const SizedBox(height: 5),
                        CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: MediaQuery.of(context).size.width - 100),
                        const SizedBox(height: 5),
                        CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: MediaQuery.of(context).size.width - 201),
                        CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: MediaQuery.of(context).size.width),
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomShimmerLoading(
                      radius: 24,
                      height: 10,
                      width: 120,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomShimmerLoading(
                            radius: 24,
                            height: 10,
                            width: MediaQuery.of(context).size.width),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) => const CustomShimmerLoading(
                      radius: 24,
                      height: 100,
                      width: 100,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
