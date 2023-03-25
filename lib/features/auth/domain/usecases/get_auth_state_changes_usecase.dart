import '../../../../core/entities/entities.dart';
import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/repositories.dart';

class GetAuthStateChanges implements StreamUseCase<User?, NoParams> {
  final AuthRepository _authRepository;

  const GetAuthStateChanges({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  StreamEither<User?> call(NoParams params) {
    return _authRepository.authStateChanges;
  }
}
