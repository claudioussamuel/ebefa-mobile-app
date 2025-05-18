import 'package:ebefa/utils/constants/colors.dart';
import 'package:ebefa/utils/constants/size.dart';
import 'package:ebefa/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/rounded_container.dart';
import 'circle_image.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    super.key,
    this.imageProvider,
    required this.name,
    required this.nmtwo,
    required this.nmthree,
  });
  final ImageProvider? imageProvider;
  final String name, nmtwo, nmthree;

  @override
  Widget build(BuildContext context) {
    final dark = TDeviceUtils.getMode(context);
    return TRoundedContainer(
      width: double.infinity,
      shadowBorder: true,
      padding: const EdgeInsets.all(TSizes.md),
      backgroundColor: Colors.transparent,
      borderColor: dark
          ? Colors.black
          : dark
              ? TColors.darkGrey
              : TColors.grey,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Row(
        children: [
          CircleImage(
            imageProvider: imageProvider,
            imageRadius: 40,
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: TDeviceUtils.getScreenWidth(context) * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: TSizes.sm / 2,
                ),
                Text(
                  nmtwo,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: TSizes.sm / 2,
                ),
                Text(
                  nmthree,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
