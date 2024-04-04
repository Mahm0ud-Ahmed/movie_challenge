import 'package:flutter/material.dart';
import 'package:movie_challange/src/core/utils/extension.dart';

import '../../../../../core/utils/constant.dart';
import '../../../common/text_widget.dart';

class GenreItem extends StatelessWidget {
  final String genre;
  const GenreItem({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(context.sizeSide.smallSide),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: TextWidget(
          text: genre,
          style: context.labelM?.copyWith(color: kTextPrimaryColor),
        ),
      ),
    );
  }
}
