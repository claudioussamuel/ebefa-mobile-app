import 'package:ebefa/utils/constants/colors.dart';
import 'package:ebefa/utils/constants/size.dart';
import 'package:flutter/material.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.shadowBorder = true,
    this.radius = TSizes.defaultSpace,
    this.backgroundColor = TColors.white,
    this.borderColor = TColors.borderPrimary,
  });
  final Widget? child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool shadowBorder;
  final double radius;
  final Color backgroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: shadowBorder
            ? Border.all(
                color: borderColor,
              )
            : null,
      ),
      child: child,
    );
  }
}
