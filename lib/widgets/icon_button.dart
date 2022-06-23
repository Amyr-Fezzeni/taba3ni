import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/providers/state_provider.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final int index;
  const CustomIconButton({Key? key, required this.icon, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = context.watch<StateProvider>().currentIndex == index;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // boxShadow: const [
        //   BoxShadow(color: Color.fromARGB(255, 61, 95, 246), blurRadius: 12)
        //]
      ),
      child: InkWell(
        onTap: () => context.read<StateProvider>().changeScreen(index),
        child: Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.white,
        ),
      ),
    );
  }
}
