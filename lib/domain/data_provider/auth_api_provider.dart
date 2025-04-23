abstract class AuthApiProviderError {}

class AuthApiProviderIncorectLoginDataError {}

class AuthApiaProvider {
  Future<String> login(String login, String passwrod) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final isSucsses = login == 'admin' && passwrod == '123456';
    if (isSucsses) {
      return 'asdtgergwewd5435asda31';
    } else {
      throw AuthApiProviderIncorectLoginDataError;
    }
    // if (login == 'admin' && passwrod == '123456') {
    //   return true;
    // }
    // return false;
  }
}
