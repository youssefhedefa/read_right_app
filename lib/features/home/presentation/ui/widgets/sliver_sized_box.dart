import 'package:flutter/material.dart';

class CustomSliverSizedBox extends StatelessWidget {
  const CustomSliverSizedBox({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
        width: width,
      ),
    );
  }
}
