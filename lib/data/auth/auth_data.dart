import 'dart:io';

import 'package:dio/dio.dart';
import 'package:story_app/data/repository/auth_repository.dart';
import 'package:story_app/domain/model/login_model.dart';

class AuthData implements AuthRepository {
  @override
  Future<LoginModel> login(
      {required String email, required String password}) async {
    final response = await Dio().post(
      "https://story-api.dicoding.dev/v1/login",
      data: {
        "email": email,
        "password": password,
      },
    );
    if (response.data != null) {
      return LoginModel.fromJson(response.data);
    } else {
      return throw Exception("Error get detail stories");
    }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  Future<String> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await Dio().post(
        "https://story-api.dicoding.dev/v1/register",
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: {
          "name": name,
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 201) {
        final responseData = response.data;
        if (responseData != null && responseData['error'] == false) {
          return "Register Success: ${responseData['message']}";
        } else {
          return "Register Failed: ${responseData['message'] ?? 'Unknown error'}";
        }
      } else {
        return "Register Failed: Server responded with status code ${response.statusCode}";
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return "Register Failed: ${e.response!.data['message']}";
      } else {
        return "Register Failed: ${e.message}";
      }
    } catch (e) {
      return "Register Failed: An unexpected error occurred.";
    }
  }
}
