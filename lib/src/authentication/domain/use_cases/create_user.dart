import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/core/usecase/usecase.dart';
import 'package:tdd_tutorial/core/util/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication.dart';

class CreateUserUseCase extends UseCaseWithParams<void,CreateUserParams>{

  final AuthenticationRepo authenticationRepo;

  CreateUserUseCase({required this.authenticationRepo});


  @override
  ResultVoid call(params)async=>authenticationRepo.createUser(createdAt: params.createdAt, name: params.name, avatar: params.avatar) ;

}
class CreateUserParams extends Equatable{
  final String name;
  final String avatar;
  final String createdAt;

  const CreateUserParams({required this.name, required this.avatar, required this.createdAt});
  const CreateUserParams.empty():name='_empty.name',avatar='_empty.avatar',createdAt='_empty.createdAt';
  @override
  List<Object?> get props => [name,avatar,createdAt];

}
