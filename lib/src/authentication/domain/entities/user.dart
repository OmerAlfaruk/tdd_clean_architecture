import 'package:equatable/equatable.dart';

class User extends Equatable{
final String id;
final String name;
final String avatar;
final String createdAt;

  const User({required this.id, required this.name, required this.avatar, required this.createdAt});
  const User.empty():id='0',name='_empty.name',avatar='_empty.avatar',createdAt='_empty.createdAt';

  @override

  List<Object?> get props => [id];
}