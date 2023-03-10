import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class LoginWithGoogle implements FutureUseCase<User?, NoParams> {
  final AuthRepository _authRepository;

  const LoginWithGoogle({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  FutureEither<User?> call(NoParams params) {
    return _authRepository.signInWithGoogle();
  }
}
