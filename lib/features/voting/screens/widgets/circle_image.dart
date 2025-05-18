import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    this.imageRadius = 20,
    this.imageProvider,
  });

  final double imageRadius;
  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(
        context,
      ).bottomSheetTheme.backgroundColor,
      radius: imageRadius,
      child: CircleAvatar(
        radius: imageRadius - 5,
        backgroundImage: imageProvider,
      ),
    );
  }
}
