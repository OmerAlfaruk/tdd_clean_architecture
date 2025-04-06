import 'dart:convert';

import 'package:tdd_tutorial/core/util/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.name,
    required super.avatar,
    required super.createdAt, required super.id,
  });

UserModel.fromMap(DataMap map) :this(
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      createdAt: map['createdAt'] as String, id: map['id'] as String,
    );

  factory UserModel.fromJson(String source) => UserModel.fromMap(jsonDecode(source) as DataMap);
  const UserModel.empty() : super(
    id: '_empty.id',
    name: '_empty.name',
    avatar: '_empty.avatar',
    createdAt: '_empty.createdAt',
  );
  UserModel copyWith({
    String? id,
    String? name,
    String? avatar,
    String? createdAt,
  }) =>UserModel(
          id: id ?? this.id,
          name: name ?? this.name,
          avatar: avatar ?? this.avatar,
          createdAt: createdAt ?? this.createdAt,
        );

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'createdAt': createdAt,
    };

  }
  String toJson() =>jsonEncode(toMap());
}