import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/user/user_repository.dart';
import 'package:fe_lab_clinicas_self_service/src/services/user_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;

  UserLoginServiceImpl({
    required this.userRepository,
  });

  @override
  Future<Either<ServiceException, Unit>> execute(
    String email,
    String password,
  ) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Left(value: AuthError()):
        return Left(ServiceException(message: 'Erro ao realizar login'));

      case Left(value: AuthUnauthorizedException()):
        return Left(ServiceException(message: 'Login ou senha inválidos'));

      case Right(value: final accessToken):
        final sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString(LocalStoragesConstants.accessToken, accessToken);
        return Right(unit);
    }
  }
}
