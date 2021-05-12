import 'package:driver_app/Credentials/ConfigMaps.dart';
import 'package:driver_app/Screens/MainScreen.dart';
import 'package:driver_app/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarInfoScreen extends StatelessWidget {
  static const String screenId = "carInfo";

  final TextEditingController carModelTextEditingController =
      TextEditingController();
  final TextEditingController carNumberTextEditingController =
      TextEditingController();
  final TextEditingController carColorTextEditingController =
      TextEditingController();

  void saveDriverCarInfo(BuildContext context) {
    String userId = currentfirebaseUser.uid;

    Map<String, String> carInfoMap = {
      "car_color": carColorTextEditingController.text,
      "car_number": carNumberTextEditingController.text,
      "car_model": carModelTextEditingController.text,
    };

    driversRef.child(userId).child("car_details").set(carInfoMap);

    Navigator.pushNamedAndRemoveUntil(
      context,
      MainScreen.screenId,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 22.0,
              ),
              Image.asset(
                "images/logo.png",
                width: 390.0,
                height: 250.0,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 32.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "Enter car details",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: "brand-Bold",
                      ),
                    ),
                    SizedBox(
                      height: 26.0,
                    ),
                    TextField(
                      controller: carModelTextEditingController,
                      decoration: InputDecoration(
                        labelText: "Car Model",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      height: 26.0,
                    ),
                    TextField(
                      controller: carNumberTextEditingController,
                      decoration: InputDecoration(
                        labelText: "Car Number",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: carColorTextEditingController,
                      decoration: InputDecoration(
                        labelText: "Car Color",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 42.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (carModelTextEditingController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please enter car model");
                          } else if (carNumberTextEditingController
                              .text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please enter car number");
                          } else if (carColorTextEditingController
                              .text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please enter car color");
                          } else {
                            saveDriverCarInfo(context);
                          }
                        },
                        child: Container(
                          color: Theme.of(context).accentColor,
                          child: Padding(
                            padding: EdgeInsets.all(17.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Next",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
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
          ),
        ),
      ),
    );
  }
}
