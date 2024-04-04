import 'package:flutter/material.dart';
import 'package:movie_challange/src/core/utils/extension.dart';

import '../../../common/text_widget.dart';

class TapBarItem extends StatelessWidget {
  final String title;
  const TapBarItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: TextWidget(
        text: title,
        style: context.isMobile
            ? context.labelM?.copyWith(fontWeight: FontWeight.w700, height: (context.sizeSide.smallSide * .12) * .075)
            : context.bodyM?.copyWith(
                fontWeight: FontWeight.w500,
                height: (context.sizeSide.smallSide * .12) * (context.orientationInfo.isPortrait ? .038 : .026)),
        textAlign: TextAlign.center,
      ),
    );
  }
}
