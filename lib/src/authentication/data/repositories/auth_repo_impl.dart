import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/error/exception.dart';
import 'package:tdd_tutorial/core/error/failure.dart';
import 'package:tdd_tutorial/core/util/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/data_sources/authentication_remote_data_src.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepo {
  final AuthenticationRemoteDataSource remoteDataSource;

  AuthenticationRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      await remoteDataSource.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async{
    try {
      final users =await remoteDataSource.getUsers();
      return Right(users);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }

  }
}
