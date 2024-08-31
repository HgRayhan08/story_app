import 'package:story_app/data/repository/shared_pref_repository.dart';
import 'package:story_app/domain/usecase/usecase.dart';

class GetUserUsecase implements UseCase<String, void> {
  final SharedPrefRepository sharedPrefRepository;

  GetUserUsecase({required this.sharedPrefRepository});

  @override
  Future<String> call(void params) async {
    final token = await sharedPrefRepository.getLogin();
    if (token != null) {
      return token.toString();
    } else {
      return "";
    }
  }
}
