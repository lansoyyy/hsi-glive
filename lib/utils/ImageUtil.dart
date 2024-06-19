import 'package:image_picker/image_picker.dart';

class ImageUtil {
  static Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    final img =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
    if (img != null) {
      return img;
    }
    return null;
  }

  static Future<XFile?> capture() async {
    final ImagePicker picker = ImagePicker();
    final img =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 30);
    if (img != null) {
      return img;
    }
    return null;
  }
}
