import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/categories/widgets/categories_screen_appbar.dart';

import '../../../../controller/for_doctor/categories/categories_ctrl.dart';
import '../../../../model/categories/categories_model.dart';
import '../../../widgets/category_card.dart';
import '../../../widgets/custom_shimmer_loading.dart';
import '../../../widgets/failed_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(NetworkCategoriesCtrl());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CategoriesScreenlAppbar(),
            Expanded(
              child: FutureBuilder<CategoriesModel?>(
                future: NetworkCategoriesCtrl
                    .find.initializeNetworkCategoriesFuture,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: size.height >= 600 ? .60 : .55,
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 5,
                        ),
                        padding: const EdgeInsets.only(
                            left: 37, right: 37, bottom: 10),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return const CustomShimmerLoading(radius: 24);
                        },
                      );
                    case ConnectionState.done:
                    default:
                      if (snapshot.hasData) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: size.height >= 600 ? .7 : .60,
                            crossAxisCount: 3,
                            crossAxisSpacing: 4,
                          ),
                          padding: const EdgeInsets.only(
                              left: 37, right: 37, bottom: 10),
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index) {
                            return FadeInDown(
                              from: 10,
                              delay: Duration(milliseconds: 50 * index),
                              child: GestureDetector(
                                onTap: () async {
                                  await NetworkCategoriesCtrl.find
                                      .addCategoryToDoctor(
                                          catId: snapshot.data!.data![index].id
                                              .toString(),
                                          context: context);
                                },
                                child: CategoryCard(
                                  image: snapshot.data!.data![index].image
                                      .toString(),
                                  title: snapshot.data!.data![index].name
                                      .toString(),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const FailedWidget();
                      }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
