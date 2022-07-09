import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/constant/const.dart';
import 'package:taba3ni/providers/app_provider.dart';
import 'package:taba3ni/views/home/widgets/emergency.dart';
import 'package:taba3ni/views/home/widgets/get_home_safe_widget.dart';
import 'package:taba3ni/views/home/widgets/search_widget.dart';
import 'package:taba3ni/views/home/widgets/send_alert.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();
    return Container(
      height: size.height,
      width: size.width,
      color: style.bgColor,
      child: SingleChildScrollView(
        child: Column(
          children: const [
            SearchWidget(),
            SizedBox(
              height: 50,
            ),
            EmergencyWidget(),
            SendAlertWidget(),
            GetHomeWidget(),
          ],
        ),
      ),
    );
  }
}
