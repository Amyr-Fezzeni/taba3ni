import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_provider.dart';
import '../../../providers/auth_provider.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().currentUser;
    var style = context.watch<ThemeNotifier>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        color: style.bgColor,
        elevation: 0,
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name :",
                    style: style.text18,
                  ),
                  Text(
                    user!.fullName,
                    style: style.text18,
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email :",
                    style: style.text18,
                  ),
                  Text(
                    user.email,
                    style: style.text18,
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phone number :",
                    style: style.text18,
                  ),
                  Text(
                    user.phoneNumber,
                    style: style.text18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
