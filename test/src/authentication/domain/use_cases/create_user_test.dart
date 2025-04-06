import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication.dart';
import 'package:tdd_tutorial/src/authentication/domain/use_cases/create_user.dart';

class MockAuthRepo extends Mock implements AuthenticationRepo{}


void main() {
  late MockAuthRepo mockAuthRepo;
  late CreateUserUseCase createUserUseCase;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    createUserUseCase = CreateUserUseCase(authenticationRepo: mockAuthRepo);
  });


const tCreateUserParams =  CreateUserParams.empty();
  test('should call createUser method from repo', () async {
    // arrange
    when(() => mockAuthRepo.createUser(createdAt: any(named: 'createdAt'),
      name: any(named: 'name'),
      avatar: any(named: 'avatar'),

    )).thenAnswer((_) async => const Right(null));

    // act
    final result = await createUserUseCase(
      tCreateUserParams,
    );

    // assert
    expect(result, const Right(null));
    verify(() => mockAuthRepo.createUser(
      createdAt: tCreateUserParams.createdAt,
      name: tCreateUserParams.name,
      avatar:tCreateUserParams.avatar,
    )).called(1);
    verifyNoMoreInteractions(mockAuthRepo);
  });
}