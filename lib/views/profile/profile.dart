import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/providers/app_provider.dart';
import 'package:taba3ni/providers/auth_provider.dart';
import 'package:taba3ni/widgets/text_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().currentUser;
    var style = context.watch<ThemeNotifier>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          color: style.bgColor,
          child: Center(
              child: Column(
            children: [
              Container(
                height: size.height * 0.4,
                width: size.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0.4,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            image: DecorationImage(
                                image: NetworkImage(user!.image!),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black87])),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 95,
                        child: user.image!.toString().isEmpty
                            ? CircleAvatar(
                                backgroundColor: style.bgColor,
                                backgroundImage:
                                    const AssetImage("assets/profile.jpg"),
                                radius: 90,
                              )
                            : CircleAvatar(
                                backgroundColor: style.bgColor,
                                backgroundImage: NetworkImage(user.image!),
                                radius: 90,
                              ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        child: SizedBox(
                          width: size.width,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Txt(
                                      text: user.followed.length.toString(),
                                      style: style.text18
                                          .copyWith(color: Colors.white38)),
                                  Txt(
                                      text: "Connections",
                                      style: style.text18.copyWith(
                                          fontSize: 15, color: Colors.white70)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Txt(
                                      text:
                                          user.sharedLocation.length.toString(),
                                      style: style.text18
                                          .copyWith(color: Colors.white70)),
                                  Txt(
                                      text: "Favorites",
                                      style: style.text18.copyWith(
                                          fontSize: 15, color: Colors.white38)),
                                ],
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.edit,
                      color: style.invertedColor,
                      size: 35,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: style.bgColor,
                  elevation: 0,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
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
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
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
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
