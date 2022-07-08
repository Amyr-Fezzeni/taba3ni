import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/providers/auth_provider.dart';
import 'package:taba3ni/views/login/signup.dart';
import 'package:taba3ni/views/login/validator.dart';
import 'package:taba3ni/widgets/custom_text_field.dart';
import 'package:taba3ni/widgets/primary_btn.dart';
import 'package:taba3ni/widgets/text_widget.dart';
import 'package:taba3ni/widgets/transparent_btn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool emailCorrect = false;
  bool passwordCorrect = false;
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    // var lang = context.read<LanguageProvider>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: darkBgColor,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 50, left: 20),
                    child: Txt(text: "Log in", style: titleWhite)),
                SizedBox(
                  height: size.height * 0.1,
                ),
                CustomTextField(
                  hint: "Email",
                  controller: emailController,
                  validator: emailValidator,
                  focus: emailFocus,
                  keybordType: TextInputType.emailAddress,
                  label: "Email",
                ),
                CustomTextField(
                  hint: "Password",
                  controller: passwordController,
                  validator: (value) {
                    return value.toString().length > 7 ? null : "";
                  },
                  focus: passwordFocus,
                  label: "Password",
                  isPassword: true,
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: primaryButton(
                        context: context,
                        height: 50,
                        width: 200,
                        widget: context.watch<AuthProvider>().isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black87,
                                ),
                              )
                            : Txt(
                                text: "Log in",
                                style: text18black.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: darkBgColor.withOpacity(0.8))),
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            lightOrange,
                            lightBlueColor,
                          ],
                        ),
                        function: () => context.read<AuthProvider>().login(
                            context,
                            emailController.text,
                            passwordController.text)),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Center(
                    child: Txt(
                        text: 'Or login with one of the following options',
                        style: text18white.copyWith(
                            fontSize: 16, color: Colors.white70))),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      transparentButton(
                        context: context,
                        height: 60,
                        width: 150,
                        widget: SvgPicture.asset("assets/images/google.svg",
                            height: 30, width: 30, color: Colors.white),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.2), width: 1),
                        borderRadius: BorderRadius.circular(18),
                        function: () =>
                            context.read<AuthProvider>().googleLogIn(context),
                      ),
                      transparentButton(
                        context: context,
                        height: 60,
                        width: 150,
                        widget: SvgPicture.asset(
                          "assets/images/facebook.svg",
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.2), width: 1),
                        borderRadius: BorderRadius.circular(18),
                        function: () => log("login with Facebook"),
                      )
                    ],
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: "You don't have an account ?  ",
                            style: text18white),
                        TextSpan(
                            text: 'Sign up',
                            style: text18white.copyWith(
                              color: lightBlueColor,
                              fontWeight: FontWeight.w800,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen()),
                                  )),
                      ],
                    ),
                  ),
                )),
                SizedBox(
                  height: size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}