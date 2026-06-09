import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:way_to_doctor_doctor/binding/privcy/policies_binding.dart';

import '../../../../utils/images.dart';
import '../../../services/subscriptions/revenueCat_service.dart';
import '../../../utils/colors.dart';
import '../../../utils/icons.dart';

import '../../../utils/shared_prefrences.dart';
import '../../base/for_doctor/no_need/privcy_screen.dart';
import '../../base/for_doctor/no_need/terms_screen.dart';
import '../registration/plans/widgets/subscription_card.dart';
import 'controller/subscription_controller.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<SubscriptionScreen> {
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  List<StoreProduct> products = [];

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  getProducts() async {
    final offerings = await RevenueCatService.offerings();
    final current = offerings?.current;
    if (current == null) return;

    products =
        current.availablePackages.map((pkg) => pkg.storeProduct).toList();

    print('getttt offering ${offerings?.all}');
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            MyImages.loginImage,
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: GetBuilder<SubscriptionController>(
            builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.height * .02),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Get.height * .02,
                          vertical: 30,
                        ),
                        child: GestureDetector(
                          child: RotatedBox(
                            quarterTurns: MySharedPreferences.language == 'ar'
                                ? 3
                                : 5, // Rotate only for Arabic
                            child: SvgPicture.asset(
                              MyIcons.angleSmallRight,
                              color: MyColors.blue14B,
                            ),
                          ),
                          onTap: () => Get.back(),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * .22,
                      ),
                      Text(
                        'Subscriptions'.tr,
                        style: const TextStyle(
                          fontSize: 20,
                          color: MyColors.blue14B,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 37),
                      child: Center(
                        child: Text(
                          'Choose the subscription that suits you'.tr,
                          style: const TextStyle(
                            fontSize: 20,
                            color: MyColors.blue14B,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 20),
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(products.length, (index) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    subscriptionController.pageCtrl
                                        .jumpToPage(index);
                                    subscriptionController.currentIndex.value =
                                        index;
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 22),
                                    decoration: BoxDecoration(
                                      color: subscriptionController
                                                  .currentIndex.value !=
                                              index
                                          ? MyColors.blue9D1
                                          : MyColors.blue14B,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Text(
                                      products[index]
                                          .title
                                          .tr, //subscriptionsData[index]['name']!
                                      style: TextStyle(
                                          color: subscriptionController
                                                      .currentIndex.value !=
                                                  index
                                              ? MyColors.blue14B
                                              : MyColors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            );
                          }),
                        ),

                        /// SUBSCRIPTION BODY CONTAINER
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          child: PageView(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            scrollDirection: Axis.horizontal,
                            controller: subscriptionController.pageCtrl,
                            children: List.generate(
                              products.length,
                              (index) => SubscriptionCard(
                                subscriptionId: products[index]
                                    .identifier, // subscriptionsData[index]['id']!,
                                subscriptionName: products[index]
                                    .title, // subscriptionsData[index]  ['name']!,
                                subscriptionPrice: products[index]
                                    .price
                                    .toString(), //subscriptionsData[index] ['price']!,
                                subscriptionDescription: products[index]
                                    .description, //subscriptionsData[index] ['price']!,
                              ),
                            ),
                            onPageChanged: (index) {
                              subscriptionController.getCurrentIndex(index);
                              subscriptionController
                                  .getCurrentPrice(products[index].price);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        SizedBox(height: Get.height * .05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => Get.to(() => const PrivcyScreen(),
                                  binding: PoliciesBinding()),
                              child: Text(
                                'Privacy policy'.tr,
                                style: const TextStyle(
                                  color: MyColors.blue14B,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Get.to(() => const TermsScreen(),
                                  binding: PoliciesBinding()),
                              child: Text(
                                'Terms and Conditions'.tr,
                                style: const TextStyle(
                                  color: MyColors.blue14B,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
