import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/models/user.dart';
import 'package:taba3ni/providers/app_provider.dart';
import 'package:taba3ni/services/user_service.dart';
import 'package:taba3ni/widgets/circle_profile_image_widget.dart';
import '../../providers/user_provider.dart';
import 'dart:ui' as ui;

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  void _onMapCreated(GoogleMapController controller) {
    context.read<UserProvider>().setMapController(controller);
    if (context.read<UserProvider>().currentUser == null) return;
    if (context.read<UserProvider>().currentUser?.location == null) return;
    context.read<UserProvider>().setMarker();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();

    return SizedBox(
      child: Stack(
        children: [
          SizedBox(
            height: size.height,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              markers: context.watch<UserProvider>().markers,
              zoomControlsEnabled: false,
              compassEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: context.watch<UserProvider>().currentUser!.location!,
                zoom: 6,
              ),
            ),
          ),
          context.watch<UserProvider>().currentUser!.followed.isEmpty
              ? const SizedBox()
              : Positioned(
                  left: size.width * 0.05,
                  bottom: 90,
                  child: StreamBuilder(
                    stream: UserService.collection
                        .where("id",
                            whereIn: context
                                .read<UserProvider>()
                                .currentUser!
                                .followed)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        List<dynamic> users = snapshot.data.docs
                            .map((e) => UserModel.fromMap(e.data()))
                            .toList();
                        return bluryContainer(
                            width: size.width * 0.9,
                            color: darkBgColor.withOpacity(0.2),
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
                                MapUserIcon(
                                    user: context
                                        .read<UserProvider>()
                                        .currentUser!,
                                    context: context),
                                ...users.map((user) =>
                                    MapUserIcon(user: user, context: context))
                              ],
                            ));
                      }
                      return const SizedBox();
                    },
                  )),
        ],
      ),
    );
  }

  Widget MapUserIcon({required UserModel user, required BuildContext context}) {
    return InkWell(
      onTap: () => context.read<UserProvider>().locateUser(user),
      child: CircleProfileImage(
        size: 35,
        isAsset: false,
        img: user.image.isNotEmpty ? user.image : "",
      ),
    );
  }
}

Widget bluryContainer({required double width, required color, required child}) {
  return SizedBox(
    height: 90,
    child: Container(
        width: width,
        height: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: color),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
          child: child,
        )),
  );
}
