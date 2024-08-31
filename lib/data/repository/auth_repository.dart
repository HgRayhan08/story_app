import 'package:story_app/domain/model/login_model.dart';

abstract interface class AuthRepository {
  Future<String> register({
    required String name,
    required String email,
    required String password,
  });

  Future<LoginModel> login({
    required String email,
    required String password,
  });
  Future<void> logout();
}
