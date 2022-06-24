import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/providers/language.dart';
import 'package:taba3ni/widgets/text_widget.dart';

class TextField extends StatefulWidget {
  final double tm;
  final double wm;
  final double hm;
  final bool? label;
  final String? labeText;
  final String hint;
  final TextEditingController controller;
  const TextField(
      {Key? key,
      required this.hm,
      required this.tm,
      required this.wm,
      required this.controller,
      this.label,
      this.labeText,
      required this.hint})
      : super(key: key);

  @override
  State<TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> {
  @override
  Widget build(BuildContext context) {
    // var Dlang = context.watch<LanguageProvider>();
    var lang = context.read<LanguageProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null && widget.label! && widget.labeText != null)
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: widget.wm * 1.5, horizontal: widget.wm * 1.5),
            child: Txt(
                text: widget.labeText!,
                style: text18white.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.9))),
          ),
        TextFormField(
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofocus: false,
          style: text18white.copyWith(fontSize: widget.tm * 1.8),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            hintText: widget.hint,
            hintStyle: text18white.copyWith(
                fontSize: widget.tm * 1.8,
                color: Colors.white.withOpacity(0.4)),
            contentPadding: EdgeInsets.only(
                left: widget.wm * 4,
                bottom: widget.hm * 2.3,
                top: widget.hm * 2.3),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.1), width: widget.wm * 0.5),
              borderRadius: BorderRadius.circular(widget.wm * 3),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.1), width: widget.wm * 0.5),
              borderRadius: BorderRadius.circular(widget.wm * 3),
            ),
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: lightBlueColor, width: widget.wm * 0.5),
              borderRadius: BorderRadius.circular(widget.wm * 3),
            ),
            errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: lightOrange, width: widget.wm * 0.5),
              borderRadius: BorderRadius.circular(widget.wm * 3),
            ),
          ),
          validator: (val) {
            if (val != null) {
              if (widget.hint == "Full name") {
                if (val.isEmpty) {
                  return lang.translate("Please enter your name");
                } else if (val.length < 2) {
                  return lang.translate("Too short");
                }
                if (!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)) {
                  return lang.translate("Use Latin keyboard");
                }
                return null;
              } else if (widget.hint == "Email Address") {
                if (val.isEmpty) {
                  return lang.translate("Please enter your email address");
                }
                if (!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)) {
                  return lang.translate("Use Latin keyboard");
                }
                if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(val)) {
                  return lang.translate('Please enter a valid email !');
                }
                return null;
              } else if (widget.hint == "Password") {
                if (val.isEmpty) {
                  return lang.translate("Please enter your password");
                }
                if (val.length < 8) {
                  return lang.translate("Weak");
                }
                if (!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)) {
                  return lang.translate("Use Latin keyboard");
                }
              } else if (widget.hint == "Phone number") {
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
