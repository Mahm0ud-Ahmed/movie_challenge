import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_challange/src/presentation/view/pages/movie_details/widgets/genre_item.dart';

import '../../../../../core/config/l10n/generated/l10n.dart';
import '../../../../../data/models/movie_model.dart';
import '../../../../view_model/blocs/data_bloc/api_data_bloc.dart';
import '../../../../view_model/blocs/data_bloc/api_data_state.dart';
import '../../../common/app_fade_shimmer.dart';
import 'section_info.dart';

class MovieGenres extends StatelessWidget {
  final List<Map<String, dynamic>>? genres;
  final ApiDataBloc<MovieModel> movieDetailsBloc;
  const MovieGenres({super.key, required this.genres, required this.movieDetailsBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiDataBloc<MovieModel>, ApiDataState<MovieModel>>(
      bloc: movieDetailsBloc,
      builder: (context, state) {
        return state.maybeMap(
          loading: (value) {
            return Wrap(
              spacing: 12,
              runSpacing: 8,
              children: List.generate(
                3,
                (index) => const AppFadeShimmer(
                  width: 100,
                  height: 24,
                  radius: 24,
                ),
              ),
            );
          },
          success: (value) {
            return SectionInfo(
              sectionTitle: S.of(context).movie_details_page_genres_section_title,
              sectionInfo: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: value.data!.genres!.map((genre) => GenreItem(genre: genre['name'])).toList(),
              ),
            );
          },
          orElse: () {
            if (genres == null || genres!.isEmpty) {
              return const SizedBox.shrink();
            }
            return SectionInfo(
              sectionTitle: S.of(context).movie_details_page_genres_section_title,
              sectionInfo: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: genres!.map((genre) => GenreItem(genre: genre['name'])).toList(),
              ),
            );
          },
        );
      },
    );
  }
}
