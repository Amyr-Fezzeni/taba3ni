import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/constant/size_config.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/providers/language.dart';
import 'package:taba3ni/widgets/text_widget.dart';
class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String hint;
  final TextEditingController controller;
  const CustomTextField(
      {Key? key,
      required this.controller,
      this.labelText,
      required this.hint})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool correct = false;
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  @override
  Widget build(BuildContext context) {
    var hm = SizeConfig.heightMultiplier;
    var wm = SizeConfig.widthMultiplier;
    var tm = SizeConfig.textMultiplier;
    var lang = context.read<LanguageProvider>();
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ( widget.labelText != null)
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: wm! * 1.5, horizontal: wm * 1.5),
            child: Txt(
                text: widget.labelText!,
                style: text18white.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.9))),
          ),
        TextFormField(
          focusNode: widget.hint == "Oliver Cydric"
              ? f1
              :widget. hint == "+216 54 879 235"
                  ? f2
              : widget.hint == "user@gmail.com"
                  ? f3
                  : f4,
          onFieldSubmitted: (val) {
            FocusScope.of(context)
                .requestFocus(widget.hint == "Oliver Cydric" ? f2 :widget.hint =="+216 54 879 235"? f3:f4);
          },
          controller: widget.controller,
          onEditingComplete: () {
          
            setState(() {});
          },
          maxLength: widget.hint == "+216 54 879 235"?12:null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: text18white.copyWith(fontSize: tm! * 1.8),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            hintText:widget.hint,
            hintStyle: text18white.copyWith(
                fontSize: tm * 1.8, color: Colors.white.withOpacity(0.4)),
            contentPadding:
                EdgeInsets.only(left: wm! * 4, bottom: hm! * 2.3, top: hm * 2.3),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.1), width: wm * 0.5),
              borderRadius: BorderRadius.circular(wm * 3),
            ),
            suffixIcon: correct? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : const SizedBox(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: correct
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
          obscureText: widget.hint == "ynYhs@XjfB1%"?true:false,
          validator: (val) {
            if (val != null) {
              if (widget.hint == "Oliver Cydric") {
                if (val.isEmpty) {
                  return "Please enter your name";
                } else if (val.length < 2) {
                  return "Too short";
                } else if (!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)) {
                  return lang.translate("Use Latin keyboard");
                } else {
                  Future.delayed(Duration.zero, () {
                    setState(() {
                      correct = true;
                    });
                  });
                }
                return null;
              } else if (widget.hint == "user@gmail.com") {
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
                      correct = true;
                    });
                  });
                }
                return null;
              } else if (widget.hint == "ynYhs@XjfB1%") {
                if (val.isEmpty) {
                  return lang.translate("Please enter your password");
                } else if (val.length < 8) {
                  return lang.translate("Weak");
                } else if (!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)) {
                  return lang.translate("Use Latin keyboard");
                } else {
                  Future.delayed(Duration.zero, () {
                    setState(() {
                      correct = true;
                    });
                  });
                }
              } else if (widget.hint == "+216 54 879 235") {
                 if (val.isEmpty) {
                  return lang.translate("Please enter your phone number");
                }else
                  if (!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)) {
                    return lang.translate("Use Latin keyboard");
                  }
                  else if (!RegExp("^[0-9]").hasMatch(val)) {
                    return lang.translate("Only numbers are accepted");
                  } else if(val.length<8) {
                     return lang.translate("Please enter a valid phone number");
                  }else{
                  Future.delayed(Duration.zero, () {
                    setState(() {
                      correct = true;
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