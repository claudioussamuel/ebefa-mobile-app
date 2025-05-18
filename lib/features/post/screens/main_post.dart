import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ebefa/features/post/make_post.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../const/controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/size.dart';
import '../../../utils/device/device_utility.dart';
import '../event_pricing.dart';
import 'event_date.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: postController.pageController,
            onPageChanged: postController.updatePageIndicator,
            children: const [
              MakePost(),
              DateInfo(),
              EventPricing(),
              //
              //
              //
            ],
          ),
          const OnboardingDotNavigation(),
          const OnboardingNextButton()
        ],
      ),
    );
  }
}

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = TDeviceUtils.getMode(context);
    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getStatusBarHeight(context),
      child: ElevatedButton(
        onPressed: () {
          postController.nextPage();
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: dark ? TColors.dark : TColors.primary,
        ),
        child: const Icon(
          Iconsax.direct_right,
        ),
      ),
    );
  }
}

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = TDeviceUtils.getMode(context);
    return Positioned(
      bottom: TDeviceUtils.getStatusBarHeight(context),
      left: TSizes.defaultSpace,
      child: SmoothPageIndicator(
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? TColors.dark : TColors.light,
          dotHeight: 4,
        ),
        controller: postController.pageController,
        onDotClicked: postController.dotNavigation,
        count: 3,
      ),
    );
  }
}
