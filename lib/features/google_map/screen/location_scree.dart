import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Position? _currentLocation;
  Position? _liveLocation;

  // Check location permission
  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  // Request location permission
  Future<bool> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  // GPS status
  Future<bool> _checkIfGPSEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<void> _getCurrentLocation() async {
    if (await _checkLocationPermission()) {
      if (await _checkIfGPSEnabled()) {
        Position position = await Geolocator.getCurrentPosition();
        _currentLocation = position;
        print(position);
        setState(() {});
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      print('Permission is not available');
      if (await _requestLocationPermission()) {
        _getCurrentLocation();
      } else {
        Geolocator.openAppSettings();
      }
    }
  }

  Future<void> _listenCurrentLocation() async {
    if (await _checkLocationPermission()) {
      if (await _checkIfGPSEnabled()) {
        Geolocator.getPositionStream().listen((location) {
          _liveLocation = location;
          setState(() {});
        });
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      print('Permission is not available');
      if (await _requestLocationPermission()) {
        _getCurrentLocation();
      } else {
        Geolocator.openAppSettings();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location')),
      body: Center(
        child: Column(
          children: [
            Text(
              'Lat:${_currentLocation?.latitude} Long:${_currentLocation?.longitude}',
            ),
            Text(_currentLocation?.isMocked.toString() ?? ''),
            Text('Live Location: $_liveLocation'),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              _getCurrentLocation();
            },
            child: Icon(Icons.my_location_outlined),
          ),
          FloatingActionButton(
            onPressed: () {
              _listenCurrentLocation();
            },
            child: Icon(Icons.location_history),
          ),
        ],
      ),
    );
  }
}