import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:movie_challange/src/core/utils/extension.dart';

import '../../../../../core/utils/constant.dart';
import '../../../common/text_widget.dart';

class SectionInfo extends StatelessWidget {
  final String sectionTitle;
  final Widget sectionInfo;
  const SectionInfo({super.key, required this.sectionTitle, required this.sectionInfo});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: sectionTitle,
            style: context.bodyL?.copyWith(fontWeight: FontWeight.bold, color: kTextPrimaryColor),
            padding: const EdgeInsets.only(bottom: 8),
          ),
          sectionInfo,
        ],
      ),
    );
  }
}
