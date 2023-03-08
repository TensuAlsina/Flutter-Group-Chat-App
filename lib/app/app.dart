import 'package:group_chat/services/authentication_authorization_services.dart';
import 'package:group_chat/services/firestore_service.dart';
import 'package:group_chat/services/local_storage_services.dart';
import 'package:group_chat/ui/views/home/home_view.dart';
import 'package:group_chat/ui/views/login/login_view.dart';
import 'package:group_chat/ui/views/signup/signup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SignUpView),
    CupertinoRoute(page: HomeView),
    MaterialRoute(page: LogInView)
  ],
  dependencies: [
    LazySingleton(classType: AuthenticationAndAuthorizationServices),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: FireStoreServices),
    LazySingleton(classType: LocalStorageServecs)
  ],
)
class $App {}
