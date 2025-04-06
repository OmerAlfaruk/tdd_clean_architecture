import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/use_cases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domain/use_cases/get_users.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required CreateUserUseCase createUserUseCase,
      required GetUsersUseCase getUsersUseCase})
      : _createUserUseCase = createUserUseCase,
        _getUsersUseCase = getUsersUseCase,
        super(const AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }
  final CreateUserUseCase _createUserUseCase;
  final GetUsersUseCase _getUsersUseCase;
  FutureOr<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthenticationState> emit) async{
    emit(const CreatingUserState());

     final result= await _createUserUseCase(
     CreateUserParams(name: event.name, avatar: event.avatar, createdAt: event.createdAt)
      );
      emit(const CreatedUserState());
      result.fold(
        (failure) => emit(AuthenticationErrorState(message: failure.errorMessage)),
        (user) => emit(const CreatedUserState()),
      );
  }

  FutureOr<void> _getUsersHandler (
      GetUsersEvent event, Emitter<AuthenticationState> emit) async{
    emit(const GettingUsersState());
    final result = await _getUsersUseCase();
    result.fold(
      (failure) => emit(AuthenticationErrorState(message: failure.errorMessage)),
      (users) => emit(UserLoadedState(users: users)),
    );

  }
}
