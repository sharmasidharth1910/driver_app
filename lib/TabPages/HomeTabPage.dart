import 'dart:async';

import 'package:driver_app/Credentials/ConfigMaps.dart';
import 'package:driver_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeTabPage extends StatefulWidget {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController newGoogleMapController;

  String driverStatus = "Go Online   ";

  Color driverStatusColor = Colors.green;

  bool isDriverAvailable = false;

  Position currentPosition;

  var geoLocator = Geolocator();

  Future<void> locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentPosition = position;

    LatLng latLng = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 14,
    );
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    // String address = await AssistantMethods.searchCoordinateAddress(
    //   position: position,
    //   context: context,
    // );
    // print("Result from getAddress : " + address);
  }

  Future<void> makeDriverOnlineNow() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentPosition = position;

    Geofire.initialize("availableDrivers");
    Geofire.setLocation(currentfirebaseUser.uid, currentPosition.latitude,
        currentPosition.longitude);

    rideRequestRef.onValue.listen((event) {});
  }

  void makeDriverOfflineNow() {
    Geofire.removeLocation(currentfirebaseUser.uid);
    rideRequestRef.onDisconnect();
    rideRequestRef.remove();
    rideRequestRef = null;
  }

  void getLocationLiveUpdates() {
    homeTabPageStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      currentPosition = position;
      if (isDriverAvailable) {
        Geofire.setLocation(
          currentfirebaseUser.uid,
          position.latitude,
          position.longitude,
        );
      }
      LatLng latLng = LatLng(position.latitude, position.longitude);
      newGoogleMapController.animateCamera(CameraUpdate.newLatLng(latLng));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: HomeTabPage._kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controllerGoogleMap.complete(controller);
            newGoogleMapController = controller;

            locatePosition();
          },
        ),
        Container(
          height: 140.0,
          width: double.infinity,
          color: Colors.black54,
        ),
        Positioned(
          top: 60.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(driverStatusColor),
                  ),
                  onPressed: () {
                    if (!isDriverAvailable) {
                      makeDriverOnlineNow();
                      getLocationLiveUpdates();
                      setState(() {
                        driverStatusColor = Colors.red;
                        driverStatus = "Go Offline";
                        isDriverAvailable = true;
                      });
                      Fluttertoast.showToast(msg: "You are Online now");
                    } else {
                      makeDriverOfflineNow();
                      setState(() {
                        driverStatus = "Go Online";
                        driverStatusColor = Colors.green;
                        isDriverAvailable = false;
                      });

                      Fluttertoast.showToast(msg: "You are Offline now");
                    }
                  },
                  child: Container(
                    color: driverStatusColor,
                    child: Padding(
                      padding: EdgeInsets.all(17.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            driverStatus,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.phone_android,
                            color: Colors.white,
                            size: 26.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
