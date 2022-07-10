import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/providers/auth_provider.dart';
import 'package:taba3ni/providers/user_provider.dart';
import 'package:taba3ni/views/settings/widgets/change_password.dart';
import 'package:taba3ni/views/settings/widgets/change_phone_number.dart';
import 'package:taba3ni/widgets/primary_btn.dart';
import 'package:taba3ni/widgets/text_widget.dart';

import '../../providers/app_provider.dart';
import '../../widgets/popup.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().currentUser;
    var style = context.watch<ThemeNotifier>();
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          color: style.bgColor,
          child: Center(
              child: Column(
            children: [
              CircleAvatar(
                backgroundColor: primaryColor,
                radius: 95,
                child: user!.image!.toString().isEmpty
                    ? CircleAvatar(
                        backgroundColor: style.bgColor,
                        backgroundImage: const AssetImage("assets/profile.jpg"),
                        radius: 90,
                      )
                    : CircleAvatar(
                        backgroundColor: style.bgColor,
                        backgroundImage: NetworkImage(user.image!),
                        radius: 90,
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                color: style.bgColor,
                elevation: 3,
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name :",
                        style: style.text18,
                      ),
                      Text(
                        user.fullName,
                        style: style.text18,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: style.bgColor,
                elevation: 3,
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
              ),
              Card(
                color: style.bgColor,
                elevation: 3,
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Phone number :",
                        style: style.text18,
                      ),
                      TextButton(
                          onPressed: () async {
                            await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) =>
                                    const ChangePhoneNumber());
                          },
                          child: Text(
                            context
                                .watch<UserProvider>()
                                .currentUser!
                                .phoneNumber
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: primaryColor),
                          )),
                    ],
                  ),
                ),
              ),
              Card(
                color: style.bgColor,
                elevation: 3,
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dark mode :",
                        style: style.text18,
                      ),
                      CupertinoSwitch(
                          activeColor: primaryColor,
                          value: style.darkMode,
                          onChanged: (value) => context
                              .read<ThemeNotifier>()
                              .changeDarkMode(value)),
                    ],
                  ),
                ),
              ),
              Card(
                color: style.bgColor,
                elevation: 3,
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Password :",
                        style: style.text18,
                      ),
                      TextButton(
                          onPressed: () async {
                            await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => const ChangePassword());
                          },
                          child: Text(
                            "Change Password",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: primaryColor),
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              primaryButton(
                  context: context,
                  height: 50,
                  width: 260,
                  widget: Txt(
                      text: "Logout",
                      style: text18black.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: style.bgColor)),
                  borderRadius: BorderRadius.circular(30),
                  function: () async => await popup(context, "Ok",
                      title: "Notification",
                      confirmFunction: () =>
                          context.read<AuthProvider>().logOut(context),
                      description: "Are you sure you want to log out ?")),
            ],
          )),
        ),
      ),
    );
  }
}
