import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/providers/app_provider.dart';
import 'package:taba3ni/widgets/icon_button.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();
    return Positioned(
      bottom: size.width * 0.05,
      child: Container(
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        width: size.width * 0.9,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(offset: Offset(0, 3), blurRadius: 10, color: Colors.black38)
        ], color: style.navBarColor, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            CustomIconButton(icon: Icons.home, index: 0),
            CustomIconButton(icon: Icons.moving_sharp, index: 1),
            CustomIconButton(icon: Icons.person, index: 2),
            CustomIconButton(icon: Icons.settings, index: 3),
          ],
        ),
      ),
    );
  }
}
