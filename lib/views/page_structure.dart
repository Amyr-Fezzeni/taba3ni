import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/providers/app_provider.dart';
import 'package:taba3ni/providers/state_provider.dart';
import 'package:taba3ni/views/home/home.dart';
import 'package:taba3ni/views/localisation/localisation.dart';
import 'package:taba3ni/views/profile/profile.dart';
import 'package:taba3ni/views/search/search_screen.dart';
import 'package:taba3ni/widgets/bottom_navigation_bar.dart';

class PageStructure extends StatefulWidget {
  const PageStructure({Key? key}) : super(key: key);

  @override
  State<PageStructure> createState() => _PageStructureState();
}

class _PageStructureState extends State<PageStructure> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1))
        .then((value) => context.read<StateProvider>().changeScreen(0));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: context.watch<ThemeNotifier>().bgColor,
        body: SizedBox(
          child: Stack(
            children: [
              SizedBox(
                  height: size.height,
                  child: const [
                    HomeScreen(),
                    TrackingScreen(),
                    SearchScreen(),
                    ProfileScreen(),
                  ][context.watch<StateProvider>().currentIndex]),
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? const CustomBottomNavigationBar()
                  : const SizedBox()
            ],
          ),
        ));
  }
}
