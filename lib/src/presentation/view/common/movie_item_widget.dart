import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_challange/src/core/utils/constant.dart';
import 'package:movie_challange/src/core/utils/extension.dart';
import 'package:movie_challange/src/data/models/movie_model.dart';
import 'package:movie_challange/src/presentation/view/common/image_widget.dart';
import 'package:movie_challange/src/presentation/view/common/text_widget.dart';

import '../pages/movie_details/movie_details_page.dart';

class MovieItemWidget extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback? onTap;
  const MovieItemWidget({super.key, required this.movie, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kTextSubColor,
      onTap: () {
        if (onTap != null) {
          onTap!.call();
        } else {
          context.push(MovieDetails(movie: movie));
        }
      },
      child: FadeInUp(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(
              image: movie.image,
              width: 86,
              height: 86,
              imageBuilder: (context, image) => ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: image,
              ),
            ),
            (context.sizeSide.smallSide * .03).w,
            Flexible(
              child: SizedBox(
                height: 86,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: TextWidget(
                        text: movie.title,
                        lines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.titleS?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.solidStar, size: 12, color: Colors.yellow.shade700),
                          (context.sizeSide.smallSide * .01).w,
                          Flexible(
                            child: TextWidget(
                              text: movie.voteAverage.toStringAsFixed(1),
                              overflow: TextOverflow.ellipsis,
                              style: context.labelM?.copyWith(color: kTextSecondaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
