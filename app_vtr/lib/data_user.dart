
class DataUser{
  String token_user = '';

  setToken(token) {
    prefs.setString('token', token);
    token_user = token;
  }

  getToken() {
    return token_user;
  }
}
