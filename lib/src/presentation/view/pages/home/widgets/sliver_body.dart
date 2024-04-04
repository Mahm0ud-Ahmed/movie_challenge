// Flutter imports:
import 'package:flutter/material.dart';
import 'package:movie_challange/src/core/utils/extension.dart';
import '../../../../../core/utils/layout/information_page.dart';
import '../../../../../data/models/movie_model.dart';
import '../../../../view_model/blocs/data_bloc/api_data_bloc.dart';
import '../../../common/movie_item_widget.dart';
import '../../../common/sliver_responsive_pagination_widget.dart';
import 'search_movie.dart';

class SliverBodyWidget extends StatelessWidget {
  final TabController tabController;
  final InformationPage info;
  final ApiDataBloc<MovieModel> nowPlayingBloc;
  final ApiDataBloc<MovieModel> topRatedBloc;
  final ApiDataBloc<MovieModel> searchMovieBloc;

  const SliverBodyWidget({
    super.key,
    required this.tabController,
    required this.info,
    required this.nowPlayingBloc,
    required this.topRatedBloc,
    required this.searchMovieBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TabBarView(
        controller: tabController,
        children: [
          RefreshIndicator(
            onRefresh: () async => nowPlayingBloc.controller?.refresh(),
            child: CustomScrollView(
              slivers: [
                SliverResponsivePaginationWidget(
                  bloc: nowPlayingBloc,
                  percentHight: context.orientationInfo.isPortrait ? 6 : 8.5,
                  itemBuilder: (context, item, index) => MovieItemWidget(movie: item),
                )
              ],
            ),
          ),
          RefreshIndicator(
            onRefresh: () async => topRatedBloc.controller?.refresh(),
            child: CustomScrollView(
              slivers: [
                SliverResponsivePaginationWidget(
                  bloc: topRatedBloc,
                  percentHight: context.orientationInfo.isPortrait ? 6 : 8.5,
                  itemBuilder: (context, item, index) => MovieItemWidget(movie: item),
                )
              ],
            ),
          ),
          SearchMovieWidget(searchMovieBloc: searchMovieBloc),
        ],
      ),
    );
  }
}
