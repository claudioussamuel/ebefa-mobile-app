import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../const/controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/size.dart';
import '../../../../utils/constants/text_string.dart';
import '../../../../utils/device/device_utility.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: onboardingController.pageController,
            onPageChanged: onboardingController.updatePageIndicator,
            children: const [
              OnboardingPage(
                image: TImage.patient,
                title: TText.introTitle1,
                subTitle: TText.introSubTitle1,
              ),
              OnboardingPage(
                image: TImage.heart,
                title: TText.introTitle2,
                subTitle: TText.introSubTitle2,
              ),
              OnboardingPage(
                image: TImage.doc,
                title: TText.introTitle3,
                subTitle: TText.introSubTitle3,
              ),
            ],
          ),
          const OnboardingSkip(),
          const OnboardingDotNavigation(),
          const OnboardingNextButton()
        ],
      ),
    );
  }
}

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getStatusBarHeight(context),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: () {
          onboardingController.skipPage();
        },
        child: const Text("Skip"),
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
          onboardingController.nextPage();
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: dark ? TColors.dark : TColors.primary,
        ),
        child: const Icon(
          Iconsax.arrow_right_3,
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
        controller: onboardingController.pageController,
        onDotClicked: onboardingController.dotNavigation,
        count: 3,
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });
  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            width: TDeviceUtils.getScreenWidth(context) * 0.8,
            height: TDeviceUtils.getScreenHeight(context) * 0.6,
            image: AssetImage(image),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
