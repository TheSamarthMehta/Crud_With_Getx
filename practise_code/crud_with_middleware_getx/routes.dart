import 'package:get/get.dart';
import 'package:semester_5_labs/practise_code/crud_with_middleware_getx/auth_middleware.dart';
import 'package:semester_5_labs/practise_code/crud_with_middleware_getx/home_screen.dart';
import 'package:semester_5_labs/practise_code/crud_with_middleware_getx/login_screen.dart';
import 'package:semester_5_labs/practise_code/crud_with_middleware_getx/user_form_screen.dart';

final routes = [
  GetPage(name: '/login', page: () => LoginScreen()),
  GetPage(name: '/home', page: () => HomeScreen(), middlewares: [AuthMiddleware()]),
  GetPage(name: '/form', page: () => UserFormScreen()),
];