import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/src/constants/local_storages_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AuthInterceptors extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;
    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);

    if (extra case {'DIO_AUTH_KEY': true}) {
      final sharedPreferences = await SharedPreferences.getInstance();
      headers.addAll(
        {authHeaderKey: 'Bearer ${sharedPreferences.getString(LocalStoragesConstants.accessToken)}'},
      );
    }
  }
}