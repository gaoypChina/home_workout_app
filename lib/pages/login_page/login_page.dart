import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_workout/pages/login_page/forget_password_page.dart';
import 'package:full_workout/pages/login_page/signup_page.dart';
import 'package:full_workout/pages/login_page/widget/login_button.dart';
import 'package:full_workout/pages/login_page/widget/login_textField.dart';
import 'package:full_workout/pages/main_page.dart';
import 'package:full_workout/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../enums/app_conection_status.dart';
import '../../widgets/loading_indicator.dart';

class LoginPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  String? emailError;
  String? passwordError;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    Timer(Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: Color(0xff192028),
            body: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: size.height,
                  child: Stack(
                    children: [
                      Positioned(
                        top: size.height * .98,
                        left: size.width * .1,
                        child: CustomPaint(
                          painter: MyPainter(animation4.value - 30),
                        ),
                      ),
                      Column(
                        children: [
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0),
                            child: Column(
                              children: [
                                Opacity(
                                  opacity: .8,
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      child: Image.asset(
                                        "assets/app_icon.png",
                                        height: 60,
                                      )),
                                ),
                                SizedBox(
                                  height: 12,
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
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      LoginTextField(
                                        controller: _emailController,
                                        icon: Icons.email_outlined,
                                        hintText: 'Email...',
                                        isEmail: true,
                                        isPassword: false,
                                        errorMessage: emailError,
                                        validator: (String? value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(value)) {
                                            setState(() {
                                              emailError = "Invalid email";
                                            });
                                            return " ";
                                          } else {
                                            emailError = null;
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      LoginTextField(
                                        controller: _passwordController,
                                        errorMessage: passwordError,
                                        icon: Icons.lock_outline,
                                        hintText: 'Password...',
                                        isEmail: false,
                                        isPassword: true,
                                        validator: (value) {
                                          bool isPassValid = RegExp(
                                                  "^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*")
                                              .hasMatch(value);

                                          if (value == null ||
                                              value.isEmpty ||
                                              !isPassValid) {
                                            setState(() {
                                              passwordError =
                                                  "Invalid password";
                                            });
                                            return "invalid password";
                                          } else {
                                            passwordError = null;
                                            return null;
                                          }
                                        },
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LoginButton(
                                    color: Colors.blue.withOpacity(.2),
                                    title: 'Forgot password!',
                                    width: 2.58,
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  ForgetPasswordPage()));
                                    },
                                  ),
                                  SizedBox(width: size.width / 20),
                                  LoginButton(
                                    color: Colors.blue.withOpacity(.2),
                                    title: "LOGIN",
                                    width: 2.58,
                                    onTap: () {
                                      if ( _formKey.currentState!.validate()) {
                                        var authProvider =
                                            Provider.of<AuthProvider>(context,
                                                listen: false);
                                        authProvider.emailLogin(
                                            context: context,
                                            email: _emailController.text,
                                            password: _passwordController.text);
                                      }

                                      HapticFeedback.lightImpact();
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * .1),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      height: .2,
                                      color: Colors.white60,
                                    )),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "OR",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Container(
                                      height: .2,
                                      color: Colors.white60,
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              getLoginButton(size, authProvider)
                            ],
                          ),
                          Spacer(),
                          LoginButton(
                            title: 'Create a new Account',
                            width: 2,
                            color: Colors.blue.withOpacity(.2),
                            onTap: () {
                              HapticFeedback.lightImpact();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) => SignUpPage()));
                            },
                          ),
                          SizedBox(height: size.height * .05),
                        ],
                      ),
                    ],
                  ),
                ),
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

  Widget getLoginButton(
    size,
  AuthProvider    authProvider
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            authProvider.googleLogin(context: context);
          },
          child: Container(
            height: size.width / 8,
            width: size.width / 1.2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 8,
                ),
                Container(
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    height: 40,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        child: Image.asset(
                            "packages/flutter_signin_button/assets/logos/2.0x/google_light.png"))),
                Spacer(),
                Text(
                  "Continue with Google",
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                Icon(
                  Icons.navigate_next_outlined,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 12,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(colors: [
        //  Colors.transparent, Colors.transparent,
        Colors.blue.withOpacity(.2),
        Colors.blue.withOpacity(.5),

        //  Color(0xffC43990)
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
        center: Offset(0, 0),
        radius: radius,
      ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
