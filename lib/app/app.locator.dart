// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';

import '../services/authentication_authorization_services.dart';
import '../services/firestore_service.dart';
import '../services/local_storage_services.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => AuthenticationAndAuthorizationServices());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => FireStoreServices());
  locator.registerLazySingleton(() => LocalStorageServecs());
}
