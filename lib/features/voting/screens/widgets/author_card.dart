import 'package:ebefa/features/voting/screens/widgets/circle_image.dart';
import 'package:ebefa/utils/constants/size.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/rounded_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/device/device_utility.dart';

class ContestantCard extends StatelessWidget {
  const ContestantCard({
    super.key,
    required this.authorName,
    required this.title,
    this.imageProvider,
  });
  final String authorName;
  final String title;
  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    final dark = !TDeviceUtils.getMode(context);
    return TRoundedContainer(
      width: double.infinity,
      shadowBorder: true,
      backgroundColor: Colors.transparent,
      borderColor: dark
          ? TColors.darkGrey
          : dark
              ? TColors.darkGrey
              : TColors.grey,
      padding: const EdgeInsets.all(TSizes.spaceBtwItems),
      child: Row(
        children: [
          Row(
            children: [
              Row(
                children: [
                  CircleImage(
                    imageProvider: imageProvider,
                    imageRadius: TSizes.imageRadius,
                  ),
                  const SizedBox(
                    width: TSizes.sm,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authorName,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
