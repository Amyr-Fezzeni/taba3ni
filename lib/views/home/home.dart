import 'package:flutter/material.dart';
import 'package:taba3ni/constant/const.dart';
import 'package:taba3ni/views/home/widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: bgColor,
      child: SingleChildScrollView(
        child: Column(
          children: const [SearchWidget()],
        ),
      ),
    );
  }
}
