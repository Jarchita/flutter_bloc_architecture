import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../exports/resources.dart';
import '../../exports/widgets.dart';


/// Purpose : custom network image class
class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    required this.url,
    this.fit = BoxFit.cover,
    this.displayLoader = false,
    this.displayPlaceholder = true,
    Key? key,
  }) : super(key: key);

  final String? url;
  final BoxFit fit;
  final bool displayLoader;
  final bool displayPlaceholder;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: url ?? "",
        fit: fit,
        placeholder: (context, url) =>
            displayLoader ? CustomLoader.small() : Container(),
        errorWidget: (context, url, error) {
          // ignore: avoid_print
          print(url);
          print(error);
          return displayPlaceholder
              ? const Center(
                  child: Icon(
                    Icons.image_outlined,
                    color: AppColors.disabled,
                    size: 20,
                  ),
                )
              : Container();
        },
      );
}

Widget imagePlaceholder() => const Icon(
      Icons.image_outlined,
      color: AppColors.disabled,
    );
