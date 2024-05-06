import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../exports/constants.dart';
import '../exports/models.dart';

part 'api_client.g.dart';

/// Purpose : This is a API client class used to prepare api client object with
/// api references.
@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(APIPath.login)
  Future<LoginResponse> doLogin(@Body() LoginRequest request);


}
