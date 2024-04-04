import 'package:flutter/material.dart';
import 'package:movie_challange/src/core/utils/constant.dart';
import 'package:movie_challange/src/core/utils/extension.dart';

import '../../../../../core/config/l10n/generated/l10n.dart';
import '../../../common/image_widget.dart';
import '../../../common/text_widget.dart';

class HeaderMovieDetails extends StatelessWidget {
  final String? image;
  const HeaderMovieDetails({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      snap: false,
      centerTitle: false,
      backgroundColor: kSecondaryColor,
      title: TextWidget(text: S.of(context).movie_details_page_app_bar_title),
      expandedHeight: context.isMobile ? 256 : 512,
      flexibleSpace: FlexibleSpaceBar(
        background: ImageWidget(image: image, fit: BoxFit.cover),
      ),
    );
  }
}
