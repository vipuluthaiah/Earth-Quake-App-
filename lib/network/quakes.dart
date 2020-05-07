import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quake/network/network.dart';
import 'package:quake/model/json.dart';

class Quakes extends StatefulWidget {
  @override
  _QuakesState createState() => _QuakesState();
}

class _QuakesState extends State<Quakes> {
  Future<Quake>_quakesData;
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markerList = <Marker>[];

  @override
  void initState() {
    super.initState();
    _quakesData = Network().getAllQuakes();
  //  _quakesData.then((values) => {
  //     print("Place:  ${values.features[0].geometry.coordinates}")
  //  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Stack(
  children: <Widget>[
    _buildGoogleMap(context)
  ],
),
floatingActionButton: FloatingActionButton.extended(
backgroundColor: Colors.redAccent,
  onPressed: (){

findQuakes();

}, label: Text("Find Quakes")),
floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  Widget _buildGoogleMap(BuildContext context){
  return Container(
width: MediaQuery.of(context).size.width,
height: MediaQuery.of(context).size.height,
child: GoogleMap(
  mapType: MapType.hybrid,
  
  onMapCreated: (GoogleMapController controller){
    _controller.complete(controller);
  },
  initialCameraPosition: CameraPosition(target: LatLng(12.065628, 75.941046)
  ,zoom: 3),
  markers: Set<Marker>.of(_markerList),
),
  );
}
void findQuakes(){
setState(() {
  _markerList.clear();
  _handleResponse();
  });
  }
  
    void _handleResponse() {
      setState(() {
        _quakesData.then((quakes)=>{
quakes.features.forEach((quake)=>{
  _markerList.add(Marker(markerId: MarkerId(quake.id),
  infoWindow: InfoWindow(title: quake.properties.mag.toString(),
  
  snippet:quake.properties.title),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  position: LatLng(quake.geometry.coordinates[1], quake.geometry.coordinates[0]),
  onTap: (){}
  ))
})
        });
      });
    }
}
