import 'package:money_converter/core/enums/viewstates.dart';
import 'package:flutter/foundation.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    print("BaseModel rebuild called by $viewState");
    notifyListeners();
  }
}
