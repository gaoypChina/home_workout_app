import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_workout/pages/login_page/widget/login_button.dart';
import 'package:full_workout/pages/login_page/widget/login_textField.dart';
import 'package:full_workout/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../enums/app_conection_status.dart';
import '../../widgets/loading_indicator.dart';




class SignUpPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SignUpPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late AnimationController controller1;
  late Animation<double> animation1;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

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

    Timer(Duration(milliseconds: 1500), () {
      controller1.forward();
    });
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
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
                    "Create Account",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                backgroundColor: Color(0xff192028),
                body: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: size.height - 70,
                      child: Stack(
                        children: [
                          Positioned(
                            top: size.height * (animation1.value + .75),
                            left: size.width * .81,
                            child: CustomPaint(
                              painter: MyPainter(130),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: size.height * .1,
                              ),
                              Column(
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
                                      color: Colors.blue.shade50.withOpacity(
                                          .8),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      wordSpacing: 4,
                                    ),
                                  ),
                                ],
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    LoginTextField(
                                      controller: _emailController,
                                      errorMessage: emailError,
                                      icon: Icons.email_outlined,
                                      hintText: 'Email...',
                                      isEmail: true,
                                      isPassword: false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty ||
                                            !RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(value)) {
                                          setState(() {
                                            emailError = "Invalid email";
                                          });
                                          return "Invalid email";
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
                                      isEmail: true,
                                      isPassword: false,
                                      validator: (value) {
                                        bool isPassValid = RegExp(
                                            "^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*")
                                            .hasMatch(value);

                                        if (value == null || value.isEmpty ||
                                            !isPassValid) {
                                          setState(() {
                                            passwordError = "Invalid password";
                                          });
                                          return "invalid password";
                                        } else {
                                          passwordError = null;
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    LoginTextField(
                                      controller: _confirmPasswordController,
                                      errorMessage: confirmPasswordError,
                                      icon: Icons.lock_outline,
                                      hintText: 'Confirm Password...',
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
                                            confirmPasswordError =
                                            "Invalid password";
                                          });
                                          return "invalid password";
                                        } else {
                                          if (_passwordController.text !=
                                              _confirmPasswordController.text) {
                                            confirmPasswordError =
                                            "Password must equal";
                                            return "Password must equal";
                                          } else {
                                            confirmPasswordError = null;
                                            return null;
                                          }
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [

                                        LoginButton(
                                          color: Colors.blue.withOpacity(.2),
                                          title: 'SIGNUP',
                                          width: 2.58,
                                          onTap: () {
                                            HapticFeedback.lightImpact();
                                            if (_formKey.currentState!
                                                .validate()) {
                                              authProvider.emailSignup(email: _emailController.text, password: _passwordController.text,context: context);

                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * .1),
                                      child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              text: "Already have an Account?  ",
                                              style: TextStyle(
                                                  height: 1.3,
                                                  fontSize: 13,
                                                  color: Colors.white60),
                                              children: [
                                                WidgetSpan(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                        "Login".toUpperCase(),
                                                        style: TextStyle(
                                                            height: 1.1,
                                                            color:
                                                            Colors.blue
                                                                .withOpacity(
                                                                .8),
                                                            fontSize: 13),
                                                      ),
                                                    ))
                                              ])),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if(authProvider.connectionStatus ==
                  AppConnectionStatus.loading) CustomLoadingIndicator(
                msg: "Loading...", isLoginPage: true,),

            ],
          );
        }
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
        //Colors.transparent,
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
  Widget buildViewportChrome(BuildContext context, Widget child,
      AxisDirection axisDirection) {
    return child;
  }
}
