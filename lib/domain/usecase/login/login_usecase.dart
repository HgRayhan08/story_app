import 'package:story_app/data/repository/auth_repository.dart';
import 'package:story_app/data/repository/shared_pref_repository.dart';
import 'package:story_app/domain/model/login_model.dart';
import 'package:story_app/domain/usecase/login/login_params.dart';
import 'package:story_app/domain/usecase/usecase.dart';

class LoginUsecase implements UseCase<LoginModel, LoginParams> {
  final SharedPrefRepository sharedPrefRepository;
  final AuthRepository authRepository;

  LoginUsecase({
    required this.sharedPrefRepository,
    required this.authRepository,
  });

  @override
  Future<LoginModel> call(LoginParams params) async {
    final auth = await authRepository.login(
        email: params.email, password: params.password);
    if (auth.error == false) {
      final pref = await sharedPrefRepository.saveLogin(
        token: auth.loginResult.token,
      );
      return auth;
    } else {
      return null!;
    }
  }
}
