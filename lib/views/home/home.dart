import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  bool addressSelected = false;

  late GoogleMapController mapController;
  late TextEditingController _controller;
  CameraPosition position = const CameraPosition(
    target: LatLng(47.56239938806303, 2.3078594729304314),
    zoom: 6,
  );

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
  }
Set<Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          zoomControlsEnabled: false,
          compassEnabled: false,
          initialCameraPosition: position,
          onLongPress: (LatLng l) {
            setState(() {
              _markers = {Marker(markerId: const MarkerId(""), position: l)};
              mapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: l, zoom: 15, tilt: 45)));
            });
          }),
    ));
  }
}
