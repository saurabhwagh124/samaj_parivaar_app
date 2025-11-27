import 'package:flutter/material.dart';
import 'package:samaj_parivaar_app/res/assets_res.dart';

class MyNetworkImage {
  static Widget networkImage(double size, String url, BoxFit fit) {
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
}
