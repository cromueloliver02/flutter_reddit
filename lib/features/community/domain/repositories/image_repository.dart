import 'package:flutter_reddit/core/typedefs.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImageRepository {
  FutureEither<XFile?> pickImage();
}
