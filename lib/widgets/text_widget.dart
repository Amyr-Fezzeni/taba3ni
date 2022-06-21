
import 'package:flutter/cupertino.dart';
import 'package:provider/src/provider.dart';
import 'package:taba3ni/constant/lang.dart';
import 'package:taba3ni/providers/language.dart';

class Txt extends StatefulWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? textScaleFactor;
  final TextOverflow? overflow;
  const Txt({Key? key,required this.text,required this.style, this.textAlign,this.maxLines,this.textScaleFactor,this.overflow}) : super(key: key);

  @override
  State<Txt> createState() => _TxtState();
}

class _TxtState extends State<Txt> {
  @override
  Widget build(BuildContext context) {
    var lang=context.read<LanguageProvider>();
    var Vlang=context.watch<LanguageProvider>();
    return Text(
      Vlang.currentLanguage==en?widget.text:lang.translate(widget.text),textAlign: widget.textAlign,maxLines: widget.maxLines,textScaleFactor:widget.textScaleFactor,overflow: widget.overflow
        ,style: widget.style
    );
  }
}
