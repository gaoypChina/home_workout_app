import 'dart:ui';

import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final bool isPassword;
  final Function validator;
  final bool isEmail;
  final TextEditingController controller;
  final String? errorMessage;

  const LoginTextField(
      {Key? key,
      required this.icon,
      required this.hintText,
      required this.isEmail,
      required this.errorMessage,
      required this.validator,
      required this.controller,
      required this.isPassword})
      : super(key: key);

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 15,
              sigmaX: 15,
            ),
            child: Container(
              height: 55,
              width: size.width / 1.2,
              alignment: Alignment.center,
              //  padding: EdgeInsets.only(right: size.width / 30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.05),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                controller: widget.controller,
                validator: (value) {
                  return widget.validator(value);
                },
                cursorColor: Colors.white,
                obscureText: widget.isPassword ? _isHidden : false,
                keyboardType: widget.isEmail
                    ? TextInputType.emailAddress
                    : TextInputType.text,
                style: TextStyle(
                    color: Colors.white.withOpacity(.8), fontSize: 15),
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: .0, height: -1),
                  fillColor: Colors.transparent,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(.6),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 0.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 0.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 0.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 0.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 0.0),
                  ),
                  prefixIcon: Icon(
                    widget.icon,
                    color: Colors.white.withOpacity(.7),
                  ),
                  suffix: widget.isPassword
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                          child: GestureDetector(
                            onTap: _togglePasswordView,
                            child: Icon(
                              !_isHidden
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              size: 24,
                              color: Colors.white70,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
        if (widget.errorMessage != null)
          SizedBox(
            height: 8,
          ),
        if (widget.errorMessage != null)
          Text(
            widget.errorMessage!,
            style: TextStyle(color: Colors.red.withOpacity(.8)),
          )
      ],
    );
  }
}
