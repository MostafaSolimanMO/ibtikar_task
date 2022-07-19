import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ibtikar_task/shared/assets/assets.gen.dart';
import 'package:ibtikar_task/shared/network/api_endpoints.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.radius = 12,
  }) : super(key: key);
  final String imageUrl;

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double radius;

  @override
  Widget build(BuildContext context) {
    String url = EndPoints.imageBaseUrl + imageUrl;
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.contain,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          margin: margin ?? const EdgeInsets.all(2),
          width: width ?? double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image(
              image: imageProvider,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          height: height,
          color: const Color(0xFFF8F8F8),
          width: width ?? double.infinity,
          padding: padding ?? const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: const Center(
              child: Icon(
                Icons.refresh,
              ),
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return Container(
          height: height,
          width: width ?? double.infinity,
          padding: padding ?? const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.white,
            direction: ShimmerDirection.ttb,
            child: Assets.icons.imageIcon.svg(
              height: height,
              width: width ?? double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
