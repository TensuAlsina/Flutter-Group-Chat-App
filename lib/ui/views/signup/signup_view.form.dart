// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:group_chat/ui/views/signup/validators.dart';
import 'package:stacked/stacked.dart';

const String EmailValueKey = 'email';
const String PasswordValueKey = 'password';
const String NameValueKey = 'name';

final Map<String, TextEditingController> _SignUpViewTextEditingControllers = {};

final Map<String, FocusNode> _SignUpViewFocusNodes = {};

final Map<String, String? Function(String?)?> _SignUpViewTextValidations = {
  EmailValueKey: FormValidators.emailValidator,
  PasswordValueKey: FormValidators.passwordValidator,
  NameValueKey: FormValidators.nameValidator,
};

mixin $SignUpView on StatelessWidget {
  TextEditingController get emailController =>
      _getFormTextEditingController(EmailValueKey);
  TextEditingController get passwordController =>
      _getFormTextEditingController(PasswordValueKey);
  TextEditingController get nameController =>
      _getFormTextEditingController(NameValueKey);
  FocusNode get emailFocusNode => _getFormFocusNode(EmailValueKey);
  FocusNode get passwordFocusNode => _getFormFocusNode(PasswordValueKey);
  FocusNode get nameFocusNode => _getFormFocusNode(NameValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_SignUpViewTextEditingControllers.containsKey(key)) {
      return _SignUpViewTextEditingControllers[key]!;
    }
    _SignUpViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _SignUpViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_SignUpViewFocusNodes.containsKey(key)) {
      return _SignUpViewFocusNodes[key]!;
    }
    _SignUpViewFocusNodes[key] = FocusNode();
    return _SignUpViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    emailController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    nameController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    emailController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    nameController.addListener(() => _updateFormData(model));
  }

  final bool _autoTextFieldValidation = false;
  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          EmailValueKey: emailController.text,
          PasswordValueKey: passwordController.text,
          NameValueKey: nameController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        EmailValueKey: _getValidationMessage(EmailValueKey),
        PasswordValueKey: _getValidationMessage(PasswordValueKey),
        NameValueKey: _getValidationMessage(NameValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _SignUpViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_SignUpViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _SignUpViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _SignUpViewFocusNodes.values) {
      focusNode.dispose();
    }

    _SignUpViewTextEditingControllers.clear();
    _SignUpViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get emailValue => this.formValueMap[EmailValueKey] as String?;
  String? get passwordValue => this.formValueMap[PasswordValueKey] as String?;
  String? get nameValue => this.formValueMap[NameValueKey] as String?;

  set emailValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          EmailValueKey: value,
        }),
    );

    if (_SignUpViewTextEditingControllers.containsKey(EmailValueKey)) {
      _SignUpViewTextEditingControllers[EmailValueKey]?.text = value ?? '';
    }
  }

  set passwordValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          PasswordValueKey: value,
        }),
    );

    if (_SignUpViewTextEditingControllers.containsKey(PasswordValueKey)) {
      _SignUpViewTextEditingControllers[PasswordValueKey]?.text = value ?? '';
    }
  }

  set nameValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          NameValueKey: value,
        }),
    );

    if (_SignUpViewTextEditingControllers.containsKey(NameValueKey)) {
      _SignUpViewTextEditingControllers[NameValueKey]?.text = value ?? '';
    }
  }

  bool get hasEmail =>
      this.formValueMap.containsKey(EmailValueKey) &&
      (emailValue?.isNotEmpty ?? false);
  bool get hasPassword =>
      this.formValueMap.containsKey(PasswordValueKey) &&
      (passwordValue?.isNotEmpty ?? false);
  bool get hasName =>
      this.formValueMap.containsKey(NameValueKey) &&
      (nameValue?.isNotEmpty ?? false);

  bool get hasEmailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey]?.isNotEmpty ?? false;
  bool get hasPasswordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey]?.isNotEmpty ?? false;
  bool get hasNameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey]?.isNotEmpty ?? false;

  String? get emailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey];
  String? get passwordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey];
  String? get nameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey];
  void clearForm() {
    emailValue = '';
    passwordValue = '';
    nameValue = '';
  }
}

extension Methods on FormViewModel {
  setEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailValueKey] = validationMessage;
  setPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PasswordValueKey] = validationMessage;
  setNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NameValueKey] = validationMessage;
}
