import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double height;
  final double width;
  final Color? baseColor;
  final Color? highlightColor;
  final bool isRounded;
  final BorderRadius? borderRadius;

  const CustomShimmer({
    Key? key,
    required this.height,
    required this.width,
    this.baseColor,
    this.highlightColor,
    this.isRounded = false,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 36, 35, 35).withAlpha(50),
            borderRadius: borderRadius ?? BorderRadius.circular(20),
          ),
        ),
        baseColor: baseColor ?? Colors.grey.shade800,
        highlightColor:
            highlightColor ?? const Color.fromARGB(255, 247, 12, 12),
      ),
    );
  }
}
