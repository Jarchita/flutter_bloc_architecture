import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

/// Purpose : This is a parent login response which will be used to parse the
/// response of login.
@JsonSerializable()
class LoginResponse {
  LoginResponse(this.accessToken);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @JsonKey(name: "access_token")
  String? accessToken;
}
