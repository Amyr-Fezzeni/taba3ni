import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/providers/app_provider.dart';
import 'package:taba3ni/widgets/circle_profile_image_widget.dart';
import 'package:taba3ni/widgets/text_widget.dart';

class ConnectionListWidget extends StatelessWidget {
  const ConnectionListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Txt(
                  text: "Connections",
                  style: style.text18.copyWith(fontWeight: FontWeight.bold)),
            )),
        Container(
          padding: const EdgeInsets.only(left: 0),
          width: size.width,
          height: 100,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              ...List.generate(
                  7, (index) => const CircleProfileImage(size: 35)),
            ],
          ),
        ),
      ],
    );
  }
}
