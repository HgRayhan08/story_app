import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:story_app/domain/usecase/login/login_usecase.dart';
import 'package:story_app/presentasi/provider/repository/auth_provider.dart';
import 'package:story_app/presentasi/provider/repository/shared_pref_provider.dart';

part 'login_user_provider.g.dart';

@riverpod
LoginUsecase loginUsecase(LoginUsecaseRef ref) => LoginUsecase(
    sharedPrefRepository: ref.watch(sharedPrefDataProvider),
    authRepository: ref.watch(authDataProvider));
