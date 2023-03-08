import 'package:flutter/material.dart';
import 'package:group_chat/ui/views/login/login_view.form.dart';
import 'package:group_chat/ui/views/login/loginformvalidator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../signup/signup_view.dart';
import 'login_viewmodel.dart';

@FormView(
  fields: [
    FormTextField(name: "email", validator: LoginFormValidators.emailValidator),
    FormTextField(
        name: "password", validator: LoginFormValidators.passwordValidator),
  ],
)
class LogInView extends StatelessWidget with $LogInView {
  LogInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<LogInViewModel>.reactive(
      viewModelBuilder: () => LogInViewModel(),
      onDispose: (viewModel) => disposeForm(),
      builder: (
        BuildContext context,
        LogInViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: size.height * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "WELCOME\nBACK",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 42,
                            color: Colors.indigo),
                      ),
                      SizedBox(
                        height: size.height * 0.07,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black,
                            )),
                        keyboardType: TextInputType.emailAddress,
                        focusNode: emailFocusNode,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Visibility(
                          visible: model.hasEmailValidationMessage,
                          child: Text(
                            model.emailValidationMessage ?? "",
                            style: const TextStyle(color: Colors.red),
                          )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.black),
                            suffixIcon: IconButton(
                                onPressed: model.toggleIsVisible,
                                icon: model.isVisible
                                    ? const Icon(
                                        Icons.visibility,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        color: Colors.black,
                                      )),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black,
                            )),
                        obscureText: model.isVisible,
                        focusNode: passwordFocusNode,
                      ),
                      Visibility(
                          visible: model.hasPasswordValidationMessage,
                          child: Text(
                            model.passwordValidationMessage ?? "",
                            style: const TextStyle(color: Colors.red),
                          )),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text("Forgot password?")),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (validateFormFields(model)) {
                            model.singInUserUsingEmailPassword(
                                emailController.text.trim(),
                                passwordController.text.trim());
                          }
                        },
                        child: CustomButton(
                          isBusy: model.isBusy,
                          textToShow: "Log in",
                          isSignUp: true,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      const Align(
                          alignment: Alignment.center, child: OrDivider()),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: model.navigateToSignUpPage,
                        child: const CustomButton(
                          isBusy: false,
                          textToShow: "Sign up",
                          isSignUp: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
