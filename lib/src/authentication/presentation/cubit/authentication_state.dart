part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();

}

class CreatingUserState extends AuthenticationState {
  const CreatingUserState();
}
class GettingUsersState extends AuthenticationState {
  const GettingUsersState();
}

class CreatedUserState extends AuthenticationState {
  const CreatedUserState();
}
class UserLoadedState extends AuthenticationState {
  const UserLoadedState({required this.users});
  final List<User> users;
  @override
  List<Object> get props => users.map((users)=>users.id).toList();
}
class AuthenticationErrorState extends AuthenticationState {
  const AuthenticationErrorState({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

