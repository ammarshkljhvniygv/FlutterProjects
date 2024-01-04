import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/models/order.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.order}) : super(key: key);
  final Order order;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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

  @override
  void initState() {
    _kGooglePlex = CameraPosition(
      target: widget.order.customerLocation,
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo app.png',
          width: 75,
          height: 75,
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: _kGooglePlex,
            circles: circles,
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        /*  SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      _kGooglePlex = CameraPosition(
                        target: widget.order.customerLocation,
                        zoom: 17.151926040649414,
                        *//*37.43296265331129, -122.08832357078792*//*
                      );
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      height: 50,
                      width: 150,
                      decoration: const BoxDecoration(
                          color: kPrimaryColor2,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7))),
                      child: Center(
                        child: Text(
                          languageCubit.locationt2!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _kGooglePlex = CameraPosition(
                        target: widget.order.providerLocation,
                        zoom: 17.151926040649414,
                        *//*37.43296265331129, -122.08832357078792*//*
                      );
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7))),
                      child: Center(
                        child: Text(
                          languageCubit.locationt4!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )*/
        ],
      ),
    );
  }
}
