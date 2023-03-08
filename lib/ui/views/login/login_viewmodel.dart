import 'package:group_chat/services/local_storage_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/authentication_authorization_services.dart';

class LogInViewModel extends FormViewModel {
  final AuthenticationAndAuthorizationServices _backEndServices =
      locator<AuthenticationAndAuthorizationServices>();
  final LocalStorageServecs _localStorageServecs =
      locator<LocalStorageServecs>();
  bool get isVisible => _isVisible;
  bool _isVisible = true;
  final NavigationService _navigationService = locator<NavigationService>();
  Future singInUserUsingEmailPassword(String email, String password) async {
    try {
      runBusyFuture(_backEndServices
          .authenticateUser(email, password)
          .then((value) async {
        await _localStorageServecs.setIsUserLoggedIn(isLogged: true);
        goToHomePage();
      }));
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

  Future<void> navigateToSignUpPage() async {
    await _navigationService.navigateToSignUpView();
  }
}
