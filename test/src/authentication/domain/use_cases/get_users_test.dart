import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication.dart';
import 'package:tdd_tutorial/src/authentication/domain/use_cases/get_users.dart';

class MockAuthRepo extends Mock implements AuthenticationRepo{}
void main() {
  late MockAuthRepo mockAuthRepo;
  late GetUsersUseCase getUsersUseCase;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    getUsersUseCase = GetUsersUseCase(authenticationRepo: mockAuthRepo);
  });

  const tUserList = <User>[User.empty()];
  test('should call getUser method from repo and return List of Users', () async {
    // arrange
    when(() => mockAuthRepo.getUsers()).thenAnswer((_) async => const Right(tUserList));

    // act
    final result = await getUsersUseCase();

    // assert
    expect(result, const Right(tUserList));
    verify(() => mockAuthRepo.getUsers()).called(1);
    verifyNoMoreInteractions(mockAuthRepo);
  });
}