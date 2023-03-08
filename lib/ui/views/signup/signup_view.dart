import 'package:flutter/material.dart';
import 'package:group_chat/ui/views/signup/signup_view.form.dart';
import 'package:group_chat/ui/views/signup/validators.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'signup_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: "email", validator: FormValidators.emailValidator),
  FormTextField(name: "password", validator: FormValidators.passwordValidator),
  FormTextField(name: "name", validator: FormValidators.nameValidator),
], autoTextFieldValidation: false)
class SignUpView extends StatelessWidget with $SignUpView {
  SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      onDispose: (viewModel) => disposeForm(),
      onViewModelReady: (viewModel) {
        syncFormWithViewModel(viewModel);
      },
      builder: (
        BuildContext context,
        SignUpViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: size.height * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "CREATE\nACCOUNT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 42,
                            color: Colors.indigo),
                      ),
                      SizedBox(
                        height: size.height * 0.07,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            hintText: "Name",
                            hintStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            )),
                        focusNode: nameFocusNode,
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
                        controller: emailController,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: "Email",
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
                        height: size.height * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (validateFormFields(model)) {
                            model.createUserUsingEmailPassword(
                                emailController.text.trim(),
                                passwordController.text.trim());
                          }
                        },
                        child: CustomButton(
                          isBusy: model.isBusy,
                          textToShow: "Sign Up",
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
                        onTap: model.navigateToLoginPage,
                        child: const CustomButton(
                          isBusy: false,
                          textToShow: "Log in",
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

class CustomButton extends StatelessWidget {
  final bool isBusy;
  final String textToShow;
  final bool isSignUp;
  const CustomButton({
    super.key,
    required this.isBusy,
    required this.textToShow,
    required this.isSignUp,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(3),
      height: size.height * 0.07,
      width: size.width,
      decoration: BoxDecoration(
          color: isSignUp ? Colors.indigo : Colors.grey,
          borderRadius: BorderRadius.circular(15)),
      child: isBusy
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Center(
              child: Text(
                textToShow,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: isSignUp ? Colors.white : Colors.black),
              ),
            ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: Row(
        children: const [
          Expanded(
              child: Divider(
            color: Colors.black,
            thickness: 1,
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("OR"),
          ),
          Expanded(
              child: Divider(
            color: Colors.black,
            thickness: 1,
          )),
        ],
      ),
    );
  }
}
