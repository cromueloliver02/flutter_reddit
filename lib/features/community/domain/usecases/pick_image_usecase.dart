import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failures/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/repositories.dart';

class PickImage implements FutureUseCase<XFile?, NoParams> {
  final ImageRepository _imageRepository;

  PickImage({
    required ImageRepository imageRepository,
  }) : _imageRepository = imageRepository;

  @override
  Future<Either<Failure, XFile?>> call(NoParams params) {
    return _imageRepository.pickImage(source: ImageSource.gallery);
  }
}
