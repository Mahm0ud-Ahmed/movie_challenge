// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// Project imports:
import '../../../core/utils/extension.dart';
import '../../view_model/blocs/data_bloc/api_data_bloc.dart';
import 'assistance_pagination.dart';

class SliverResponsivePaginationWidget<MODEL> extends StatelessWidget {
  final ApiDataBloc<MODEL> bloc;
  final Widget Function(BuildContext context, MODEL item, int index) itemBuilder;
  final double? percentHight;
  final double? horGab;
  final double? verGab;
  final ListType listType;
  const SliverResponsivePaginationWidget({
    super.key,
    required this.bloc,
    required this.itemBuilder,
    this.percentHight,
    this.horGab,
    this.verGab,
    this.listType = ListType.both,
  });

  @override
  Widget build(BuildContext context) {
    return switch (listType) {
      ListType.list => PagedSliverList.separated(
          separatorBuilder: (context, index) => 8.h,
          pagingController: bloc.controller!,
          builderDelegate: PagedChildBuilderDelegate<MODEL>(
            itemBuilder: itemBuilder,
            firstPageProgressIndicatorBuilder: (context) => defaultLoading(),
            newPageProgressIndicatorBuilder: (context) => defaultLoading(),
            newPageErrorIndicatorBuilder: (context) => errorDuringBrowsing(context, bloc.controller!),
            firstPageErrorIndicatorBuilder: (context) => errorDuringBrowsing(context, bloc.controller!),
            noItemsFoundIndicatorBuilder: noData,
          ),
        ),
      ListType.grid => PagedSliverGrid(
          pagingController: bloc.controller!,
          builderDelegate: PagedChildBuilderDelegate<MODEL>(
            itemBuilder: itemBuilder,
            firstPageProgressIndicatorBuilder: (context) => defaultLoading(),
            newPageProgressIndicatorBuilder: (context) => defaultLoading(),
            newPageErrorIndicatorBuilder: (context) => errorDuringBrowsing(context, bloc.controller!),
            firstPageErrorIndicatorBuilder: (context) => errorDuringBrowsing(context, bloc.controller!),
            noItemsFoundIndicatorBuilder: noData,
          ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: context.sizeSide.smallSide / 1.4,
            childAspectRatio: getRatio(
              context,
              percentHight ?? (context.orientationInfo.isPortrait ? .5 : .4),
            ),
            crossAxisSpacing: horGab ?? context.deviceWidth * .015,
            mainAxisSpacing: verGab ?? context.deviceWidth * .015,
          ),
        ),
      ListType.both => context.isMobile
          ? PagedSliverList.separated(
              separatorBuilder: (context, index) => 8.h,
              pagingController: bloc.controller!,
              builderDelegate: PagedChildBuilderDelegate<MODEL>(
                itemBuilder: itemBuilder,
                firstPageProgressIndicatorBuilder: (context) => defaultLoading(),
                newPageProgressIndicatorBuilder: (context) => defaultLoading(child: movieItemPlaceholder(context)),
                newPageErrorIndicatorBuilder: (context) => errorDuringBrowsing(context, bloc.controller!),
                firstPageErrorIndicatorBuilder: (context) => errorDuringBrowsing(context, bloc.controller!),
                noItemsFoundIndicatorBuilder: noData,
              ),
            )
          : PagedSliverGrid(
              pagingController: bloc.controller!,
              builderDelegate: PagedChildBuilderDelegate<MODEL>(
                itemBuilder: itemBuilder,
                firstPageProgressIndicatorBuilder: (context) => defaultLoading(),
                newPageProgressIndicatorBuilder: (context) => defaultLoading(child: movieItemPlaceholder(context)),
                newPageErrorIndicatorBuilder: (context) => errorDuringBrowsing(context, bloc.controller!),
                firstPageErrorIndicatorBuilder: (context) => errorDuringBrowsing(context, bloc.controller!),
                noItemsFoundIndicatorBuilder: noData,
              ),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: context.sizeSide.smallSide / 1.4,
                childAspectRatio: getRatio(
                  context,
                  percentHight ?? (context.orientationInfo.isPortrait ? .5 : .4),
                ),
                crossAxisSpacing: horGab ?? context.deviceWidth * .015,
                mainAxisSpacing: verGab ?? context.deviceWidth * .015,
              ),
            ),
    };
  }

  double getRatio(BuildContext context, double percent) {
    return context.orientationInfo.isPortrait
        ? (context.sizeSide.width / context.sizeSide.largeSide) * percent
        : (context.sizeSide.height / context.sizeSide.largeSide) * percent;
  }
}
