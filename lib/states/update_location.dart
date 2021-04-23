import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ungposition/widget/show_progress.dart';

class UpdateLocotion extends StatefulWidget {
  @override
  _UpdateLocotionState createState() => _UpdateLocotionState();
}

class _UpdateLocotionState extends State<UpdateLocotion> {
  double lat, lng;
  Map<MarkerId, Marker> markers = {};

  @override
  void initState() {
    super.initState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    Position position = await findPosition();
    setState(() {
      lat = position.latitude;
      lng = position.longitude;
      addMarker();
    });
  }

  void addMarker() {
    MarkerId markerId = MarkerId('idHere');
    Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(
        title: 'You Here !!',
        snippet: 'lat = $lat, lng = $lng',
      ),
    );

    markers[markerId] = marker;
  }

  Future<Position> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Location'),
      ),
      body: lat == null
          ? ShowProgress()
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, lng),
                zoom: 16,
              ),
              onMapCreated: (controller) {},
              markers: Set<Marker>.of(markers.values),
            ),
    );
  }
}
