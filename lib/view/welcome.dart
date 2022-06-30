// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taba3ni/constant/size_config.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/view/auth/login.dart';
import 'package:taba3ni/view/auth/sign_up.dart';
import 'package:taba3ni/widgets/primary_btn.dart';
import 'package:taba3ni/widgets/text_widget.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hm = SizeConfig.heightMultiplier;
    var wm = SizeConfig.widthMultiplier;
    var tm = SizeConfig.textMultiplier;
    return Scaffold(
      backgroundColor: darkBgColor,
      body: Stack(
        children: [
          Positioned(
            height: hm!*90,
          //  width: wm!*10,
            child: Container(
              height: hm*50,
              width: wm!*100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/cropped.png"),fit: BoxFit.cover),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: hm*55,),
              Padding(padding: EdgeInsets.symmetric(horizontal: wm*10),child:
              Txt(text: "Feel safe with us", style:titleWhite.copyWith(fontSize:tm!*4.3 )) 
              ),
              Padding(
                padding:  EdgeInsets.only(top:wm*10.0),
                child: primaryButton(context:context,height: hm*7,width: wm*50,widget: Txt(text: "Get started", style: text18black.copyWith(fontWeight: FontWeight.w800,fontSize: tm*2.1,color:darkBgColor )),borderRadius: BorderRadius.circular(wm*30),function: ()=> Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const SignUpScreen()),
                  )),
              ),
              Padding(
                  padding:  EdgeInsets.only(top:wm*4.0),
                child: RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
                text: 'Already have an account ',
                style: text18white.copyWith(fontSize: tm*1.5)),
          TextSpan(text: 'Log in',style: text18white.copyWith(color:lightBlueColor,fontWeight: FontWeight.w800 ,fontSize: tm*1.5), recognizer:  TapGestureRecognizer()..onTap = () => Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const LoginScreen()),
                  )),
        ],
      ),
    ),
              )

              
            ],
          )

        ],
      ),
    );
  }
}
