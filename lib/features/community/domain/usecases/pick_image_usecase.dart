import 'package:image_picker/image_picker.dart';

import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/repositories.dart';

class PickImage implements FutureUseCase<XFile?, NoParams> {
  final ImageRepository _imageRepository;

  PickImage({
    required ImageRepository imageRepository,
  }) : _imageRepository = imageRepository;

  @override
  FutureEither<XFile?> call(NoParams params) {
    return _imageRepository.pickImage(source: ImageSource.gallery);
  }
}
