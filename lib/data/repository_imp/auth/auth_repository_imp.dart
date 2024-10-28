import 'package:example_flutter_app/data/data.dart';
import 'package:example_flutter_app/data/dto/auth/login_request.dart';
import 'package:example_flutter_app/domain/repository/auth/auth_repository.dart';
import 'package:example_flutter_app/presentation/utilities/logger/app_logger.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthRepositoryImp implements AuthRepository {
  AuthRepositoryImp(this._restClient, this._sharedManager);

  final RestClient _restClient;
  final SharedManager _sharedManager;

  @override
  Future<void> login(String email, String password) async {
    try {
      final response = await _restClient.login(
        LoginRequest(email: email, password: password),
      );
      await _sharedManager.saveAccessToken(response.accessToken);
    } catch (e) {
      AppLogger.instance.logE(e.toString());
      throw Exception('Login failed');
    }
  }

  @override
  Future<bool> isLogged() async {
    return await _checkAccessToken() == true;
  }

  @override
  Future<void> logout() {
    return _sharedManager.removeAccessToken();
  }

  Future<bool> _checkAccessToken() async {
    try {
      await _restClient.getProfile();
      return _sharedManager.getAccessToken() != null;
    } catch (e) {
      AppLogger.instance.logE(e.toString());
      return false;
    }
  }
}
