import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_challange/src/core/utils/extension.dart';

import '../../../../../core/utils/constant.dart';
import '../../../common/text_widget.dart';

class InfoWithIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String info;
  const InfoWithIcon({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Row(
        children: [
          Icon(icon, size: 12, color: iconColor),
          (context.sizeSide.smallSide * .01).w,
          Flexible(
            child: TextWidget(
              lines: 1,

              text: info,
              style: context.labelM?.copyWith(color: kTextSecondaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
