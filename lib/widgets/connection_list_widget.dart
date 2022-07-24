import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/models/user.dart';
import 'package:taba3ni/providers/app_provider.dart';
import 'package:taba3ni/providers/user_provider.dart';
import 'package:taba3ni/services/user_service.dart';
import 'package:taba3ni/views/profile/public_profile.dart';
import 'package:taba3ni/widgets/circle_profile_image_widget.dart';
import 'package:taba3ni/widgets/text_widget.dart';

class ConnectionListWidget extends StatelessWidget {
  const ConnectionListWidget({Key? key}) : super(key: key);

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
                  text: "Connections",
                  style: style.text18.copyWith(fontWeight: FontWeight.bold)),
            )),
        Container(
          padding: const EdgeInsets.only(left: 0),
          width: size.width,
          height: 90,
          child: context.read<UserProvider>().currentUser!.followed.isEmpty
              ? null
              : StreamBuilder(
                  stream: UserService.collection
                      .where("id",
                          whereIn: context
                              .watch<UserProvider>()
                              .currentUser!
                              .followed)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      List<dynamic> users = snapshot.data.docs
                          .map((e) => UserModel.fromMap(e.data()))
                          .toList();
                      return ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: users
                            .map((user) => InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PublicProfileScreen(user: user))),
                                  child: CircleProfileImage(
                                    size: 70,
                                    img: user.image,
                                  ),
                                ))
                            .toList(),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
        ),
      ],
    );
  }
}
