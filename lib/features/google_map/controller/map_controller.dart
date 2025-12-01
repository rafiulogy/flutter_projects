import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  late GoogleMapController mapController;

  // Observable position for the draggable marker
  final Rx<LatLng> endPositionlatlng = LatLng(
    23.79387450015791,
    90.40334499572938,
  ).obs;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    print('Map created with controller: $controller');
  }

  void updateMarkerPosition(LatLng newPosition) {
    endPositionlatlng.value = newPosition;
    print('Marker dragged to: $newPosition');
    final String positionString =
        "${newPosition.latitude}, ${newPosition.longitude}";
    print('New position: $positionString');
  }

  void animateToEndPosition() {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: endPositionlatlng.value, zoom: 16),
      ),
    );
  }
}
