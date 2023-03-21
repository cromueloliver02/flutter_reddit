import 'package:image_picker/image_picker.dart';

abstract class ImageLocalDataSource {
  Future<XFile?> pickImage({required ImageSource source});
}

class ImageLocalDataSourceImpl implements ImageLocalDataSource {
  final ImagePicker _imagePicker;

  const ImageLocalDataSourceImpl({
    required ImagePicker imagePicker,
  }) : _imagePicker = imagePicker;

  @override
  Future<XFile?> pickImage({required ImageSource source}) async {
    final XFile? imageFile = await _imagePicker.pickImage(source: source);

    return imageFile;
  }
}
