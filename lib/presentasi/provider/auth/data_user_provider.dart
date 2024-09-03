import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:story_app/domain/model/login_model.dart';
import 'package:story_app/domain/usecase/get_user/get_user_usecase.dart';
import 'package:story_app/domain/usecase/login/login_params.dart';
import 'package:story_app/domain/usecase/login/login_usecase.dart';
import 'package:story_app/domain/usecase/registrasi/registrasi_params.dart';
import 'package:story_app/domain/usecase/registrasi/registrasi_usecase.dart';
import 'package:story_app/presentasi/provider/usecase/get_user_provider.dart';
import 'package:story_app/presentasi/provider/usecase/login_user_provider.dart';
import 'package:story_app/presentasi/provider/usecase/logout_provider.dart';
import 'package:story_app/presentasi/provider/usecase/register_provider.dart';

part 'data_user_provider.g.dart';

@Riverpod(keepAlive: true)
class DataUser extends _$DataUser {
  @override
  Future<String?> build() async {
    GetUserUsecase user = ref.read(getUserUsecaseProvider);
    String token = await user(null);
    if (token.isNotEmpty) {
      return token;
    } else {
      return null;
    }
  }

  Future<LoginModel> loginUser({
    required String email,
    required String password,
  }) async {
    LoginUsecase login = ref.read(loginUsecaseProvider);
    var result = await login(LoginParams(email: email, password: password));
    if (result.error != true) {
      state = AsyncData(result.story!.token);
      return result;
    } else {
      throw Exception("Error login ");
    }
  }

  Future<bool> registrasi(
      {required String email,
      required String password,
      required String name}) async {
    RegistrasiUsecase register = ref.read(registrasiUsecaseProvider);
    var result = await register(
      RegistasiParams(email: email, password: password, name: name),
    );
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    var logout = ref.read(logoutUsecaseProvider);
    await logout(null);
    state = const AsyncData(null);
  }
}
