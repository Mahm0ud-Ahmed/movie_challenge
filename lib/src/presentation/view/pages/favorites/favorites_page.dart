import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_challange/src/core/config/injector.dart';
import 'package:movie_challange/src/core/utils/constant.dart';
import 'package:movie_challange/src/core/utils/extension.dart';
import 'package:movie_challange/src/core/utils/layout/responsive_layout.dart';
import 'package:movie_challange/src/core/utils/theme_manager.dart';
import 'package:movie_challange/src/data/models/movie_model.dart';
import 'package:movie_challange/src/presentation/view/common/movie_item_widget.dart';
import 'package:movie_challange/src/presentation/view/common/text_widget.dart';

import '../../../../core/config/l10n/generated/l10n.dart';
import '../../../view_model/blocs/local_bloc/local_data_bloc.dart';
import '../../../view_model/blocs/local_bloc/local_data_state.dart';
import '../movie_details/movie_details_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final LocalDataBloc localDataBloc;

  @override
  void initState() {
    super.initState();
    localDataBloc = LocalDataBloc();
    localDataBloc.getLocalData();
  }

  @override
  void dispose() {
    injector<ThemeManager>().defaultOrientationMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      titleAppBar: S.of(context).favorites_page_app_bar_title,
      builder: (context, info) {
        return BlocBuilder<LocalDataBloc, LocalDataState>(
          bloc: localDataBloc,
          builder: (context, state) {
            return state.maybeMap(
              loading: (value) => const Center(child: CircularProgressIndicator()),
              success: (value) {
                if (value.data.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(FontAwesomeIcons.clapperboard, size: kIconLargeSize, color: kTextSubColor),
                      (context.sizeSide.smallSide * .08).h,
                      TextWidget(
                        text: S.of(context).favorites_page_empty_title,
                        style: context.titleM,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async => localDataBloc.getLocalData(),
                  child: ListView.separated(
                    itemCount: value.data.length,
                    separatorBuilder: (context, index) => 16.h,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(backgroundColor: kTextSubColor),
                              onPressed: localDataBloc.clearLocalData,
                              icon: Icon(FontAwesomeIcons.solidTrashCan, color: Colors.red.shade700),
                              label: TextWidget(text: S.of(context).favorites_page_clear_btn_title),
                            ),
                            16.h,
                            MovieItemWidget(
                              movie: value.data[index],
                              onTap: () => pushMovieDetailsPage(context, value.data[index]),
                            ),
                          ],
                        );
                      }
                      return MovieItemWidget(
                        movie: value.data[index],
                        onTap: () => pushMovieDetailsPage(context, value.data[index]),
                      );
                    },
                  ),
                );
              },
              error: (value) => Center(child: TextWidget(text: value.error?.statusMessage ?? '')),
              orElse: () => const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }

  void pushMovieDetailsPage(BuildContext context, MovieModel movie) {
    context.push(MovieDetails(movie: movie)).then((value) {
      final bool result = localDataBloc.movieIsExist(movie.id).data as bool;
      if (!result) {
        localDataBloc.getLocalData();
      }
    });
  }
}
