import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../themes/dimens.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.padding, this.size});

  final EdgeInsetsGeometry? padding;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? Dimens.edgeInsetsScreenSymmetric,
      child: SizedBox.square(
        dimension: size ?? 100,
        child: SvgPicture.asset('assets/icons/logo.svg'),
      ),
    );
  }
}
