import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taba3ni/constant/style.dart';

class SendAlertWidget extends StatelessWidget {
  const SendAlertWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => log("Send Alert"),
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 3), blurRadius: 10, color: Colors.black38)
            ],
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(255, 131, 0, 0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Send Alert to your Close one",
                  style: text18white.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  "Share your Location ",
                  style: text18white.copyWith(fontWeight: FontWeight.w200),
                ),
              ],
            ),
            const Spacer(),
            Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: const Icon(
                  Icons.health_and_safety_sharp,
                  color: Colors.red,
                  size: 50,
                )),
          ],
        ),
      ),
    );
  }
}
