import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/manager/location_maneger.dart';
import 'package:onroad/models/location_position.dart';
import 'package:onroad/screens/customer_screens/choose_provider_screen.dart';
import 'package:onroad/widget/mydirection.dart';

class CustomerLocationScreen extends StatefulWidget {
  CustomerLocationScreen({Key? key, required this.serviceType})
      : super(key: key);
  int serviceType;
  @override
  State<CustomerLocationScreen> createState() => _CustomerLocationScreenState();
}

class _CustomerLocationScreenState extends State<CustomerLocationScreen>
    with TickerProviderStateMixin {
  final Completer<GoogleMapController> _controller = Completer();

  bool? target = false;
  bool? increment = false;
  double radius = 0;
  double zoom = 15.151926040649414;
  LatLng? position = LatLng(33.518391538, 36.2091951);
  Set<Circle> circles = {};
  Set<Marker> markers = {};
  LatLng? _onCameraMoveEndPosition;
  late CameraPosition _kGooglePlex;
  bool? done = false;
  bool? done2 = false;
  bool? location = false;
  late dynamic icon;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Future<LatLng> pickLocationOnMap(
      CameraPosition _onCameraMovePostion, Size size) async {
    LatLng _onCameraMove = _onCameraMovePostion.target;
    print(_onCameraMovePostion.zoom);
    markers = {
      Marker(
          anchor: Offset(0.5, 0.5),
          markerId: MarkerId('0'),
          position: _onCameraMove,
          icon: icon),
    };

    return _onCameraMove;
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 750));
    _fadeAnimation = Tween(begin: 2.0, end: 0.0).animate(_animationController);

    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
    getLocation();
    super.initState();
  }


  Future<void> getLocation() async {
    LocationManager locationManager = LocationManager();
    LocationPosition locationPosition = await locationManager.getLocation();
    _onCameraMoveEndPosition =
        LatLng(locationPosition.latitude, locationPosition.longitude);
    _kGooglePlex = CameraPosition(
      target: LatLng(locationPosition.latitude, locationPosition.longitude),
      zoom: 17.151926040649414,
      /*37.43296265331129, -122.08832357078792*/
    );
    createMarker();
    setState(() {
      done = true;
    });
  }

  void createMarker() async {
    icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/images/Group_191.png',
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return MyDirectionality(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Image.asset(
            'assets/images/logo app.png',
            width: 75,
            height: 75,
          ),
          centerTitle: true,
        ),
        body: done!
            ? Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    initialCameraPosition: _kGooglePlex,
                    circles: circles,
                    markers: markers,
                    onCameraMove: (position) async {
                      _onCameraMoveEndPosition =
                          await pickLocationOnMap(position, size);
                    },
                    onCameraIdle: () {
                      setState(() {});
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: kPrimaryColor,
                          size: 75,
                        ),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                child: Container(
                                  padding: EdgeInsets.only(top: 0),
                                  height: 45,
                                  width: size.width * 0.6,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Center(
                                    child: Text(
                                      languageCubit.locationt1!,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              /*Directionality(
                                textDirection: TextDirection.ltr,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 9.0),
                                      child: Material(
                                        elevation: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            languageCubit.locationt4!,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )*/
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                location = true;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              height: 50,
                              width: size.width * 0.75,
                              decoration: const BoxDecoration(
                                  color: kPrimaryColor2,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7))),
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
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (location!) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ChooseProviderScreen(
                                    serviceType: widget.serviceType,
                                    customerPosition: _onCameraMoveEndPosition!,
                                  );
                                }));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        margin: EdgeInsets.all(10),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          languageCubit.locationt5!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 17),
                                        )));
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              height: 50,
                              width: size.width * 0.75,
                              decoration: BoxDecoration(
                                  color: location!
                                      ? kPrimaryColor
                                      : kPrimaryColor.withOpacity(0.25),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7))),
                              child: Center(
                                child: Text(
                                  languageCubit.locationt3!,
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
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
