import 'package:flutter/cupertino.dart';

class TabsProvider with ChangeNotifier {
  int index = 0;

  int get tabIndex => index;

  changeIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }
}
