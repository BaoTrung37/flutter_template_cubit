import 'package:example_flutter_app/data/data.dart';
import 'package:example_flutter_app/presentation/utilities/enums/common/languages.dart';
import 'package:example_flutter_app/presentation/utilities/logger/app_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SharedManager {
  SharedManager(this._sharedPreferences);
  final SharedPreferences _sharedPreferences;

  //* First Time Launch
  Future<void> saveFirstTimeLaunch() async {
    await _sharedPreferences.setBool(
      SharedKeys.firstTimeLaunch.name,
      false,
    );
    AppLogger.instance.logD('First time launch saved');
  }

  bool getFirstTimeLaunch() {
    return _sharedPreferences.getBool(SharedKeys.firstTimeLaunch.name) ?? true;
  }

  Future<void> removeFirstTimeLaunch() async {
    await _sharedPreferences.remove(SharedKeys.firstTimeLaunch.name);
    AppLogger.instance.logD('First time launch removed');
  }

  //* Language Code
  Future<void> saveLanguageCode(String languageCode) async {
    await _sharedPreferences.setString(
      SharedKeys.languageCode.name,
      languageCode,
    );
    AppLogger.instance.logD('Language code saved: $languageCode');
  }

  String getLanguageCode() {
    return _sharedPreferences.getString(SharedKeys.languageCode.name) ??
        Languages.en.name;
  }

  Future<void> removeLanguageCode() async {
    await _sharedPreferences.remove(SharedKeys.languageCode.name);
    AppLogger.instance.logD('Language code removed');
  }

  //* Access Token
  Future<void> saveAccessToken(String accessToken) async {
    await _sharedPreferences.setString(
      SharedKeys.accessToken.name,
      accessToken,
    );
    AppLogger.instance.logD('Access token saved');
  }

  String? getAccessToken() {
    return _sharedPreferences.getString(SharedKeys.accessToken.name);
  }

  Future<void> removeAccessToken() async {
    await _sharedPreferences.remove(SharedKeys.accessToken.name);
    AppLogger.instance.logD('Access token removed');
  }
}
