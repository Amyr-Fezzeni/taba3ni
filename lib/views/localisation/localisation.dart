
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
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
    CameraPosition position = CameraPosition(
      target: context.watch<UserProvider>().currentUser!.location!,
      zoom: 6,
    );

    return SizedBox(
      height: double.infinity,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: context.watch<UserProvider>().markers,
        zoomControlsEnabled: false,
        compassEnabled: false,
        initialCameraPosition: position,
      ),
    );
  }
}
