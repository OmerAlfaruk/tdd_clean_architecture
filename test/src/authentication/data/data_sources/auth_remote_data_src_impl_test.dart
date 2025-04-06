import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/error/exception.dart';
import 'package:tdd_tutorial/src/authentication/data/data_sources/authentication_remote_data_src.dart';
import 'package:tdd_tutorial/src/authentication/data/data_sources/authentication_remote_data_src_impl.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}


void main(){
  // Declaring mock client
  late http.Client mockClient;
  // Declaring remote data source implementation
  late AuthenticationRemoteDataSource remoteDataSrcImpl;

  setUp(() {
    // Initializing mock client
    mockClient = MockClient();
    // Initializing remote data source implementation with mock client
    remoteDataSrcImpl = AuthRemoteDataSrcImpl(mockClient);
    registerFallbackValue(Uri());
  });

  // Group of tests for the "createUser" method
  group('createUser', () {
    test('should call createUser method from remote data source', () async {
      // arrange
      when(() => mockClient.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      )).thenAnswer((_) async => http.Response('User created successfully', 201));
      // act
      final methodCall = remoteDataSrcImpl.createUser;
      // assert
      await methodCall(
        createdAt: '2023-10-01',
        name: 'John Doe',
        avatar: 'https://example.com/avatar.jpg',
      );
      verify(() => mockClient.post(
        Uri.parse('https://654d2f5177200d6ba85a1b51.mockapi.io/test_api/users'),
        body: jsonEncode({
          'createdAt': '2023-10-01',
          'name': 'John Doe',
          'avatar': 'https://example.com/avatar.jpg',
        }),
        headers: {'Content-Type': 'application/json'},
      )).called(1);
    });
    test('should throw ApiException when status code is not 201 0r 200', (){
      // arrange
      when(() => mockClient.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      )).thenAnswer((_) async => http.Response('Invalid email address', 400));
      // act
      final methodCall = remoteDataSrcImpl.createUser;
      // assert
      expect(
        () async => await methodCall(
          createdAt: '2023-10-01',
          name: 'John Doe',
          avatar: 'https://example.com/avatar.jpg',
        ),
        throwsA(const ApiException(message: 'Invalid email address', statusCode: 400)),
      );
      verify(() => mockClient.post(
        Uri.parse('https://654d2f5177200d6ba85a1b51.mockapi.io/test_api/users'),
        body: jsonEncode({
          'createdAt': '2023-10-01',
          'name': 'John Doe',
          'avatar': 'https://example.com/avatar.jpg',
        }),
        headers: {'Content-Type': 'application/json'},
      )).called(1);
    });
    
  });
  const tUsers=[UserModel.empty()];
  // Group of tests for the "getUsers" method
group('getUsers', (){
  test('should call getUsers method from remote data source', () async {
    // arrange
    when(() => mockClient.get(
      any(),
      headers: any(named: 'headers'),
    )).thenAnswer((_) async => http.Response(jsonEncode([tUsers.first.toMap()]),200));
    // act
    final result= await remoteDataSrcImpl.getUsers();
    // assert

    expect(result, equals(tUsers));
    verify(() => mockClient.get(
      Uri.parse('https://654d2f5177200d6ba85a1b51.mockapi.io/test_api/users'),
      headers: {'Content-Type': 'application/json'},
    )).called(1);
  });
  test('should throw ApiException when status code is not 200', (){
    // arrange
    when(() => mockClient.get(
      any(),
      headers: any(named: 'headers'),
    )).thenAnswer((_) async => http.Response('Server error', 500));
    // act
    final methodCall = remoteDataSrcImpl.getUsers;
    // assert
    expect(
      () async => await methodCall(),
      throwsA(const ApiException(message: 'Server error', statusCode: 500)),
    );
    verify(() => mockClient.get(
      Uri.parse('https://654d2f5177200d6ba85a1b51.mockapi.io/test_api/users'),
      headers: {'Content-Type': 'application/json'},
    )).called(1);
  });

});


}