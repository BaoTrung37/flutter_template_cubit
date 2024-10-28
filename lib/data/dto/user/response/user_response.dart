// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserResponse {
  UserResponse({
    required this.id,
    required this.password,
    required this.email,
    required this.name,
    required this.avatar,
    required this.role,
  });
  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  final int id;
  final String password;
  final String email;
  final String name;
  final String avatar;
  final String role;
}
