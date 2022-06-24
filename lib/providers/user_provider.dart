
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taba3ni/models/user.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser = UserModel(
      id: '212316546545123',
      fullName: 'Amyr fezzeni',
      email: 'anotique@gmail.com',
      phoneNumber: '54230376',
      password: 'azerty',
      location: const LatLng(47.56239938806303, 2.3078594729304314));

  setUser(UserModel user) {
    currentUser = user;
    notifyListeners();
  }

  


}
