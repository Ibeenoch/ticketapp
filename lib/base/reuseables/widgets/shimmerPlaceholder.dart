import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPlaceholder extends StatelessWidget {
  final width;
  final height;
  final borderRadius;
  final BoxShape shape;
  const ShimmerPlaceholder(
      {super.key,
      required this.width,
      required this.height,
      this.borderRadius = 0.0,
      this.shape = BoxShape.rectangle});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: shape,
            borderRadius: shape == BoxShape.rectangle
                ? BorderRadius.circular(borderRadius)
                : null,
          ),
        ));
  }
}
