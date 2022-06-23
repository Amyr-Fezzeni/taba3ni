// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  String? id;
  String fullName;
  String email;
  String phoneNumber;
  String password;
  String? image;
  LatLng? location;
  DateTime? lastLoggedIn;
  DateTime? lastUpdateLocation;
  bool isLoggedIn;
  bool locationActivated;
  User({
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.location,
    this.lastLoggedIn,
    this.image,
    this.lastUpdateLocation,
    this.isLoggedIn = false,
    this.locationActivated = false,
  });

  @override
  String toString() {
    return 'User(id: $id, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, image: $image, password: $password, location: $location, lastLoggedIn: $lastLoggedIn, lastUpdateLocation: $lastUpdateLocation, isLoggedIn: $isLoggedIn, locationActivated: $locationActivated)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'location': location,
      'image': image,
      'lastLoggedIn': lastLoggedIn?.millisecondsSinceEpoch,
      'lastUpdateLocation': lastUpdateLocation?.millisecondsSinceEpoch,
      'isLoggedIn': isLoggedIn,
      'locationActivated': locationActivated,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as String : null,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      password: map['password'] as String,
      location: map['location'],
      image: map['image'],
      lastLoggedIn: map['lastLoggedIn'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastLoggedIn'] as int)
          : null,
      lastUpdateLocation: map['lastUpdateLocation'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['lastUpdateLocation'] as int)
          : null,
      isLoggedIn: map['isLoggedIn'] as bool,
      locationActivated: map['locationActivated'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
