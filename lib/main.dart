import 'package:driver_app/DataHandler/AppData.dart';
import 'package:driver_app/Screens/CarInfoScreen.dart';
import 'package:driver_app/Screens/LoginScreen.dart';
import 'package:driver_app/Screens/MainScreen.dart';
import 'package:driver_app/Screens/RegisterScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child("users");

DatabaseReference driversRef =
    FirebaseDatabase.instance.reference().child("drivers");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Taxi Rider App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RegistrationScreen(),
        initialRoute: MainScreen.screenId,
        routes: {
          RegistrationScreen.screenId: (context) => RegistrationScreen(),
          LoginScreen.screenId: (context) => LoginScreen(),
          MainScreen.screenId: (context) => MainScreen(),
          CarInfoScreen.screenId: (context) => CarInfoScreen(),
          // SearchScreen.screenId: (context) => SearchScreen(),
        },
      ),
    );
  }
}
