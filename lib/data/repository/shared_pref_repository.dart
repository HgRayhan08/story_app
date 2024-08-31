abstract interface class SharedPrefRepository {
  Future<String?> saveLogin({required String token});
  Future<String?> getLogin();
  Future<String?> removeLogin();
}
