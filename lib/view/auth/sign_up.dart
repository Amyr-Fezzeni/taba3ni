import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:taba3ni/constant/size_config.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/providers/auth_provider.dart';
import 'package:taba3ni/providers/language.dart';
import 'package:taba3ni/widgets/primary_btn.dart';
import 'package:taba3ni/widgets/text_widget.dart';
import 'package:taba3ni/widgets/transparent_btn.dart';

import '../../models/user.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool nameCorrect = false;
  bool phoneCorrect = false;
  bool emailCorrect = false;
  bool passwordCorrect = false;
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();

  
  @override
  void dispose() {
    super.dispose();
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
                            text: "Sign up",
                            style: titleWhite.copyWith(fontSize: tm! * 4))),
                    Padding(
                        padding: EdgeInsets.only(
                            top: hm * 5, left: wm * 4, right: wm * 4),
                        child: textFormField(
                          hm,
                          wm,
                          tm,
                          "Oliver Cydric",
                          nameController,
                          context,
                          lang,
                          labelText: "Name",
                          label: true,
                        )),
                        Padding(
                        padding: EdgeInsets.only(
                            top: hm * 2.5, left: wm * 4, right: wm * 4),
                        child: textFormField(
                          hm,
                          wm,
                          tm,
                          "+216 54 879 235",
                          phoneController,
                          context,
                          lang,
                          labelText: "Phone number",
                          label: true,
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            top: hm * 2.5, left: wm * 4, right: wm * 4),
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
                                text: "Sign up",
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
                            function: () async {
                              if(formkey.currentState!=null && formkey.currentState!.validate()){
                                 UserModel user=UserModel(email: emailController.text,password: passwordController.text,fullName: nameController.text,phoneNumber: phoneController.text);
                                 await context.read<AuthProvider>().signUpWithMail(context, user);
                              }
                            
                            } ),
                      ),
                    ),
                    Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: wm * 15.0),
                      child: Txt(
                          text: 'Or sign up with one of the following options',
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
                                function: () async {
                                  final user = await context.read<AuthProvider>().googleLogin(context);
                                  if (user != null) {
                                    nameController.text = user.displayName ?? "";
                                    emailController.text = user.email;
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
                                text: 'Already have an account ',
                                style: text18white.copyWith(fontSize: tm * 1.5)),
                            TextSpan(
                                text: 'Log in',
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
        ),
      if(context.watch<AuthProvider>().isLoading)
      const Center(child:  CircularProgressIndicator())
      ],
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
          focusNode: hint == "Oliver Cydric"
              ? f1
              : hint == "+216 54 879 235"
                  ? f2
              : hint == "user@gmail.com"
                  ? f3
                  : f4,
          onFieldSubmitted: (val) {
            FocusScope.of(context)
                .requestFocus(hint == "Oliver Cydric" ? f2 :hint =="+216 54 879 235"? f3:f4);
          },
          controller: controller,
          onEditingComplete: () {
            print(nameCorrect);
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
            suffixIcon: (hint == "Oliver Cydric" && nameCorrect) ||
                    (hint == "user@gmail.com" && emailCorrect) ||
                    (hint == "ynYhs@XjfB1%" && passwordCorrect)||(hint == "+216 54 879 235" && phoneCorrect)
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : const SizedBox(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: hint == "Oliver Cydric" && nameCorrect
                      ? lightBlueColor
                      : hint == "user@gmail.com" && emailCorrect
                          ? lightBlueColor
                          : hint == "ynYhs@XjfB1%" && passwordCorrect
                              ? lightBlueColor
                               :hint == "+216 54 879 235" && phoneCorrect
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
          obscureText: hint == "ynYhs@XjfB1%"?true:false,
          validator: (val) {
            if (val != null) {
              if (hint == "Oliver Cydric") {
                if (val.isEmpty) {
                  return "Please enter your name";
                } else if (val.length < 2) {
                  return "Too short";
                } else if (!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)) {
                  return lang.translate("Use Latin keyboard");
                } else {
                  Future.delayed(Duration.zero, () {
                    setState(() {
                      nameCorrect = true;
                    });
                  });
                }
                return null;
              } else if (hint == "user@gmail.com") {
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
              } else if (hint == "+216 54 879 235") {
                 if (val.isEmpty) {
                  return lang.translate("Please enter your password");
                }else
                  if (!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)) {
                    return lang.translate("Use Latin keyboard");
                  }
                  else if (!RegExp("^[0-9]").hasMatch(val)) {
                    return lang.translate("Only numbers are accepted");
                  } else {
                  Future.delayed(Duration.zero, () {
                    setState(() {
                      phoneCorrect = true;
                    });
                  });
                }
              
              }
            }
          },
        ),
      ],
    );
  }
}
