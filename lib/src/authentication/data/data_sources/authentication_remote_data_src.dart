import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  /// Creates a new user in the remote data source.
  ///
  /// Throws a [ServerException] if the creation fails.
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });


  Future<List<UserModel>> getUsers();
}