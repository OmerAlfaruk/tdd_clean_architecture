import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tdd_tutorial/core/error/exception.dart';
import 'package:tdd_tutorial/core/util/constants.dart';
import 'package:tdd_tutorial/core/util/typedef.dart';

import 'package:tdd_tutorial/src/authentication/data/data_sources/authentication_remote_data_src.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';

const kCreateUserEndpoint = '/users';
const kGetUsersEndpoint = '/users';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  final http.Client _client;

  AuthRemoteDataSrcImpl(this._client);
  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
        body: jsonEncode({
          'createdAt': createdAt,
          'name': name,
          'avatar': avatar,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      // Check if the response status code is 201 (Created) or 200 (OK)
      // If not, throw an ApiException
      if (response.statusCode != 201 && response.statusCode != 200) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.parse('$kBaseUrl$kGetUsersEndpoint'),
        headers: {'Content-Type': 'application/json'},
      );
      // Check if the response status code is 200 (OK)
      // If not, throw an ApiException
      if (response.statusCode != 200) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      // Parse the response body and return a list of UserModel
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } on FormatException {
      throw ApiException(
        message: 'Invalid response format',
        statusCode: 500,
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }
}
