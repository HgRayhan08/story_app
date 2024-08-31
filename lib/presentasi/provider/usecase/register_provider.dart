import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:story_app/domain/usecase/registrasi/registrasi_usecase.dart';
import 'package:story_app/presentasi/provider/repository/auth_provider.dart';

part 'register_provider.g.dart';

@riverpod
RegistrasiUsecase registrasiUsecase(RegistrasiUsecaseRef ref) =>
    RegistrasiUsecase(authData: ref.watch(authDataProvider));
