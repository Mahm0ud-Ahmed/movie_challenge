import 'package:flutter/material.dart';
import 'package:movie_challange/src/core/utils/extension.dart';
import 'package:movie_challange/src/presentation/view/pages/movie_details/widgets/movie_genres.dart';
import 'package:movie_challange/src/presentation/view/pages/movie_details/widgets/section_info.dart';

import '../../../../../core/config/l10n/generated/l10n.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../data/models/movie_model.dart';
import '../../../../view_model/blocs/data_bloc/api_data_bloc.dart';
import '../../../common/custom_padding.dart';
import '../../../common/text_widget.dart';
import 'movie_info.dart';

class BodyMovieDetails extends StatelessWidget {
  final MovieModel movie;
  final ApiDataBloc<MovieModel> movieDetailsBloc;
  const BodyMovieDetails({super.key, required this.movie, required this.movieDetailsBloc});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: kMainColor,
        ),
        child: CustomPadding(
          top: context.sizeSide.width * (context.orientationInfo.isPortrait ? 0.03 : 0.01),
          start: context.sizeSide.width * 0.03,
          end: context.sizeSide.width * 0.03,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieInfo(movie: movie, bloc: movieDetailsBloc),
                (context.sizeSide.smallSide * .04).h,
                SectionInfo(
                  sectionTitle: S.of(context).movie_details_page_description_section_title,
                  sectionInfo: TextWidget(
                    text: movie.overview,
                    style: context.labelM?.copyWith(color: kTextSecondaryColor, height: 1.8, fontWeight: FontWeight.normal),
                  ),
                ),
                (context.sizeSide.smallSide * .04).h,
                MovieGenres(
                  genres: movie.genres,
                  movieDetailsBloc: movieDetailsBloc,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
