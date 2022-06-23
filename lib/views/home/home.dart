import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/constant/const.dart';
import 'package:taba3ni/providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Set<Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            Center(
              child: Text("data"),
            ),
            Container(
              height: 300,
              width: 200,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                // markers: _markers,
                zoomControlsEnabled: false,
                compassEnabled: false,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(47.56239938806303, 2.3078594729304314),
                  zoom: 6,
                ),
              ),
            ),
          ],
        ));
  }
}
