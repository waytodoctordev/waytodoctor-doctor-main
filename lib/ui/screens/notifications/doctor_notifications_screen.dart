import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:way_to_doctor_doctor/controller/notifications/doctor_notifications_ctrl.dart';
import 'package:way_to_doctor_doctor/model/notifications/notifications_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/notifications/widgets/notification_card.dart';
import 'package:way_to_doctor_doctor/ui/screens/notifications/widgets/notifications_appbar.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/ui/widgets/vertical_loading.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => NotificationsScreenState();
}

class NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    Get.put(DoctorNotificationsCtrl());
    DoctorNotificationsCtrl.find.pagingController =
        PagingController(firstPageKey: 1)
          ..addPageRequestListener((pageKey) {
            DoctorNotificationsCtrl.find.fetchPage(pageKey);
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: RefreshIndicator(
        displacement: 60,
        onRefresh: () async {
          DoctorNotificationsCtrl.find.pagingController.refresh();
        },
        child: Column(
          children: [
            const NotificationsAppbar(),
            Expanded(
              child: PagedListView<int, NotificationsData>.separated(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 37),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                pagingController: DoctorNotificationsCtrl.find.pagingController,
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
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return const BaseVerticalListLoading();
                        },
                      ),
                    );
                  },
                  newPageProgressIndicatorBuilder: (context) {
                    return const LoadingIndicator();
                  },
                  itemBuilder: (context, item, index) {
                    return NotificationCard(
                      content: item.content.toString(),
                      date: item.createdAt.toString(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
