import 'dart:developer';

import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/models/user.dart';
import 'package:taba3ni/services/logic_service.dart';
import 'package:taba3ni/services/shared_data.dart';
import 'package:taba3ni/services/user_service.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;
  bool isNotificationOn = true;
  bool isLoading = false;
  Set<Marker> markers = {};

  setMarker() async {
    markers = {};
    BitmapDescriptor icon = currentUser!.image.isNotEmpty
        ? await MarkerIcon.downloadResizePictureCircle(currentUser!.image,
            size: 150,
            addBorder: true,
            borderColor: primaryColor,
            borderSize: 15)
        : await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(50, 50)),
            "assets/profile.png",
          );
    markers.add(Marker(
      icon: icon,
      markerId: MarkerId(currentUser!.id!),
      position: await UserService.getUserCurrentLocation(),
      infoWindow: InfoWindow(
        title: currentUser!.fullName.toString(),
        snippet: getLastTimeUpdated(currentUser!.lastUpdateLocation),
      ),
    ));

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentUser!.location!, zoom: 15, tilt: 45)));
    notifyListeners();
  }

  late GoogleMapController mapController;
  setMapController(controller) {
    mapController = controller;
    notifyListeners();
  }

  setUser(UserModel user) async {
    currentUser = user;
    log("user set done! ${user.email}");
    notifyListeners();
    currentUser!.location = await UserService.getUserCurrentLocation();
    if (user.id != null) DataPrefrences.setId(user.id!);
    DataPrefrences.setLogin(user.email);
    DataPrefrences.setPassword(user.password);

    notifyListeners();
  }

  remodeData() {
    currentUser = null;
    markers = {};
  }

  changePassword(BuildContext context, String pass) {}

  changePhoneNumber(BuildContext context, String phone) {}

  Future<void> updateUser() async {
    currentUser =
        await UserService.getUser(currentUser!.email, currentUser!.password);
    notifyListeners();
  }
}
