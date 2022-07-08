import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/constant/const.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/providers/auth_provider.dart';
import 'package:taba3ni/providers/user_provider.dart';
import 'package:taba3ni/views/profile/widgets/change_password.dart';
import 'package:taba3ni/views/profile/widgets/change_phone_number.dart';
import 'package:taba3ni/widgets/primary_btn.dart';
import 'package:taba3ni/widgets/text_widget.dart';

import '../../widgets/popup.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().currentUser;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          color: bgColor,
          child: Center(
              child: Column(
            children: [
              CircleAvatar(
                backgroundColor: primaryColor,
                radius: 95,
                child: user!.image!.toString().isEmpty
                    ? const CircleAvatar(
                        backgroundColor: bgColor,
                        backgroundImage: AssetImage("assets/profile.jpg"),
                        radius: 90,
                      )
                    : CircleAvatar(
                        backgroundColor: bgColor,
                        backgroundImage: NetworkImage(user.image!),
                        radius: 90,
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                color: bgColor,
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
                        style: textbody1,
                      ),
                      Text(
                        user.fullName,
                        style: textbody1,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: bgColor,
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
                        style: textbody1,
                      ),
                      Text(
                        user.email,
                        style: textbody1,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: bgColor,
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
                        style: textbody1,
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
                color: bgColor,
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
                        style: textbody1,
                      ),
                      CupertinoSwitch(
                          activeColor: primaryColor,
                          value: true,
                          onChanged: (value) => false),
                    ],
                  ),
                ),
              ),
              Card(
                color: bgColor,
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
                        style: textbody1,
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
                          color: darkBgColor)),
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