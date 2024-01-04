

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart'as fs;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:onroad/constant.dart';
import '../models/order.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class TrackingMapScreen extends StatefulWidget {
  const TrackingMapScreen({Key? key, required this.order})
      : super(key: key);
  final Order order;
  @override
  State<TrackingMapScreen> createState() => _TrackingMapScreenState();
}

class _TrackingMapScreenState extends State<TrackingMapScreen> {

  final Completer<GoogleMapController> _controller = Completer();
  bool? target = false;
  bool? increment = false;
  double radius = 0;
  double zoom = 15.151926040649414;
  LatLng? position = LatLng(33.518391538, 36.2091951);
  Set<Circle> circles = {};
  Set<Marker> markers = {};
  late CameraPosition _kGooglePlex;

  late dynamic icon;

  int massageCounter = 0;

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      massageCounter=massageCounter
          +1;
      setState(() {

      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //massageCounter = 0 ;
      massageCounter=massageCounter+1;
      print('hiiiiiiiiiii');
      print('hiiiiiiiiiii');
      print('hiiiiiiiiiii');
      setState(() {

      });
    });

  //  getPolyPoints();
    _kGooglePlex = CameraPosition(
      target: widget.order.providerLocation,
      zoom: 17.151926040649414,
      /*37.43296265331129, -122.08832357078792*/
    );
    markers = {
      Marker(
          anchor: Offset(0.5, 0.5),
          markerId: MarkerId('0'),
          position: widget.order.providerLocation,
          icon:
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)),
      Marker(
          anchor: Offset(0.5, 0.5),
          markerId: MarkerId('1'),
          position: widget.order.customerLocation,
          icon:
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)),
    };
    super.initState();
  }
  List<LatLng> polyline = [];
/*
  void getPolyPoints()async{
    String key = 'AIzaSyCUIIMbkeIITf08F39BkuoqaTgq37hOgGA';

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        key,
        PointLatLng(widget.order.customerLocation.latitude, widget.order.customerLocation.longitude),
        PointLatLng(widget.order.providerLocation.latitude, widget.order.providerLocation.longitude),
    );
    print(result.points);
    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng pointLatLng) => polyline.add(LatLng(pointLatLng.latitude, pointLatLng.longitude)));
    }
setState(() {

});
  }
*/

void controller(LatLng latLng)async{
  GoogleMapController googleMapController = await _controller.future;
  googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: latLng,
        zoom: 15.751926040649414,
      )));

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo app.png',
          width: 75,
          height: 75,
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              Center(
                child:  IconButton(
                  icon: Icon(Icons.notifications,
                    size: 30,),
                  onPressed: (){
                    massageCounter = 0 ;
                    setState(() {

                    });
                  },
                ),
              ),
              massageCounter==0?Container():Positioned(
                top: 27,
                left: 27,
                child: Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.red
                  ),

                ),
              ),
              massageCounter==0?Container():Positioned(
                  top:  28,
                  left: 32,
                  child: Text(massageCounter.toString(),selectionColor: Colors.white,style: TextStyle(fontSize: 12),))
            ],
          )
        ],

      ),
      body: StreamBuilder(
        stream: fs.FirebaseFirestore.instance
            .collection("Orders").doc(widget.order.id.toString()).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print(snapshot.data['lat'].toString());
         controller(LatLng(snapshot.data['lat'],snapshot.data['lng']));
          markers = {
            Marker(
                anchor: Offset(0.5, 0.5),
                markerId: MarkerId('0'),
                position: widget.order.providerLocation,
                icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)),
            Marker(
                anchor: Offset(0.5, 0.5),
                markerId: MarkerId('1'),
                position: widget.order.customerLocation,
                icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
            Marker(
                anchor: Offset(0.5, 0.5),
                markerId: MarkerId('1'),
                position: LatLng(snapshot.data['lat'],snapshot.data['lng']),
                icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)),
          };

          return GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: _kGooglePlex,
            circles: circles,
            markers: markers,
          /*  polylines: {
              Polyline(
                polylineId: PolylineId('1'),
                points: polyline,
                color: kPrimaryColor2,
                width: 3,


              )
            },*/
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        },
      ),
    );
  }
}
