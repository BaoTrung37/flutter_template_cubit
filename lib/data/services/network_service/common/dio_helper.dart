import 'package:dio/dio.dart';
import 'package:example_flutter_app/config/app_config.dart';
import 'package:example_flutter_app/data/services/network_service/interceptors/auth_interceptor.dart';
import 'package:example_flutter_app/data/services/network_service/interceptors/common_header_interceptor.dart';
import 'package:example_flutter_app/injection/di.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class DioHelper {
  // @factoryMethod
  static Dio configApiDio(AppConfig appConfig) => _createDio(
        options: BaseOptions(
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          baseUrl: appConfig.baseUrl,
        ),
        interceptors: [
          getIt<AuthInterceptor>(),
          getIt<CommonHeaderInterceptor>(),
        ],
        loggerEnable: true,
      );

  static Dio _createDio({
    required BaseOptions options,
    List<Interceptor>? interceptors,
    bool loggerEnable = true,
  }) {
    final dio = Dio();
    dio.options = options;

    if (interceptors != null) {
      dio.interceptors.addAll(
        [...interceptors],
      );
    }

    if (loggerEnable) {
      dio.interceptors.add(_DebugLogger());
    }
    return dio;
  }
}

class _DebugLogger extends PrettyDioLogger {
  _DebugLogger()
      : super(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 1000,
        );
}
