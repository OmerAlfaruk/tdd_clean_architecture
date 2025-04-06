import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/error/exception.dart';
import 'package:tdd_tutorial/core/error/failure.dart';
import 'package:tdd_tutorial/src/authentication/data/data_sources/authentication_remote_data_src.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/src/authentication/data/repositories/auth_repo_impl.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/use_cases/create_user.dart';
// Mock class for AuthenticationRemoteDataSource
class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  // Declaring mock remote data source
  late MockAuthRemoteDataSrc mockAuthRemoteDataSrc;
  // Declaring repository implementation
  late AuthenticationRepositoryImpl repositoryImpl;

  setUp(() {
    // Initializing mock remote data source
    mockAuthRemoteDataSrc = MockAuthRemoteDataSrc();
    // Initializing repository implementation with mock remote data source
    repositoryImpl = AuthenticationRepositoryImpl(
      remoteDataSource: mockAuthRemoteDataSrc,
    );
  });

  // Group of tests for the "createUser" method
  // - Should call the remote data source
  // - Check if the method returns the proper data
  // - Check if the method throws an exception and returns a failure
  const tCreateUserParams = CreateUserParams.empty();
  // Defining a constant exception for testing
  const tException = ApiException(message: 'Server error', statusCode: 500);

  group('createUser', () {
    test('should call createUser method from remote data source', () async {
      // arrange
      // Mocking the createUser method to return a Future
      when(() => mockAuthRemoteDataSrc.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      )).thenAnswer((_) async => Future.value());
      // act
      // Calling the createUser method on the repository
      final result = await repositoryImpl.createUser(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      );
      // assert
      // Verifying the result is a Right with null value
      expect(result, equals(const Right(null)));
      // Verifying the createUser method was called once
      verify(() => mockAuthRemoteDataSrc.createUser(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      )).called(1);
      // Verifying no more interactions with the mock
      verifyNoMoreInteractions(mockAuthRemoteDataSrc);
    });

    test('should return a failure when remote data source throws an exception', () async {
      // arrange
      // Mocking the createUser method to throw an exception
      when(() => mockAuthRemoteDataSrc.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      )).thenThrow(tException);
      // act
      // Calling the createUser method on the repository
      final result = await repositoryImpl.createUser(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      );
      // assert
      // Verifying the result is a Left with ApiFailure
      expect(result, equals(const Left(ApiFailure(message: 'Server error', statusCode: 500))));
      // Verifying the createUser method was called once
      verify(() => mockAuthRemoteDataSrc.createUser(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      )).called(1);
      // Verifying no more interactions with the mock
      verifyNoMoreInteractions(mockAuthRemoteDataSrc);
    });
  });

  // Group of tests for the "getUsers" method
  // - Should call the remote data source
  // - Check if the method returns the proper data
  // - Check if the method throws an exception and returns a failure
  const tUserModel = UserModel.empty();

  group('getUsers', () {
    test('should call getUsers method from remote data source and return [users]', () async {
      // arrange
      // Mocking the getUsers method to return an empty list
      when(() => mockAuthRemoteDataSrc.getUsers()).thenAnswer((_) async => []);
      // act
      // Calling the getUsers method on the repository
      final result = await repositoryImpl.getUsers();
      // assert
      // Verifying the result is a Right with an empty list
      expect(result, isA<Right<Failure, List<User>>>());
      // Verifying the getUsers method was called once
      verify(() => mockAuthRemoteDataSrc.getUsers()).called(1);
      // Verifying no more interactions with the mock
      verifyNoMoreInteractions(mockAuthRemoteDataSrc);
    });

    test('should return a failure when remote data source throws an exception', () async {
      // arrange
      // Mocking the getUsers method to throw an exception
      when(() => mockAuthRemoteDataSrc.getUsers()).thenThrow(tException);
      // act
      // Calling the getUsers method on the repository
      final result = await repositoryImpl.getUsers();
      // assert
      // Verifying the result is a Left with ApiFailure
      expect(result, equals(Left(ApiFailure(message: 'Server error', statusCode: 500))));
      // Verifying the getUsers method was called once
      verify(() => mockAuthRemoteDataSrc.getUsers()).called(1);
      // Verifying no more interactions with the mock
      verifyNoMoreInteractions(mockAuthRemoteDataSrc);
    });
  });
}