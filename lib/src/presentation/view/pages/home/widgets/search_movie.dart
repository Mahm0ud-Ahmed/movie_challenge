import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_challange/src/core/utils/constant.dart';
import 'package:movie_challange/src/core/utils/extension.dart';
import 'package:movie_challange/src/presentation/view/common/generic_text_field.dart';
import 'package:movie_challange/src/presentation/view/common/movie_item_widget.dart';
import 'package:movie_challange/src/presentation/view/common/text_widget.dart';

import '../../../../../core/config/l10n/generated/l10n.dart';
import '../../../../../data/models/movie_model.dart';
import '../../../../view_model/blocs/data_bloc/api_data_bloc.dart';
import '../../../common/responsive_pagination_widget.dart';

class SearchMovieWidget extends StatefulWidget {
  final ApiDataBloc<MovieModel> searchMovieBloc;
  const SearchMovieWidget({super.key, required this.searchMovieBloc});

  @override
  State<SearchMovieWidget> createState() => _SearchMovieWidgetState();
}

class _SearchMovieWidgetState extends State<SearchMovieWidget> {
  late final TextEditingController controller;
  late final ValueNotifier<bool> isWriteNotifier;
  String? oldKey;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    isWriteNotifier = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    controller.dispose();
    isWriteNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GenericTextField(
          controller: controller,
          hintText: S.of(context).home_page_tap_bar_search_movie_hint_text_field_title,
          onChange: _onChanged,
        ),
        16.h,
        ValueListenableBuilder(
          valueListenable: isWriteNotifier,
          builder: (context, value, child) {
            return Expanded(
              child: value
                  ? ResponsivePaginationWidget(
                      bloc: widget.searchMovieBloc,
                      gapItem: 16,
                      percentHight: context.orientationInfo.isPortrait ? 6 : 8.5,
                      itemBuilder: (context, item, index, controller) {
                        return MovieItemWidget(movie: item);
                      },
                    )
                  : FittedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(FontAwesomeIcons.magnifyingGlass, size: kIconLargeSize, color: kSecondaryColor),
                          (context.sizeSide.smallSide * .08).h,
                          TextWidget(
                            text: S.of(context).home_page_tap_bar_search_movie_placeholder_msg_title,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }

  void _onChanged(String value) {
    if (oldKey != null) {
      EasyDebounce.cancel(oldKey ?? '');
    }
    oldKey = value;
    if (value.isNotEmpty) {
      EasyDebounce.debounce(oldKey ?? '', const Duration(seconds: 1), () {
        Map<String, dynamic>? queries = widget.searchMovieBloc.apiInfo?.queries;
        queries?['query'] = value;
        widget.searchMovieBloc.apiInfo?.queries = queries;
        widget.searchMovieBloc.controller?.refresh();
        
        !isWriteNotifier.value ? isWriteNotifier.value = true : null;
      });
    } else {
      oldKey = null;
      widget.searchMovieBloc.controller?.itemList?.clear();
      isWriteNotifier.value = false;
    }
  }
}
