import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/providers/state_provider.dart';
import 'package:taba3ni/views/home/home.dart';
import 'package:taba3ni/views/localisation/localisation.dart';
import 'package:taba3ni/views/profile/profile.dart';
import 'package:taba3ni/views/settings/settings.dart';
import 'package:taba3ni/widgets/bottom_navigation_bar.dart';

class PageStructure extends StatefulWidget {
  const PageStructure({Key? key}) : super(key: key);

  @override
  State<PageStructure> createState() => _PageStructureState();
}

class _PageStructureState extends State<PageStructure> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      child: Stack(
        children: [
          SizedBox(
              height: size.height,
              child: const [
                HomeScreen(),
                TrackingScreen(),
                ProfileScreen(),
                SettingsScreen()
              ][context.watch<StateProvider>().currentIndex]),
          const CustomBottomNavigationBar()
        ],
      ),
    ));
  }
}
