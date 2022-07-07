import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taba3ni/constant/const.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/views/login/login.dart';
import 'package:taba3ni/views/login/signup.dart';
import 'package:taba3ni/widgets/primary_btn.dart';
import 'package:taba3ni/widgets/text_widget.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: SizedBox(
        height: size.height,
        child: Column(
          children: [
            Container(
              height: size.height * 0.45,
              width: size.width,
              decoration: const BoxDecoration(
                // color: Colors.amber,
                image: DecorationImage(
                    image: AssetImage("assets/images/cropped.png"),
                    fit: BoxFit.cover),
              ),
            ),
            const Spacer(),
            Txt(text: "Feel safe with us", style: titleWhite),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.07),
              child: primaryButton(
                  context: context,
                  height: 50,
                  width: 240,
                  widget: Txt(
                      text: "Get started",
                      style: text18black.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: darkBgColor)),
                  borderRadius: BorderRadius.circular(30),
                  function: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: size.height * 0.15),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Already have an account ?  ',
                        style: text18white.copyWith()),
                    TextSpan(
                        text: 'Log in',
                        style: text18white.copyWith(
                          fontSize: 18,
                          color: lightBlueColor,
                          fontWeight: FontWeight.w800,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
