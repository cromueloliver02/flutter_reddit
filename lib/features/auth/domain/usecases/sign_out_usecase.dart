import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repository.dart';

class SignOut implements FutureUseCase<void, NoParams> {
  final AuthRepository _authRepository;

  SignOut({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  FutureEither<void> call(NoParams params) {
    return _authRepository.signOut();
  }
}
