// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:group_chat/app/app.router.dart';
import 'package:group_chat/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/authentication_authorization_services.dart';
import '../../../services/local_storage_services.dart';

class HomeViewModel extends BaseViewModel {
  final AuthenticationAndAuthorizationServices _backEndServices =
      locator<AuthenticationAndAuthorizationServices>();
  final LocalStorageServecs _localStorageServecs =
      locator<LocalStorageServecs>();
  final FireStoreServices _fireStoreServices = locator<FireStoreServices>();
  final NavigationService _navigationService = locator<NavigationService>();

  User get user => _user;
  late User _user;

  get messageController => _messageController;
  final TextEditingController _messageController = TextEditingController();

  Stream<QuerySnapshot> get myStream => _myStream();
  Stream<QuerySnapshot> _myStream() => _fireStoreServices.messageStream();
  getLoggedInUser() async {
    setBusy(true);
    await runBusyFuture(_backEndServices.getCurrenUser()).then((value) {
      _user = value;
      notifyListeners();
      setBusy(false);
    });
  }

  Future<void> addMessageToFireStore() async {
    if (_messageController.text.isEmpty) return;
    await _fireStoreServices
        .putMessageToFirebase(
            senderEmail: _user.email!,
            messageToSend: _messageController.text.trim())
        .then((value) => _messageController.clear());
  }

  void logOutUser() async {
    try {
      await _backEndServices.logUserOut();
      _localStorageServecs.setIsUserLoggedIn(isLogged: false);
      navigateToLoginPage();
    } catch (e) {}
  }

  void navigateToLoginPage() async {
    await _navigationService.clearStackAndShow(Routes.logInView);
  }
}
