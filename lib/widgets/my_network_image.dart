import 'package:flutter/material.dart';
import 'package:samaj_parivaar_app/res/assets_res.dart';

class MyNetworkImage {
  static Widget networkImageCircleAvatar(double size, String url, BoxFit fit) {
    return CircleAvatar(
      radius: size,
      foregroundImage: (url.isEmpty)
          ? AssetImage(AssetsRes.NAME)
          : NetworkImage(url),
      backgroundColor: Colors.grey[200],
      onForegroundImageError: (context, stackTrace) => Container(
        width: size,
        height: size,
        color: Colors.grey[200],
        child: const Icon(Icons.broken_image, color: Colors.grey),
      ),
    );
  }

  static Widget networkImage(
    String url,
    double height,
    double width, {
    BoxFit fit = BoxFit.cover,
    double radius = 0,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: BoxFit.cover, // or BoxFit.fill / contain
        errorBuilder: (ctx, err, stack) => Container(
          height: height,
          width: width,
          color: Colors.grey[300],
          alignment: Alignment.center,
          child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
        ),
      ),
    );
  }
}
