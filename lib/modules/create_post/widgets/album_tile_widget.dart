import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumTile extends StatelessWidget {
  final AssetPathEntity album;
  final CreatePostController controller;

  const AlbumTile(this.album, this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    log("ALBUM $album");
    return FutureBuilder<AssetEntity?>(
      future: album.getAssetListRange(start: 0, end: 1).then((value) => value.firstOrNull),
      builder: (context, snapshot) {
        final asset = snapshot.data;
        return GestureDetector(
          onTap: () {
            log("${album.name} items");
            controller.onloadAlbumPhotos(album);
          },
          child: GridTile(
            header: GridTileBar(
              title: Text(album.name),
              subtitle: FutureBuilder<int?>(
                  future: album.assetCountAsync,
                  builder: (context, snapshot) {
                    return Text('${snapshot.data} items');
                  }),
            ),
            child: asset != null ? AssetThumbnail(asset: asset) : Container(color: Colors.grey),
          ),
        );
      },
    );
  }
}

class AssetThumbnail extends StatelessWidget {
  final AssetEntity asset;

  const AssetThumbnail({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: asset.thumbnailData,
      builder: (context, snapshot) {
        final bytes = snapshot.data;
        if (bytes == null) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          return Image.memory(bytes, fit: BoxFit.cover);
        }
      },
    );
  }
}
