import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/models/user.dart';
import 'package:taba3ni/services/logic_service.dart';
import 'package:taba3ni/services/shared_data.dart';
import 'package:taba3ni/services/user_service.dart';
import 'package:taba3ni/widgets/popup.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;
  bool isNotificationOn = true;
  bool isLoading = false;
  bool isLoadingSecond = false;
  Set<Marker> markers = {};

  setMarker() async {
    await updateUser();
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
      position: currentUser!.location!,
      onTap: () => mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: currentUser!.location!, zoom: 15, tilt: 45))),
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
    if (user.id != null) DataPrefrences.setId(user.id!);
    DataPrefrences.setLogin(user.email);
    DataPrefrences.setPassword(user.password);
  }

  locateUser(UserModel user) async {
    markers.removeWhere((element) => element.markerId == MarkerId(user.id!));
    BitmapDescriptor icon = user.image.isNotEmpty
        ? await MarkerIcon.downloadResizePictureCircle(user.image,
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
      markerId: MarkerId(user.id!),
      position: user.location!,
      onTap: () => mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: user.location!, zoom: 15, tilt: 45))),
      infoWindow: InfoWindow(
        title: user.fullName.toString(),
        snippet: getLastTimeUpdated(user.lastUpdateLocation),
      ),
    ));

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: user.location!, zoom: 15, tilt: 45)));
    notifyListeners();
  }

  remodeData() {
    currentUser = null;
    markers = {};
  }

  changePassword(BuildContext context, String pass) {}

  changePhoneNumber(BuildContext context, String phone) {}

  addFollow(BuildContext context, UserModel user) async {
    isLoading = true;
    notifyListeners();
    await UserService.addFollow(currentUser!, user);
    isLoading = false;
    updateUser();
  }

  removeFollow(BuildContext context, UserModel user) async {
    isLoading = true;
    notifyListeners();
    final result = await UserService.removeFollow(currentUser!, user);
    popup(context, "Ok",
        description: result ? "Frind removed" : "Try again later");
    isLoading = false;
    updateUser();
  }

  addRequest(BuildContext context, String id) async {
    isLoading = true;
    notifyListeners();
    final result = await UserService.addRequest(currentUser!, id);
    popup(context, "Ok",
        description: result ? "Request sent" : "Try again later");
    isLoading = false;
    updateUser();
  }

  removeRequest(BuildContext context,
      {required UserModel sender, required String user}) async {
    isLoading = true;
    notifyListeners();
    await UserService.removeRequest(sender, user);
    isLoading = false;
    updateUser();
  }

  addFavorite(BuildContext context, String id) async {
    isLoading = true;
    notifyListeners();
    currentUser!.followed.add(id);
    final result = await UserService.updateFavorite(currentUser!);
    popup(context, "Ok",
        description:
            result ? "Now you both share locations" : "Try again later");
    isLoading = false;
    updateUser();
  }

  removeFavorite(BuildContext context, String id) async {
    isLoading = true;
    notifyListeners();
    currentUser!.followed.remove(id);
    final result = await UserService.updateFavorite(currentUser!);
    popup(context, "Ok",
        description: result ? "Location desactivated" : "Try again later");
    isLoading = false;
    updateUser();
  }

  addBlock(BuildContext context, String id) async {
    isLoadingSecond = true;
    notifyListeners();
    currentUser!.baned.add(id);
    final result = await UserService.updateBlock(currentUser!);
    popup(context, "Ok",
        description: result ? "User Blocked" : "Try again later");
    isLoadingSecond = false;
    updateUser();
  }

  removeBlock(BuildContext context, String id) async {
    isLoadingSecond = true;
    notifyListeners();
    currentUser!.baned.remove(id);
    final result = await UserService.updateBlock(currentUser!);
    popup(context, "Ok",
        description: result ? "User Unblocked" : "Try again later");
    isLoadingSecond = false;
    updateUser();
  }

  Future<void> updateUser() async {
    await UserService.updateLocation(
        currentUser!, await UserService.getUserCurrentLocation());
    currentUser =
        await UserService.getUser(currentUser!.email, currentUser!.password);
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> stream = UserService.collection
      .where("id", isEqualTo: "62c94fec2250c5e3ecf8ff55")
      .snapshots();
  d() {
    stream.listen((event) {}).onData((data) {
      currentUser = UserModel.fromMap(data.docChanges.first.doc.data()!);
      notifyListeners();
    });
  }
}
