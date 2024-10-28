import 'package:dio/dio.dart';
import 'package:example_flutter_app/data/dto/auth/login_request.dart';
import 'package:example_flutter_app/data/dto/auth/login_response.dart';
import 'package:example_flutter_app/data/dto/dto.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST('/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @GET('/auth/profile')
  Future<UserResponse> getProfile();
}
