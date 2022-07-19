import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:taba3ni/models/user.dart';
import 'package:taba3ni/services/user_service.dart';

class DataProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController(text: '');
  List<UserModel> searchUsers = [];
  String search = "";

  updateSearch(String value) async {
    log("update search :$value");
    search = value;
    if (value.isEmpty) searchUsers = [];
    if (value.isNotEmpty) searchUsers = await getUsersByName(value);
    log(searchUsers.length.toString());
    notifyListeners();
  }

  clearSearch(BuildContext context) {
    search = "";
    searchController.clear();
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  Future<List<UserModel>> getUsersByName(String value) async {
    List<UserModel> users = [];
    final data = await UserService.getUsersByName(value);
    log("data : ${data.length}");
    log("amyr".contains("amyb").toString());
    for (var item in data) {
      if (item['fullName']
          .toString()
          .toLowerCase()
          .contains(value.toLowerCase())) {
        users.add(UserModel.fromMap(item.data()));
      }
    }
    log(users.toString());
    log("data : ${users.length}");

    return users;
  }
}
