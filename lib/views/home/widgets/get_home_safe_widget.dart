import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taba3ni/constant/style.dart';

class GetHomeWidget extends StatelessWidget {
  const GetHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => log("get home safe"),
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(offset: Offset(0, 3), blurRadius: 10, color: Colors.black38)
        ], borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get Home Safe",
                  style: text18black.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  "Share Location Periodically",
                  style: text18black.copyWith(fontWeight: FontWeight.w200),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 70,
              width: 70,
              child: Image.asset(
                "assets/images/safe.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
