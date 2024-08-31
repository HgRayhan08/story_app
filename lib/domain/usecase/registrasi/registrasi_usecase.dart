import 'package:story_app/data/auth/auth_data.dart';
import 'package:story_app/domain/usecase/registrasi/registrasi_params.dart';
import 'package:story_app/domain/usecase/usecase.dart';

class RegistrasiUsecase implements UseCase<String, RegistasiParams> {
  final AuthData authData;

  RegistrasiUsecase({required this.authData});

  @override
  Future<String> call(RegistasiParams params) async {
    print("di usecase");
    final register = await authData.register(
        name: params.name, email: params.email, password: params.password);
    print("setelah use case");
    print(register);
    if (register.isNotEmpty) {
      return "Succses Register";
    } else {
      return "failed register";
    }
  }
}
