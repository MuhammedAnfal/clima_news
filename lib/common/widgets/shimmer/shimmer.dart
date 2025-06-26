import 'package:flutter/material.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color,
  });

  final double width, height, radius;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade600,
      highlightColor: Colors.grey.shade400,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.lightBackground,
          borderRadius: BorderRadiusDirectional.circular(radius),
        ),
      ),
    );
  }
}
