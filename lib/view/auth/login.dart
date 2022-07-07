import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taba3ni/constant/size_config.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/providers/auth_provider.dart';
import 'package:taba3ni/providers/language.dart';
import 'package:taba3ni/view/auth/sign_up.dart';
import 'package:taba3ni/widgets/primary_btn.dart';
import 'package:taba3ni/widgets/text_form_field.dart';
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
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  @override
  void initState() {
    getLogin();
    super.initState();
  }

  getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    passwordController.text = prefs.getString("password") ?? "";
    emailController.text = prefs.getString("email") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    var hm = SizeConfig.heightMultiplier;
    var wm = SizeConfig.widthMultiplier;
    var tm = SizeConfig.textMultiplier;
    var lang = context.read<LanguageProvider>();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: darkBgColor,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: hm! * 4, right: wm! * 4, left: wm * 5),
                        child: Txt(
                            text: "Log in",
                            style: titleWhite.copyWith(fontSize: tm! * 4))),
                    Padding(
                        padding: EdgeInsets.only(
                            top: hm * 5, left: wm * 4, right: wm * 4),
                        child: CustomTextField(
                          hint: "user@gmail.com",
                          controller: emailController,
                          labelText: "Email",
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          top: hm * 2.5, left: wm * 4, right: wm * 4),
                      child: CustomTextField(
                        hint: "ynYhs@XjfB1%",
                        controller: passwordController,
                        labelText: "Password",
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: wm * 15.0),
                        child: primaryButton(
                            context: context,
                            height: hm * 7,
                            width: wm * 50,
                            widget: Txt(
                                text: "Log in",
                                style: text18black.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: tm * 2.1,
                                    color: darkBgColor.withOpacity(0.8))),
                            borderRadius: BorderRadius.circular(wm * 30),
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                lightOrange,
                                lightBlueColor,
                              ],
                            ),
                            function: () {
                              if (formkey.currentState != null &&
                                  formkey.currentState!.validate()) {
                                context.read<AuthProvider>().loginWithEmail(
                                    context,
                                    emailController.text,
                                    passwordController.text);
                              }
                            }),
                      ),
                    ),
                    Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: wm * 25.0),
                      child: Txt(
                          text: 'Or login with one of the following options',
                          style: text18white.copyWith(color: Colors.white70)),
                    )),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: wm * 5.0, left: wm * 8),
                        child: Row(
                          children: [
                            transparentButton(
                                context: context,
                                height: hm * 7,
                                width: wm * 40,
                                widget: SvgPicture.asset(
                                    "assets/images/google.svg",
                                    color: Colors.white),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: wm * 0.5),
                                borderRadius: BorderRadius.circular(wm * 5),
                                function: () async {
                                  final user = await context
                                      .read<AuthProvider>()
                                      .googleLogin(context);
                                  if (user != null) {
                                    emailController.text = user.email;
                                    passwordController.text = "";
                                  }
                                }),
                            SizedBox(
                              width: wm * 2,
                            ),
                            transparentButton(
                                context: context,
                                height: hm * 7,
                                width: wm * 40,
                                widget: SvgPicture.asset(
                                  "assets/images/facebook.svg",
                                  width: wm * 7.5,
                                  height: wm * 7.5,
                                  color: Colors.white,
                                ),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: wm * 0.5),
                                borderRadius: BorderRadius.circular(wm * 5),
                                function: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()),
                                    ))
                          ],
                        ),
                      ),
                    ),
                    Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: wm * 4.0),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'You don' "t have an account ",
                                style:
                                    text18white.copyWith(fontSize: tm * 1.5)),
                            TextSpan(
                                text: 'Sign up',
                                style: text18white.copyWith(
                                    color: lightBlueColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: tm * 1.5),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpScreen()),
                                      )),
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
        if (context.watch<AuthProvider>().isLoading)
          const Center(child: CircularProgressIndicator())
      ],
    );
  }
}
