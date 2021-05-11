import 'package:driver_app/Models/Address.dart';
import 'package:flutter/foundation.dart';

class AppData extends ChangeNotifier {
  Address pickUpLocation;
  Address dropOffLocation;

  void updatePickUpLocationAddress({Address pickUpAddress}) {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress({Address dropOffAddress}) {
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }
}
