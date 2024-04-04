import 'package:flutter/material.dart';
import 'package:movie_challange/src/core/utils/api_info.dart';
import 'package:movie_challange/src/core/utils/layout/responsive_layout.dart';
import 'package:movie_challange/src/presentation/view_model/blocs/data_bloc/api_data_bloc.dart';

import '../../../../core/config/l10n/generated/l10n.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/enums.dart';
import '../../../../data/models/movie_model.dart';
import 'widgets/sliver_app_bar.dart';
import 'widgets/sliver_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late final ApiDataBloc<MovieModel> nowPlayingBloc;
  late final ApiDataBloc<MovieModel> topRatedBloc;
  late final ApiDataBloc<MovieModel> searchMovieBloc;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: kTapBarLength, vsync: this);
    nowPlayingBloc = ApiDataBloc<MovieModel>(apiInfo: ApiInfo(endpoint: ApiRoute.nowPlaying.route));
    topRatedBloc = ApiDataBloc<MovieModel>(apiInfo: ApiInfo(endpoint: ApiRoute.topRated.route));
    searchMovieBloc = ApiDataBloc<MovieModel>(apiInfo: ApiInfo(endpoint: ApiRoute.searchMovie.route));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      titleAppBar: S.of(context).app_name,
      showAppBarActions: true,
      builder: (context, info) {
        return DefaultTabController(
          length: kTapBarLength,
          animationDuration: Duration.zero,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBarWidget(tabController: tabController),
              ];
            },
            body: SliverBodyWidget(
              tabController: tabController,
              info: info,
              nowPlayingBloc: nowPlayingBloc,
              topRatedBloc: topRatedBloc,
              searchMovieBloc: searchMovieBloc,
            ),
          ),
        );
      },
    );
  }
}
