import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/error/failure.dart';
import 'package:tdd_tutorial/src/authentication/domain/use_cases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domain/use_cases/get_users.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/authentication_cubit.dart';

class MockGetUsers extends Mock implements GetUsersUseCase{
}
class MockCreateUser extends Mock implements CreateUserUseCase{
}
void main(){
  late MockGetUsers mockGetUsers;
  late MockCreateUser mockCreateUser;
  late AuthenticationCubit authenticationCubit;
  const tCreateUserParams=CreateUserParams.empty();
  const tApiFailure=ApiFailure(message: 'Server Failure', statusCode: 400);
  setUp((){
    mockGetUsers = MockGetUsers();
    mockCreateUser = MockCreateUser();
    authenticationCubit = AuthenticationCubit(
      createUserUseCase: mockCreateUser,
      getUsersUseCase: mockGetUsers,
    );
    registerFallbackValue(tCreateUserParams);
  });
  tearDown(() {
    authenticationCubit.close();
  });
  test('initial state should be AuthenticationInitial', () {
    expect(authenticationCubit.state, const AuthenticationInitial());
  });

  group('CreateUser', (){
   blocTest<AuthenticationCubit,AuthenticationState>('should emit [CreatingUser,UserCreated] when successful', build:(){
      when(() => mockCreateUser.call(tCreateUserParams)).thenAnswer((_) async => const Right(null));
      return authenticationCubit;

   }
    , act: (cubit) => cubit.createUser(name: tCreateUserParams.name, avatar: tCreateUserParams.avatar, createdAt: tCreateUserParams.createdAt),
    expect: () => [
      const CreatingUserState(),
      const CreatedUserState(),
    ],
    verify: (cubit) {
      verify(() => mockCreateUser.call(tCreateUserParams)).called(1);
    },


   );

   blocTest<AuthenticationCubit,AuthenticationState>('should emit [CreatingUser,AuthenticationError]', build: (){
      when(() => mockCreateUser.call(tCreateUserParams)).thenAnswer((_) async => const Left(tApiFailure));
      return authenticationCubit;
   },
    act: (cubit) => cubit.createUser(name: tCreateUserParams.name, avatar: tCreateUserParams.avatar, createdAt: tCreateUserParams.createdAt),
    expect: () => [
      const CreatingUserState(),
      AuthenticationErrorState(message:tApiFailure.errorMessage ) ,
    ],
    verify: (cubit) {
      verify(() => mockCreateUser.call(tCreateUserParams)).called(1);
   });

  });
  group('GetUsers', (){
    blocTest<AuthenticationCubit,AuthenticationState>('should emit [GettingUsers,UserLoaded] when successful', build:(){
      when(() => mockGetUsers.call()).thenAnswer((_) async => const Right([]));
      return authenticationCubit;

    }
     , act: (cubit) => cubit.getUsers(),
     expect: () => [
       const GettingUsersState(),
       const UserLoadedState(users: []),
     ],
     verify: (cubit) {
       verify(() => mockGetUsers.call()).called(1);});});
    blocTest<AuthenticationCubit,AuthenticationState>('should emit [GettingUsers,AuthenticationError]', build: (){
      when(() => mockGetUsers.call()).thenAnswer((_) async => const Left(tApiFailure));
      return authenticationCubit;
    },
     act: (cubit) => cubit.getUsers(),
     expect: () => [
       const GettingUsersState(),
       AuthenticationErrorState(message:tApiFailure.errorMessage ) ,
     ],
     verify: (cubit) {
       verify(() => mockGetUsers.call()).called(1);
    });
}