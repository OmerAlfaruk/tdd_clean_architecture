import 'package:tdd_tutorial/core/usecase/usecase.dart';
import 'package:tdd_tutorial/core/util/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication.dart';

class GetUsersUseCase extends UseCaseWithoutParams<List<User>>{
  final AuthenticationRepo authenticationRepo;

  GetUsersUseCase({required this.authenticationRepo});
  @override
  ResultFuture<List<User>> call() async =>
  authenticationRepo.getUsers();


}