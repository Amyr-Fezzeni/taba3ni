import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/models/user.dart';
import 'package:taba3ni/providers/app_provider.dart';
import 'package:taba3ni/services/user_service.dart';
import 'package:taba3ni/widgets/circle_profile_image_widget.dart';
import '../../providers/user_provider.dart';

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
          context.watch<UserProvider>().currentUser!.sharedLocation.isEmpty
              ? const SizedBox()
              : Positioned(
                  left: 0,
                  bottom: 70,
                  child: StreamBuilder(
                    stream: UserService.collection
                        .where("id",
                            whereIn: context
                                .read<UserProvider>()
                                .currentUser!
                                .sharedLocation)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        List<dynamic> users = snapshot.data.docs;
                        return Container(
                          padding: const EdgeInsets.only(left: 0),
                          width: size.width,
                          height: 100,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              UserModel user =
                                  UserModel.fromMap(users[index].data());
                              return InkWell(
                                onTap: () => context
                                    .read<UserProvider>()
                                    .locateUser(user),
                                child: CircleProfileImage(
                                  size: 35,
                                  isAsset: false,
                                  img: user.image.isNotEmpty ? user.image : "",
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  )),
        ],
      ),
    );
  }
}
