import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:story_app/domain/usecase/logout/logout_usecase.dart';
import 'package:story_app/presentasi/provider/repository/shared_pref_provider.dart';

part 'logout_provider.g.dart';

@riverpod
LogoutUsecase logoutUsecase(LogoutUsecaseRef ref) =>
    LogoutUsecase(sharedPrefRepository: ref.watch(sharedPrefDataProvider));
