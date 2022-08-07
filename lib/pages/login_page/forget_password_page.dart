import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../enums/app_conection_status.dart';
import '../../pages/login_page/signup_page.dart';
import '../../pages/login_page/widget/login_button.dart';
import '../../pages/login_page/widget/login_textField.dart';
import '../../provider/auth_provider.dart';
import '../../widgets/loading_indicator.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String? emailError;
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.blueGrey.shade900.withOpacity(.5),
              leading: IconButton(
                color: Colors.white,
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                "Reset Password",
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: Color(0xff192028),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * .2,
                  ),
                  Text(
                    'Home Workout'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.blue.shade50.withOpacity(.8),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      wordSpacing: 4,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Reset Link will be sent to your email Id!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: LoginTextField(
                      controller: _emailController,
                      icon: Icons.email_outlined,
                      hintText: "Enter your Email",
                      isEmail: true,
                      isPassword: false,
                      errorMessage: emailError,
                      validator: (String? value) {
                        log("forget email : " + value.toString());
                        if (value == null ||
                            value.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          setState(() {
                            emailError = "Invalid email";
                          });
                          return " ";
                        } else {
                          setState(() {
                            emailError = null;
                          });
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginButton(
                        color: Colors.blue.withOpacity(.2),
                        title: 'Have Account?',
                        width: 2.58,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: size.width / 20),
                      LoginButton(
                          color: Colors.blue.withOpacity(.2),
                          title: "Send Email",
                          width: 2.58,
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_formKey.currentState!.validate()) {
                              authProvider.resetEmailPassword(
                                  context: context,
                                  email: _emailController.text);
                            }
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  LoginButton(
                    title: 'Create a new Account',
                    width: 2,
                    color: Colors.blue.withOpacity(.2),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => SignUpPage()));
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          if (authProvider.connectionStatus == AppConnectionStatus.loading)
            CustomLoadingIndicator(
              msg: "Loading...",
              isLoginPage: true,
            ),
        ],
      );
    });
  }
}
