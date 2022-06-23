import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/constant/const.dart';

import '../../providers/user_provider.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    if (context.read<UserProvider>().currentUser == null) return;
    if (context.read<UserProvider>().currentUser?.location == null) return;

    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/person.png",
    ).then((icon) {
      _markers = {
        Marker(
            markerId: const MarkerId("sss"),
            position: context.read<UserProvider>().currentUser!.location!,
            infoWindow: const InfoWindow(
              title: '',
              snippet: '',
            ),
            icon: icon)
      };
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: context.read<UserProvider>().currentUser!.location!,
          zoom: 15,
          tilt: 45)));
      setState(() {
        log("message");
      });
    });
  }

  late GoogleMapController mapController;

  Set<Marker> _markers = {};
  
  @override
  Widget build(BuildContext context) {
    CameraPosition position = CameraPosition(
      target: context.watch<UserProvider>().currentUser!.location!,
      zoom: 6,
    );
    
    return SizedBox(
      height: double.infinity,
      child: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          zoomControlsEnabled: false,
          compassEnabled: false,
          initialCameraPosition: position,
          onLongPress: (LatLng l) {
            setState(() {
              BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(),
                "assets/person.png",
              ).then((icon) {
                _markers = {
                  Marker(
                      markerId: const MarkerId("ss"),
                      position: context
                          .read<UserProvider>()
                          .currentUser!
                          .location!,
                      icon: icon)
                };
              });
              mapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: l, zoom: 15, tilt: 45)));
            });
          }),
    );
  }
}
