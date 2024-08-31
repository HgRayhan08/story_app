import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:story_app/domain/usecase/get_user/get_user_usecase.dart';
import 'package:story_app/presentasi/provider/repository/shared_pref_provider.dart';

part 'get_user_provider.g.dart';

@riverpod
GetUserUsecase getUserUsecase(GetUserUsecaseRef ref) =>
    GetUserUsecase(sharedPrefRepository: ref.watch(sharedPrefDataProvider));
