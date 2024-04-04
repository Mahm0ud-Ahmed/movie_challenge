import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/utils/constant.dart';

class ImageWidget extends StatelessWidget {
  final dynamic image;
  final BoxFit fit;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Decoration? decoration;
  final Color? svgColor;
  final Widget Function(BuildContext context, Widget image)? imageBuilder;

  const ImageWidget({
    super.key,
    required this.image,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.decoration,
    this.svgColor,
    this.imageBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      height: height,
      margin: margin,
      decoration: decoration,
      child: imageBuilder != null ? imageBuilder!.call(context, buildImage(context)) : buildImage(context),
    );
  }

  Widget buildImage(BuildContext context) {
    switch (image.runtimeType) {
      /* case SvgGenImage:
        return _buildSvgAsset(image);
      case AssetGenImage:
        return _buildImageAsset(image); */
      case const (String):
        return _buildImageNetwork(image);
      default:
        return const SizedBox.shrink();
    }
  }

/*   SvgPicture _buildSvgAsset(SvgGenImage asset) {
    return asset.svg(
      fit: fit,
      width: width,
      height: height,
      //alignment: alignment,
    );
  }

  Image _buildImageAsset(AssetGenImage asset) {
    return asset.image(
      fit: fit,
      width: width,
      height: height,
    );
  } */

  dynamic _buildImageNetwork(String? url) {
    final urlImg = '$kBaseUrlImage$url';
    return CachedNetworkImage(
        fit: fit,
        imageUrl: urlImg,
        width: width,
        height: height,
        placeholder: (context, url) => const Icon(FontAwesomeIcons.clapperboard, color: kSecondaryColor),
        errorWidget: (context, url, error) => const Icon(FontAwesomeIcons.clapperboard, color: kSecondaryColor));
  }
}
