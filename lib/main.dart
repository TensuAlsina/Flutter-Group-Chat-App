import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:group_chat/app/app.locator.dart';
import 'package:group_chat/app/app.router.dart';
import 'package:group_chat/config/firebase_options.dart';
import 'package:group_chat/ui/views/home/home_view.dart';
import 'package:group_chat/ui/views/login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool("isLogged") ?? false;
  runApp(MyApp(
    isUserLoggedIn: showHome,
  ));
}

class MyApp extends StatelessWidget {
  final bool isUserLoggedIn;
  const MyApp({super.key, required this.isUserLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      home: isUserLoggedIn ? const HomeView() : LogInView(),
    );
  }
}
