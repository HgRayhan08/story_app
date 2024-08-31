import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:story_app/data/auth/auth_data.dart';

part 'auth_provider.g.dart';

@riverpod
AuthData authData(AuthDataRef ref) => AuthData();
