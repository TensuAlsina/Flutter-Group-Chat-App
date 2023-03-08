import 'package:group_chat/app/app.locator.dart';
import 'package:group_chat/app/app.router.dart';
import 'package:group_chat/services/authentication_authorization_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends FormViewModel {
  final AuthenticationAndAuthorizationServices _backEndServices =
      locator<AuthenticationAndAuthorizationServices>();
  bool get isVisible => _isVisible;
  bool _isVisible = true;
  final NavigationService _navigationService = locator<NavigationService>();
  Future createUserUsingEmailPassword(String email, String password) async {
    try {
      runBusyFuture(_backEndServices
          .authorizeUser(email, password)
          .then((value) => goToHomePage()));
    } catch (e) {
      rethrow;
    }
  }

  void goToHomePage() async {
    await _navigationService.navigateTo(Routes.homeView);
  }

  void toggleIsVisible() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  Future<void> navigateToLoginPage() async {
    await _navigationService.navigateToLogInView();
  }
}
