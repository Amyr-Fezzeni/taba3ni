import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taba3ni/constant/const.dart';
import 'package:taba3ni/models/user.dart';
import 'package:taba3ni/services/logic_service.dart';
import 'package:taba3ni/services/shared_data.dart';
import 'package:taba3ni/services/user_service.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;

  bool isLoading = false;
  Set<Marker> markers = {};

  setMarker() async {
    bool userHasImage = currentUser!.image!.isNotEmpty;

    BitmapDescriptor networkimage =
        await MarkerIcon.downloadResizePictureCircle(currentUser!.image!,
            size: 200,
            addBorder: true,
            borderColor: primaryColor,
            borderSize: 15);

    BitmapDescriptor defaultMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(50, 50)),
      "assets/profile.png",
    );

    markers.add(Marker(
      icon: userHasImage
          ? networkimage

          // ? BitmapDescriptor.fromBytes(dataBytes.buffer.asUint8List())
          : defaultMarker,
      markerId: MarkerId(currentUser!.id!),
      position: await UserService.getUserCurrentLocation(),
      infoWindow: InfoWindow(
        title: currentUser!.fullName.toString(),
        snippet: getLastTimeUpdated(currentUser!.lastUpdateLocation),
      ),
    ));
    notifyListeners();
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentUser!.location!, zoom: 15, tilt: 45)));
  }

  late GoogleMapController mapController;
  setMapController(controller) {
    mapController = controller;
    notifyListeners();
  }

  setUser(UserModel user) async {
    currentUser = user;
    currentUser!.location = await UserService.getUserCurrentLocation();
    if (user.id != null) DataPrefrences.setId(user.id!);
    DataPrefrences.setLogin(user.email);
    DataPrefrences.setPassword(user.password);
    notifyListeners();
  }

  changePassword(BuildContext context, String pass) {}

  changePhoneNumber(BuildContext context, String phone) {}
}
