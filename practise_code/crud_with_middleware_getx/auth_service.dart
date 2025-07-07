class AuthService {
  static final AuthService _instance = AuthService._internal();
  bool isLoggedIn = false;

  factory AuthService() => _instance;
  AuthService._internal();

  void login() {
    isLoggedIn = true;
  }

  void logout() {
    isLoggedIn = false;
  }

  bool checkLogin() => isLoggedIn;
}
