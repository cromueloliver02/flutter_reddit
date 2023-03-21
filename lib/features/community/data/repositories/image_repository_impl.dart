import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../../core/errors/failures/failures.dart';
import '../../../../core/typedefs.dart';
import '../../domain/repositories/image_repository.dart';
import '../datasources/datasources.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageLocalDataSource _imageLocalDataSource;

  ImageRepositoryImpl({
    required ImageLocalDataSource imageLocalDataSource,
  }) : _imageLocalDataSource = imageLocalDataSource;

  @override
  FutureEither<XFile?> pickImage() async {
    try {
      final XFile? imageFile =
          await _imageLocalDataSource.pickImage(source: ImageSource.gallery);

      return Right(imageFile);
    } on UnexpectedException catch (err) {
      return Left(UnexpectedFailure(exception: err));
    }
  }
}
