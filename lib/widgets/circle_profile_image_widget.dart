import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/providers/app_provider.dart';

class CircleProfileImage extends StatelessWidget {
  final double size;
  final String img;
  final bool isAsset;
  const CircleProfileImage(
      {Key? key,
      required this.size,
      this.img = "assets/profile.jpg",
      this.isAsset = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = context.watch<ThemeNotifier>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 60,
        margin: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 1), blurRadius: 3, color: Colors.black12)
          ],
        ),
        child: CircleAvatar(
          backgroundColor: primaryColor,
          radius: size,
          child: isAsset
              ? CircleAvatar(
                  backgroundColor: style.bgColor,
                  backgroundImage: AssetImage(img.isEmpty? "assets/profile.jpg" : img),
                  radius: size * 0.9,
                )
              : CircleAvatar(
                  backgroundColor: style.bgColor,
                  backgroundImage: NetworkImage(img),
                  radius: size * 0.9,
                ),
        ),
      ),
    );
  }
}