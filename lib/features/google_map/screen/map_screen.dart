import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controller/map_controller.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  final MapController controller = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    final LatLng myPosition = LatLng(23.781396032546446, 90.40390316009518);

    return Scaffold(
      appBar: AppBar(title: const Text('Google Map Screen')),
      body: Center(
        child: Obx(
          () => GoogleMap(
            // Map Controller
            onMapCreated: (GoogleMapController ctrl) {
              controller.onMapCreated(ctrl);
            },

            // Starting position of the map
            initialCameraPosition: CameraPosition(target: myPosition, zoom: 15),
            //zoom controls
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            // My location settings
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            // Map type
            mapType: MapType.hybrid,

            // while changing position
            onCameraMove: (CameraPosition cameraposition) {
              // You can perform actions based on camera movement here
              // print('Camera moved to: ${cameraposition.target}');
            },
            // when movement stops
            onCameraIdle: () {
              // Actions to perform when camera movement stops
              // print('Camera movement has stopped.');
            },
            // markers: markers, // Add markers to the map
            // mapToolbarEnabled: true,
            markers: <Marker>{
              Marker(
                markerId: MarkerId('my-office'),
                position: controller.endPositionlatlng.value,
                draggable: true,
                flat: false,
                onTap: () {
                  print('Tapped on my office marker');
                },
                onDrag: (LatLng latLng) {
                  // print(latLng);
                },
                onDragEnd: (LatLng latLng) {
                  controller.updateMarkerPosition(latLng);
                },
                onDragStart: (LatLng latLng) {
                  print(latLng);
                },
                infoWindow: InfoWindow(
                  title: 'My office',
                  onTap: () {
                    print('Tapped on info window');
                  },
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue,
                ),
              ),
              Marker(
                markerId: MarkerId('abc'),
                position: LatLng(23.79684464759991, 90.40387496352196),
              ),
              Marker(
                markerId: MarkerId('abcd'),
                position: LatLng(23.79499602888209, 90.40309477597475),
              ),
            },
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            onPressed: () {
              controller.animateToEndPosition();
            },
            child: Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
