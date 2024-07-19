// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtil {
  static Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
    if (img != null) {
      return img;
    }
    return null;
  }

  static Future<XFile?> capture() async {
    final ImagePicker picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.camera, imageQuality: 30);
    if (img != null) {
      return img;
    }
    return null;
  }

  static Future options(BuildContext context) async {
    Completer completer = Completer();
    showDialog(
      context: context,
      barrierDismissible: false, // Dialog can be dismissed by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose an option"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text("Camera"),
                  onTap: () async {
                    XFile? img = await ImageUtil.capture();
                    if (img != null) {
                      completer.complete(img);
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.browse_gallery),
                  title: const Text("Gallery"),
                  onTap: () async {
                    XFile? img = await ImageUtil.getImage();
                    if (img != null) {
                      completer.complete(img);
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: const Text("Cancel"),
                  onTap: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    return completer.future;
  }

  static Future optionsWithRemove(BuildContext context, Function onRemove) async {
    Completer completer = Completer();
    showDialog(
      context: context,
      barrierDismissible: false, // Dialog can be dismissed by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose an option"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text("Camera"),
                  onTap: () async {
                    XFile? img = await ImageUtil.capture();
                    if (img != null) {
                      completer.complete(img);
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.browse_gallery),
                  title: const Text("Gallery"),
                  onTap: () async {
                    XFile? img = await ImageUtil.getImage();
                    if (img != null) {
                      completer.complete(img);
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.clear),
                  title: const Text("Remove"),
                  onTap: () async {
                    Navigator.pop(context);
                    onRemove();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: const Text("Cancel"),
                  onTap: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    return completer.future;
  }
}
