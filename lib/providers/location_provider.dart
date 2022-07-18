import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taba3ni/services/BackGroundLocator/location_callback_handler.dart';
import 'package:taba3ni/services/BackGroundLocator/location_service_repository.dart';
import 'package:taba3ni/services/user_service.dart';

class LocationProvider with ChangeNotifier{
   ReceivePort port = ReceivePort();
   
 //******************************** Listen location ************************************************/
  initBackGroundLoc() {
    if (IsolateNameServer.lookupPortByName(LocationServiceRepository.isolateName) != null) {
      IsolateNameServer.removePortNameMapping(LocationServiceRepository.isolateName);
    }
    BackgroundLocator.unRegisterLocationUpdate();
    IsolateNameServer.registerPortWithName(port.sendPort, LocationServiceRepository.isolateName);
    port.listen((dynamic currentLocation) {
      if (currentLocation.accuracy < 700) {
       LatLng current =  LatLng(currentLocation.latitude, currentLocation.longitude);
       // update user's current location
      }
    });
    initPlatformState();
  }

   Future<void> initPlatformState() async {
    await BackgroundLocator.initialize();
    final _isRunning = await BackgroundLocator.isServiceRunning();
    log('Running ${_isRunning.toString()}');
  }
//*********************************** when user clicks on share location  *******************************/
    startBackgroundLocatorService() async {
     if (!await UserService.checkLocationPermission()) {
        return null;
      }
      _startLocator();
  }
  //*********************************** when user clicks on stop sharing location  *******************************/
   onStop() async {
    BackgroundLocator.unRegisterLocationUpdate();
  }

   _startLocator() {
    BackgroundLocator.unRegisterLocationUpdate();
    BackgroundLocator.registerLocationUpdate(LocationCallbackHandler.callback,
        iosSettings: const IOSSettings(
            accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 0),
        autoStop: false,
        androidSettings: const AndroidSettings(
            accuracy: LocationAccuracy.NAVIGATION,
            interval: 1,
            distanceFilter: 0,
            client: LocationClient.google,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'Start Location Tracking',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                'Background location is on to keep the app up-to-date with your location. This is required for main features to work properly when the app is not running.',
                notificationIconColor: Colors.grey,
                notificationTapCallback:
                LocationCallbackHandler.notificationCallback)));
  }
}