import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/constant/size_config.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/providers/language.dart';
import 'package:taba3ni/view/auth/sign_up.dart';
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
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();

  @override
  Widget build(BuildContext context) {
    var hm = SizeConfig.heightMultiplier;
    var wm = SizeConfig.widthMultiplier;
    var tm = SizeConfig.textMultiplier;
    var lang = context.read<LanguageProvider>();
    return Scaffold(
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
                    child: textFormField(
                      hm,
                      wm,
                      tm,
                      "user@gmail.com",
                      emailController,
                      context,
                      lang,
                      labelText: "Email",
                      label: true,
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: hm * 2.5, left: wm * 4, right: wm * 4),
                  child: textFormField(
                    hm,
                    wm,
                    tm,
                    "ynYhs@XjfB1%",
                    passwordController,
                    context,
                    lang,
                    labelText: "Password",
                    label: true,
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
                        function: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()),
                            )),
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
                            widget: SvgPicture.asset("assets/images/google.svg",
                                color: Colors.white),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: wm * 0.5),
                            borderRadius: BorderRadius.circular(wm * 5),
                            function: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()),
                                )),
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
                            style: text18white.copyWith(fontSize: tm * 1.5)),
                        TextSpan(
                            text: 'Sign up',
                            style: text18white.copyWith(
                                color: lightBlueColor,
                                fontWeight: FontWeight.w800,
                                fontSize: tm * 1.5)),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFormField(hm, wm, tm, hint, controller, context, lang,
      {bool? label, String? labelText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && label && labelText != null)
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: wm * 1.5, horizontal: wm * 1.5),
            child: Txt(
                text: labelText,
                style: text18white.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.9))),
          ),
        TextFormField(
          focusNode: hint == "user@gmail.com" ? f2 : f3,
          onFieldSubmitted: (val) {
            FocusScope.of(context).requestFocus(f3);
          },
          controller: controller,
          onEditingComplete: () {
            setState(() {});
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: text18white.copyWith(fontSize: tm * 1.8),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            hintText: hint,
            hintStyle: text18white.copyWith(
                fontSize: tm * 1.8, color: Colors.white.withOpacity(0.4)),
            contentPadding:
                EdgeInsets.only(left: wm * 4, bottom: hm * 2.3, top: hm * 2.3),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.1), width: wm * 0.5),
              borderRadius: BorderRadius.circular(wm * 3),
            ),
            suffixIcon: (hint == "user@gmail.com" && emailCorrect) ||
                    (hint == "ynYhs@XjfB1%" && passwordCorrect)
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : const SizedBox(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: hint == "user@gmail.com" && emailCorrect
                      ? lightBlueColor
                      : hint == "ynYhs@XjfB1%" && passwordCorrect
                          ? lightBlueColor
                          : Colors.white.withOpacity(0.1),
                  width: wm * 0.5),
              borderRadius: BorderRadius.circular(wm * 3),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: lightBlueColor, width: wm * 0.5),
              borderRadius: BorderRadius.circular(wm * 3),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: lightOrange, width: wm * 0.5),
              borderRadius: BorderRadius.circular(wm * 3),
            ),
            errorStyle:
                text18white.copyWith(fontSize: tm * 1.8, color: Colors.red),
          ),
          validator: (val) {
            print("validator");
            if (val != null) {
              if (hint == "user@gmail.com") {
                if (val.isEmpty) {
                  return lang.translate("Please enter your email address");
                } else if (!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)) {
                  return lang.translate("Use Latin keyboard");
                } else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(val)) {
                  return lang.translate('Please enter a valid email !');
                } else {
                  Future.delayed(Duration.zero, () {
                    setState(() {
                      emailCorrect = true;
                    });
                  });
                }
                return null;
              } else if (hint == "ynYhs@XjfB1%") {
                if (val.isEmpty) {
                  return lang.translate("Please enter your password");
                } else if (val.length < 8) {
                  return lang.translate("Weak");
                } else if (!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)) {
                  return lang.translate("Use Latin keyboard");
                } else {
                  Future.delayed(Duration.zero, () {
                    setState(() {
                      passwordCorrect = true;
                    });
                  });
                }
              } else if (hint == "Phone number") {
                if (val.isNotEmpty) {
                  if (!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)) {
                    return lang.translate("Use Latin keyboard");
                  }
                  if (!RegExp("^[0-9]").hasMatch(val)) {
                    return lang.translate("Only numbers are accepted");
                  }
                }
              }
            }
            return null;
          },
        ),
      ],
    );
  }
}
