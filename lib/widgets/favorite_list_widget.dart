import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/models/user.dart';
import 'package:taba3ni/providers/app_provider.dart';
import 'package:taba3ni/providers/user_provider.dart';
import 'package:taba3ni/services/user_service.dart';
import 'package:taba3ni/widgets/circle_profile_image_widget.dart';
import 'package:taba3ni/widgets/text_widget.dart';

class FavoriteListWidget extends StatelessWidget {
  const FavoriteListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Txt(
                  text: "Favorite",
                  style: style.text18.copyWith(fontWeight: FontWeight.bold)),
            )),
        Container(
          padding: const EdgeInsets.only(left: 0),
          width: size.width,
          height: 100,
          child: context
                  .read<UserProvider>()
                  .currentUser!
                  .sharedLocation
                  .isEmpty
              ? null
              : StreamBuilder(
                  stream: UserService.collection
                      .where("id",
                          whereIn: context
                              .read<UserProvider>()
                              .currentUser!
                              .sharedLocation)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      List<dynamic> users = snapshot.data.docs
                          .map((e) => UserModel.fromMap(e.data()))
                          .toList();
                      return ListView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 15, bottom: 15, left: 20),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90),
                                  border: Border.all(
                                      color:
                                          style.invertedColor.withOpacity(0.5),
                                      width: 3)),
                              child: InkWell(
                                onTap: () {
                                  log("add favorite");
                                },
                                child: Icon(
                                  Icons.add,
                                  color: style.invertedColor.withOpacity(0.6),
                                  size: 35,
                                ),
                              ),
                            ),
                            ...users
                                .map((user) => CircleProfileImage(
                                      size: 35,
                                      img: user.image,
                                    ))
                                .toList(),
                          ]);
                    } else {
                      return Container(
                        margin: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 20),
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            border: Border.all(
                                color: style.invertedColor.withOpacity(0.5),
                                width: 3)),
                        child: InkWell(
                          onTap: () {
                            log("add favorite");
                          },
                          child: Icon(
                            Icons.add,
                            color: style.invertedColor.withOpacity(0.6),
                            size: 35,
                          ),
                        ),
                      );
                    }
                  }),
        ),
      ],
    );
  }
}
