import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

/// Purpose : This is a login request class which is used in login api call.
@JsonSerializable()
class LoginRequest {
  LoginRequest({
    this.email,
    this.password,
   });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  //for normal login
  @JsonKey(name: "email")
  String? email;
  //for normal login
  @JsonKey(name: "password")
  String? password;


}
