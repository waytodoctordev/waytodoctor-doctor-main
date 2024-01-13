import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/ratings/widgets/rating_card.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/ratings/widgets/rating_screen_appbar.dart';

import '../../../../controller/for_doctor/ratings/get_ratings_ctrl.dart';
import '../../../../model/get_ratings/rating_model.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/colors.dart';
import '../../../widgets/custom_shimmer_loading.dart';
import '../../../widgets/loading_indicator.dart';

class DoctorRatingScreen extends StatefulWidget {
  final String doctorId;

  const DoctorRatingScreen({
    Key? key,
    required this.doctorId,
  }) : super(key: key);

  @override
  State<DoctorRatingScreen> createState() => _DoctorRatingScreenState();
}

class _DoctorRatingScreenState extends State<DoctorRatingScreen> {
  @override
  void initState() {
    GetDoctorRatingsCtrl.find.doctorId = widget.doctorId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const RtingScreenlAppbar(),
          Expanded(
            child: PagedListView<int, RatingsDataModel>.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 37),
              separatorBuilder: (context, index) => const SizedBox(height: 50),
              pagingController: GetDoctorRatingsCtrl.find.pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                noItemsFoundIndicatorBuilder: (context) {
                  return Center(
                    child: Text(
                      AppConstants.noItems,
                      style: const TextStyle(color: MyColors.blue14B),
                    ),
                  );
                },
                firstPageProgressIndicatorBuilder: (context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 50),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return const CustomShimmerLoading(
                            radius: 24, height: 150);
                      },
                    ),
                  );
                },
                newPageProgressIndicatorBuilder: (context) {
                  return const LoadingIndicator();
                },
                itemBuilder: (context, item, index) {
                  return RatingCard(
                    ratingData: item,
                  );
                },
              ),
            ),
          ),
          // Expanded(
          //   child: FutureBuilder<RatingsModel?>(
          //     future: GetDoctorRatingsCtrl.find.initializeRatingsFuture,
          //     builder: (context, snapshot) {
          //       switch (snapshot.connectionState) {
          //         case ConnectionState.waiting:
          //           return ListView.separated(
          //             separatorBuilder: (context, index) => const SizedBox(height: 50),
          //             physics: const NeverScrollableScrollPhysics(),
          //             padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 37),
          //             itemCount: 7,
          //             itemBuilder: (BuildContext context, int index) {
          //               return const CustomShimmerLoading(radius: 24, height: 150);
          //             },
          //           );
          //         case ConnectionState.done:
          //         default:
          //           if (snapshot.data!.data!.isEmpty) {
          //             return Center(
          //               child: Text(
          //                 AppConstants.noItems,
          //                 style: const TextStyle(color: MyColors.blue14B),
          //               ),
          //             );
          //           }
          //           if (snapshot.hasData) {
          //             return ListView.separated(
          //               separatorBuilder: (context, index) => const SizedBox(
          //                 height: 50
          //               ),
          //               physics: const BouncingScrollPhysics(),
          //               padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 37),
          //               itemCount: snapshot.data!.data!.length,
          //               itemBuilder: (BuildContext context, int index) {
          //                 return RatingCard(
          //                   ratingData: snapshot.data!.data![index],
          //                 );
          //               },
          //             );
          //           } else {
          //             return const FailedWidget();
          //           }
          //       }
          //     },
          //   ),
          // )
        ],
      )),
    );
  }
}
