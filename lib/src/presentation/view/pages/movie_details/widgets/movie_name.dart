import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_challange/src/core/utils/extension.dart';

import '../../../../../core/utils/constant.dart';
import '../../../../../data/models/movie_model.dart';
import '../../../../view_model/blocs/local_bloc/local_data_bloc.dart';
import '../../../../view_model/blocs/local_bloc/local_data_state.dart';
import '../../../common/text_widget.dart';

class MovieName extends StatelessWidget {
  final LocalDataBloc localDataBloc;
  final MovieModel movie;
  const MovieName({
    super.key,
    required this.localDataBloc,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextWidget(
            text: movie.title,
            style: context.bodyM?.copyWith(fontWeight: FontWeight.bold, color: kTextPrimaryColor),
          ),
        ),
        IconButton(
          onPressed: () {
            if (localDataBloc.movieIsExist(movie.id).data as bool) {
              localDataBloc.removeLocalMovie(movie.id);
            } else {
              localDataBloc.storeLocalMovie(movie);
            }
          },
          icon: BlocBuilder<LocalDataBloc, LocalDataState>(
            bloc: localDataBloc,
            builder: (context, state) {
              return state.maybeMap(
                  loading: (value) => const CircularProgressIndicator(),
                  successStoreMovie: (value) {
                    final isFavorite = value.result;
                    return Icon(isFavorite ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark);
                  },
                  removeMovie: (value) {
                    final isFavorite = value.result;
                    return Icon(isFavorite ? FontAwesomeIcons.bookmark : FontAwesomeIcons.solidBookmark);
                  },
                  orElse: () {
                    return Icon(
                      (localDataBloc.movieIsExist(movie.id).data as bool)
                          ? FontAwesomeIcons.solidBookmark
                          : FontAwesomeIcons.bookmark,
                    );
                  });
            },
          ),
        ),
      ],
    );
  }
}
