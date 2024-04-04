import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_challange/src/core/utils/extension.dart';
import 'package:movie_challange/src/presentation/view/pages/movie_details/widgets/info_with_icon.dart';
import 'package:movie_challange/src/presentation/view/pages/movie_details/widgets/movie_name.dart';

import '../../../../../core/utils/constant.dart';
import '../../../../../data/models/movie_model.dart';
import '../../../../view_model/blocs/data_bloc/api_data_bloc.dart';
import '../../../../view_model/blocs/data_bloc/api_data_state.dart';
import '../../../../view_model/blocs/local_bloc/local_data_bloc.dart';
import '../../../common/app_fade_shimmer.dart';

class MovieInfo extends StatefulWidget {
  final MovieModel movie;
  final ApiDataBloc<MovieModel> bloc;
  const MovieInfo({super.key, required this.movie, required this.bloc});

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  late final LocalDataBloc localDataBloc;

  late MovieModel movie;

  @override
  void initState() {
    super.initState();
    localDataBloc = LocalDataBloc();
    movie = widget.movie;
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Column(
        children: [
          MovieName(localDataBloc: localDataBloc, movie: movie),
          
          (context.sizeSide.smallSide * .02).h,
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 16,
              children: [
                InfoWithIcon(
                  icon: FontAwesomeIcons.solidStar,
                  iconColor: Colors.yellow.shade700,
                  info: '${movie.voteAverage.toStringAsFixed(1)} / ${movie.voteCount}',
                ),
                InfoWithIcon(icon: FontAwesomeIcons.calendar, iconColor: kTextSecondaryColor, info: movie.releaseDate),
                BlocBuilder<ApiDataBloc<MovieModel>, ApiDataState<MovieModel>>(
                  bloc: widget.bloc,
                  builder: (context, state) {
                    return state.maybeMap(
                      loading: (value) => const AppFadeShimmer(
                        width: 100,
                        height: 24,
                        radius: 24,
                      ),
                      success: (value) {
                        movie = value.data!;
                        return InfoWithIcon(
                          icon: FontAwesomeIcons.clock,
                          iconColor: kTextSubColor,
                          info: formatDuration(value.data!.runtime!),
                        );
                      },
                      orElse: () {
                        if (movie.runtime != null) {
                          return InfoWithIcon(
                            icon: FontAwesomeIcons.clock,
                            iconColor: kTextSubColor,
                            info: formatDuration(movie.runtime!),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatDuration(int durationInMinutes) {
    int hours = durationInMinutes ~/ 60; // Get the integer part of hours
    int minutes = durationInMinutes % 60; // Get the remaining minutes

    return '${hours}h ${minutes}min';
  }
}
