import 'package:flutter_projects/features/google_map/screen/location_scree.dart';
import 'package:flutter_projects/features/google_map/screen/map_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';


class AppRoute {
  static String mapScreen = "/mapScreen";
  static String locationScreen = "/locationScreen";

  static String getMapScreen() => mapScreen;
  static String getLocationScreen() => locationScreen;

  static List<GetPage> routes = [
    // GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: mapScreen, page: () =>  MapScreen()),
    GetPage(name: locationScreen, page: () =>  const LocationScreen()),
  ];
}
