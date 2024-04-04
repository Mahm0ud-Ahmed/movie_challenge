import 'package:flutter/material.dart';
import 'package:movie_challange/src/core/config/injector.dart';
import 'package:movie_challange/src/core/utils/api_info.dart';
import 'package:movie_challange/src/core/utils/enums.dart';
import 'package:movie_challange/src/core/utils/layout/responsive_layout.dart';
import 'package:movie_challange/src/core/utils/theme_manager.dart';
import 'package:movie_challange/src/presentation/view_model/blocs/data_bloc/api_data_bloc.dart';

import '../../../../data/models/movie_model.dart';
import 'widgets/body_movie_details.dart';
import 'widgets/header_movie_details.dart';

class MovieDetails extends StatefulWidget {
  final MovieModel movie;
  const MovieDetails({super.key, required this.movie});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late final ApiDataBloc<MovieModel> movieDetailsBloc;

  @override
  void initState() {
    super.initState();
    injector<ThemeManager>().setPortraitMode();
    movieDetailsBloc = ApiDataBloc<MovieModel>();
    if (widget.movie.genres == null || widget.movie.genres!.isEmpty) {
      movieDetailsBloc.getGeneralData(info: ApiInfo(endpoint: '${ApiRoute.movieDetails.route}${widget.movie.id}'));
    }
  }

  @override
  void dispose() {
    injector<ThemeManager>().defaultOrientationMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      showAppBar: false,
      isPadding: false,
      builder: (context, info) {
        return CustomScrollView(
          slivers: [
            HeaderMovieDetails(image: widget.movie.image),
            BodyMovieDetails(movie: widget.movie, movieDetailsBloc: movieDetailsBloc)
          ],
        );
      },
    );
  }
}
