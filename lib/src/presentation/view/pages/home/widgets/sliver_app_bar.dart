import 'package:flutter/material.dart';
import 'package:movie_challange/src/core/utils/constant.dart';
import 'package:movie_challange/src/core/utils/extension.dart';
import 'package:movie_challange/src/presentation/view/pages/home/widgets/tap_bar_item.dart';

import '../../../../../core/config/l10n/generated/l10n.dart';

class SliverAppBarWidget extends StatelessWidget {
  final TabController tabController;

  const SliverAppBarWidget({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: true,
      expandedHeight: kAppBarHeight,
      backgroundColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(
          kAppBarHeight / 2,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(context.sizeSide.smallSide),
            ),
            child: TabBar(
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              overlayColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
              padding: EdgeInsets.all(context.sizeSide.smallSide * 0.02),
              indicator: BoxDecoration(
                color: kTextSubColor,
                borderRadius: BorderRadius.circular(context.sizeSide.smallSide),
              ),
              dividerColor: Colors.transparent,
              tabs: [
                TapBarItem(title: S.of(context).home_page_tap_bar_now_playing_title),
                TapBarItem(title: S.of(context).home_page_tap_bar_top_rated_title),
                TapBarItem(title: S.of(context).home_page_tap_bar_search_movie_title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
