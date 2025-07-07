import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:semester_5_labs/practise_code/crud_with_middleware_getx/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final isLoggedIn = AuthService().checkLogin();
    if (!isLoggedIn) {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}
