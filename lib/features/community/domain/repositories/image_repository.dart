import 'package:image_picker/image_picker.dart';

import '../../../../core/typedefs.dart';

abstract class ImageRepository {
  FutureEither<XFile?> pickImage({required ImageSource source});
}
