import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
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
    setMarker();
    // BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(),
    //   "assets/person.png",
    // ).then((icon) {
    //   _markers = {
    //     Marker(
    //         markerId: const MarkerId("sss"),
    //         position: context.read<UserProvider>().currentUser!.location!,
    //         infoWindow: const InfoWindow(
    //           title: '',
    //           snippet: '',
    //         ),
    //         icon: icon)
    //   };
    //   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //       target: context.read<UserProvider>().currentUser!.location!,
    //       zoom: 15,
    //       tilt: 45)));
    //   setState(() {
    //     log("message");
    //   });
    // });
  }

  late GoogleMapController mapController;

  Set<Marker> markers = {};
  setMarker() async {
    var iconurl =
        "https://s3-us-west-2.amazonaws.com/api.starngage.media.profile/106488794_288278445755009_2092623715148892464_n.jpg";
    var request = await http.get(Uri.parse(iconurl));
    Uint8List dataBytes = request.bodyBytes;

    setState(() {
      markers.add(Marker(
        icon: BitmapDescriptor.fromBytes(dataBytes.buffer.asUint8List()),
        markerId: MarkerId(context.read<UserProvider>().currentUser!.location!.toString()),
        position: context.read<UserProvider>().currentUser!.location!,
        infoWindow: const InfoWindow(
          title: "title",
          snippet: "My Position",
        ),
      ));
      mapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: context.read<UserProvider>().currentUser!.location!, zoom: 15, tilt: 45)));
    });
    
  }

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
          markers: markers,
          zoomControlsEnabled: false,
          compassEnabled: false,
          initialCameraPosition: position,
          ),
    );
  }
}
