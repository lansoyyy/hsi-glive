import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtil {
  static Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    final img = await picker.pickMedia(imageQuality: 30);
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
          title: Text("Choose an option"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camera"),
                  onTap: () async {
                    XFile? img = await ImageUtil.capture();
                    if (img != null) {
                      completer.complete(img);
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.browse_gallery),
                  title: Text("Gallery"),
                  onTap: () async {
                    XFile? img = await ImageUtil.getImage();
                    if (img != null) {
                      completer.complete(img);
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.cancel),
                  title: Text("Cancel"),
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
          title: Text("Choose an option"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camera"),
                  onTap: () async {
                    XFile? img = await ImageUtil.capture();
                    if (img != null) {
                      completer.complete(img);
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.browse_gallery),
                  title: Text("Gallery"),
                  onTap: () async {
                    XFile? img = await ImageUtil.getImage();
                    if (img != null) {
                      completer.complete(img);
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.clear),
                  title: Text("Remove"),
                  onTap: () async {
                    Navigator.pop(context);
                    onRemove();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.cancel),
                  title: Text("Cancel"),
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
