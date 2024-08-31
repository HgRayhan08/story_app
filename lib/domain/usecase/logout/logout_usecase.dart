import 'package:story_app/data/repository/shared_pref_repository.dart';
import 'package:story_app/domain/usecase/usecase.dart';

class LogoutUsecase implements UseCase<void, void> {
  final SharedPrefRepository sharedPrefRepository;

  LogoutUsecase({required this.sharedPrefRepository});
  @override
  Future<void> call(void params) async {
    await sharedPrefRepository.removeLogin();
  }
}
