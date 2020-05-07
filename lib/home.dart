import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowSimpleMap extends StatefulWidget {
  @override
  _ShowSimpleMapState createState() => _ShowSimpleMapState();
}

class _ShowSimpleMapState extends State<ShowSimpleMap> {
  GoogleMapController mapController;
  static LatLng _hysdloor = const LatLng(12.065628, 75.941046);
  static LatLng _mysore = const LatLng(12.311827, 76.652985);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Maps")),
        backgroundColor: Colors.redAccent,
      ),
      body: GoogleMap(
          markers: {hysdloor, mysore},
          mapType: MapType.hybrid,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: _hysdloor, zoom: 11.0)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _gotoIntel,
        label: Text("Intel Coorp!"),
        icon: Icon(Icons.place),
      ),
    );
  }

  static final CameraPosition intelPosition = CameraPosition(
    target: LatLng(12.9261844, 77.6774047),
    bearing: 191.789,
    tilt: 34.89,
    zoom: 14.780,
  );

  Future<void> _gotoIntel() async {
    final GoogleMapController controller = mapController;
    controller.animateCamera(CameraUpdate.newCameraPosition(intelPosition));
  }

  Marker hysdloor = Marker(
      markerId: MarkerId("Hysdloor"),
      position: _hysdloor,
      infoWindow:
          InfoWindow(title: "Hysdloor", snippet: "This Is My Home Idiots"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta));

  Marker mysore = Marker(
      markerId: MarkerId("Mysore"),
      position: _mysore,
      infoWindow: InfoWindow(title: "Mysore", snippet: "Macha Joint?"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta));
}
