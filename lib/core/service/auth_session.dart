class AuthSession {
  String? _accessToken;

  String? get accessToken => _accessToken;
  bool get isAuthenticated => _accessToken != null;

  void setToken(String token) => _accessToken = token;
  void clear() => _accessToken = null;
}
