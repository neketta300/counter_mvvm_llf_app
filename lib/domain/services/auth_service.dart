import 'package:mvvm_counter_llf/domain/data_provider/auth_api_provider.dart';
import 'package:mvvm_counter_llf/domain/data_provider/session_data_provider.dart';

class AuthService {
  final _sessionDataProvider = SessionDataProvider();
  final _authApiaProvider = AuthApiaProvider();

  Future<bool> checkAuth() async {
    final apiKey = await _sessionDataProvider.apiKey();
    print('apiKey: $apiKey');
    return apiKey != null;
  }

  Future<void> login(String login, String passwrod) async {
    final apiKey = await _authApiaProvider.login(login, passwrod);
    await _sessionDataProvider.saveApiKey(apiKey);
  }

  Future<void> logout() async {
    await _sessionDataProvider.clearApiKey();
  }
}
