import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/use_cases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domain/use_cases/get_users.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({required CreateUserUseCase createUserUseCase,
    required GetUsersUseCase getUsersUseCase})
      : _createUserUseCase = createUserUseCase,
        _getUsersUseCase = getUsersUseCase,
    super(const AuthenticationInitial());

  final CreateUserUseCase _createUserUseCase;
  final GetUsersUseCase _getUsersUseCase;

  Future<void> createUser({required String name,required String avatar, required String createdAt}) async {
    emit(const CreatingUserState());
    final result = await _createUserUseCase(
      CreateUserParams(name: name, avatar: avatar, createdAt: createdAt),
    );
    result.fold(
      (failure) => emit(AuthenticationErrorState(message: failure.errorMessage)),
      (user) => emit(const CreatedUserState()),
    );
  }
  Future<void> getUsers() async {
    emit(const GettingUsersState());
    final result = await _getUsersUseCase();
    result.fold(
      (failure) => emit(AuthenticationErrorState(message: failure.errorMessage)),
      (users) => emit(UserLoadedState(users: users)),
    );
  }
}
