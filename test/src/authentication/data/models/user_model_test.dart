import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_tutorial/core/util/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

void main() {
  const userModel = UserModel.empty();

  group('UserModel', () {
    test('should be a subclass of User entity', () {
      expect(userModel, isA<User>());
    });

    group('fromMap and fromJson', () {
      test('fromMap should return a valid model', () {
        final tJsonString = File('test/fixture/user.json').readAsStringSync();
        final tMap = jsonDecode(tJsonString) as DataMap;
        final result = UserModel.fromMap(tMap);
        expect(result, userModel);
      });

      test('fromJson should return a valid model', () {
        final tJsonString = File('test/fixture/user.json').readAsStringSync();
        final result = UserModel.fromJson(tJsonString);
        expect(result, userModel);
      });
    });

    group('toMap and toJson', () {
      test('toMap should return a map containing the proper data', () {
        final result = userModel.toMap();
        final expectedMap = {
          'id': '_empty.id',
          'name': '_empty.name',
          'avatar': '_empty.avatar',
          'createdAt': '_empty.createdAt',
        };
        expect(result, expectedMap);
      });

      test('toJson should return a JSON string containing the proper data', () {
        final result = userModel.toJson();
        final expectedJson = jsonEncode({
          'id': '_empty.id',
          'name': '_empty.name',
          'avatar': '_empty.avatar',
          'createdAt': '_empty.createdAt',
        });
        expect(result, expectedJson);
      });
    });

    test('copyWith should return a new instance with updated values', () {
      final updatedUserModel = userModel.copyWith(name: 'Jane Doe');
      expect(updatedUserModel.name, 'Jane Doe');
      expect(updatedUserModel.id, userModel.id);
      expect(updatedUserModel.avatar, userModel.avatar);
      expect(updatedUserModel.createdAt, userModel.createdAt);
    });
  });
}