import 'package:tdd_tutorial/core/util/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRepo{
ResultVoid createUser({required String createdAt,
  required String name,
  required String avatar,
});

ResultFuture<List<User>> getUsers();
}