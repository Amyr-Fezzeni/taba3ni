import 'package:flutter/cupertino.dart';

class DataProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController(text: '');
  String search = "";

  updateSearch(String value) {
    search = value;
    notifyListeners();
  }

  clearSearch(BuildContext context) {
    search = "";
    searchController.clear();
    FocusScope.of(context).unfocus();
    notifyListeners();
  }
}
