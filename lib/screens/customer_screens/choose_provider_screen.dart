import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/StateManagement/blocs/provider_order_cubit.dart';
import 'package:onroad/StateManagement/blocs/provider_order_state.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/models/distance.dart';
import 'package:onroad/models/provider.dart';
import 'package:onroad/screens/customer_screens/complet_order.dart';
import 'package:onroad/widget/mydirection.dart';
import 'package:http/http.dart' as http;
import 'package:widget_marker_google_map/widget_marker_google_map.dart';

class ChooseProviderScreen extends StatefulWidget {
  ChooseProviderScreen(
      {Key? key, required this.customerPosition, required this.serviceType})
      : super(key: key);
  LatLng customerPosition;
  int? serviceType;

  @override
  State<ChooseProviderScreen> createState() => _ChooseProviderScreenState();
}

class _ChooseProviderScreenState extends State<ChooseProviderScreen>
    {
  final Completer<GoogleMapController> _controller = Completer();

  // Directions? _info;
  bool? target = false;
  bool? increment = false;
  double radius = 0;
  double zoom = 15.151926040649414;
  LatLng? position = LatLng(33.518391538, 36.2091951);
  Set<Circle> circles = {};
  late final CameraPosition _kGooglePlex;
  bool? done = false;
  bool? done2 = false;
  bool? done3 = false;
  bool? oneTime = false;
  int? selected;
  //late AnimationController _animationController;
  late dynamic icon;
//  List<MarkerData> _customMarkers = [];
 List<WidgetMarker> _customMarkers2 = [];
  List<Provider> providers = [];
  Provider provider = Provider(
    carNumber: '',
    password: '',
    email: '',
    license: true,
    workType: '',
    phoneNumber: '',
    userName: '',
    id: '',
    repairShop: false, isActive: false,
  );
  Provider? selectedProvider;

  @override
  void initState() {
    //_animationController =
    //   AnimationController(vsync: this, duration: const Duration(seconds: 1));
    circles = {
      Circle(
          circleId: CircleId("1"),
          center: LatLng(widget.customerPosition.latitude,
              widget.customerPosition.longitude),
          zIndex: 1,
          radius: 25,
          strokeWidth: 0,
          strokeColor: Colors.white,
          fillColor: kPrimaryColor.withOpacity(0.2)),
      Circle(
          circleId: CircleId("1"),
          center: LatLng(widget.customerPosition.latitude,
              widget.customerPosition.longitude),
          zIndex: 1,
          radius: 17.5,
          strokeWidth: 0,
          strokeColor: Colors.white,
          fillColor: kPrimaryColor.withOpacity(0.3)),
      Circle(
          circleId: CircleId("1"),
          center: LatLng(widget.customerPosition.latitude,
              widget.customerPosition.longitude),
          zIndex: 1,
          radius: 7.5,
          strokeWidth: 2,
          strokeColor: Colors.white,
          fillColor: kPrimaryColor),
    };
    _kGooglePlex = CameraPosition(
      target: LatLng(
          widget.customerPosition.latitude, widget.customerPosition.longitude),
      zoom: 17.151926040649414,
    );
    createMarker();
    initialData();

    super.initState();
  }

  void createMarker() async {
    icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/Car-1.png',
        mipmaps: false);
    setState(() {
      done = true;
    });
  }

  Future<void> getProvider(dynamic data) async {
    LoginCubit loginCubit = LoginCubit.instance(context);
    provider = await loginCubit.getProviderById2(data.toString());

    //setState(() {});
  }


  QuerySnapshot<Map<String, dynamic>>? initialdata;

 double calculateDistance(LatLng cLocation,LatLng pLocation){
   double distance = 0 ;
   distance = sqrt(pow((cLocation.latitude - pLocation.latitude), 2)+pow((cLocation.longitude - pLocation.longitude), 2));

   return distance;
 }
  Future<List<Provider>> getProviders() async{
    final response2 = await http.get(
      Uri.parse(
        '$baseUrl$getProviders1',
      ),
    );
    if (response2.statusCode == 200) {
      print(response2.body);
      dynamic map = json.decoder.convert(response2.body);
      List<dynamic> providers =map['provider_data'][0];
      List<Provider> allProviders =[];
      for(int i = 0 ; i < providers.length ; i++){
        Provider? provider = Provider.fromJsonArray2(providers[i]);
        allProviders.add(provider!);
      }
      return allProviders;
    } else {
      print(response2.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }


  }

  Future<void> initialData() async {
    LoginCubit loginCubit = LoginCubit.instance(context);
    List<Provider> allProviders2 = [];
    List<Provider> allProviders =await getProviders();

    initialdata =
        await FirebaseFirestore.instance.collection("ActiveProvider").get();
    Future.delayed(Duration(milliseconds: 1000), () async {
      //_customMarkers.clear();
      providers.clear();
      for (int j = 0; j < allProviders.length; j++) {
        for (int i = 0; i < initialdata!.size; i++) {
          if(allProviders[j].id.toString() ==  initialdata!.docs[i].data()['provider_id'].toString()) {
            if (initialdata!.docs[i].data()['active'] == 'active') {
              //LoginCubit loginCubit = LoginCubit.instance(context);
              //bool state = await loginCubit.getProviderState(initialdata!.docs[i].data()['provider_id'].toString());
              if (allProviders[j].isActive) {
                List array = initialdata!.docs[i].data()['services'];
                print(array);
                if (array.contains(widget.serviceType == 1
                    ? 11
                    : widget.serviceType == 22
                        ? 15
                        : widget.serviceType == 21
                            ? 1
                            : widget.serviceType == 3
                                ? 2
                                : widget.serviceType == 4
                                    ? 4
                                    : widget.serviceType == 51
                                        ? 3
                                        : widget.serviceType == 52
                                            ? 16
                                            : 0)) {
                  /*       dynamic map = await loginCubit.getProviderLocation(
                  initialdata!.docs[i].data()['provider_id'].toString());*/
                  double distance1 = 0;
                  distance1 = calculateDistance(
                      widget.customerPosition,
                      LatLng(double.parse(allProviders[j].providerLocation!.latitude.toString()),
                          double.parse(allProviders[j].providerLocation!.latitude.toString())));

                  allProviders[j].distance2 = distance1;
                  allProviders2.add(allProviders[j]);

/*            distance1 = calculateDistance(widget.customerPosition, LatLng(
                double.parse(initialdata!.docs[i].data()['lat'].toString()),
                double.parse(initialdata!.docs[i].data()['lng'].toString())));*/

                  /*Distance distance = Distance(
                      providerId: initialdata!.docs[i].data()['provider_id'],
                      distance: distance1,
                      map: map);*/
                }
              }
            }
          }else{
            allProviders[j].distance2 = 999999999999999;

          }
        }
      }

      allProviders2.sort((a,b){
        return  a.distance2!.compareTo(b.distance2!);
      });

      for(int j = 0 ; j < 5 ; j++){
        if(allProviders2.length > j){
          await getProvider2(j,allProviders2[j]);

        }
      }
     /* for (int i = 0; i < initialdata!.size; i++) {
        bool exist = false;
        dynamic map ;
        for(int j = 0 ; j < 5 ; j++){
          if(distances.length > j){
            if (initialdata!.docs[i].data()['provider_id'].toString() ==
                allProviders[j].id.toString()) {
              exist = true;
             map= distances[j].map;
            }
          }
        }
        if(exist) {
          print(initialdata!.docs[i].data()['active']);
              await getProvider2(initialdata!.docs[i].data(),i,map);
              print(_customMarkers2.length);
              setState(() {});
        }
      }*/
       done3 = true;
    setState(() {});
    });
  }

  Future<void> getProvider2( int i, Provider provider) async {
    LoginCubit loginCubit = LoginCubit.instance(context);

      //provider = await loginCubit.getProviderById2(data['provider_id'].toString());
      double rate = await loginCubit.getProviderRate(provider.id.toString());
      provider.rate = rate.toString() == 'NaN'?0:rate;
      print(provider.rate);
      print(provider.id);
      print(provider.userName);

      Map<String, String>? expectedTimeAndDistance =
      await getExpectedTimeAndDistance(
          provider.providerLocation!, widget.customerPosition);
      provider.time = expectedTimeAndDistance['duration'];
      provider.distance = expectedTimeAndDistance['distance'];

      providers.add(provider);
      /*_customMarkers.add(MarkerData(
          marker: Marker(
              markerId: MarkerId(i.toString()),
              position: provider.providerLocation!),
          child: Stack(
            children: [
              Positioned(
                top: 25,
                child: Image.asset(
                  widget.serviceType == 1
                      ? 'assets/images/Group 366.png'
                      : 'assets/images/img_1-removebg-preview(2).png',
                  width: 50,
                ),
              ),
              Image.asset(
                'assets/images/ic_edit_location.png',
                width: 45,
              ),
              Positioned(
                  left: 15,
                  top: 11.5,
                  child: Container(
                      width: 14,
                      height: 17,
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        (_customMarkers.length + 1).toString(),
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(color: kPrimaryColor, fontSize: 10),
                      ))),
            ],
          )));*/
        _customMarkers2.add(
            WidgetMarker(
              position: provider.providerLocation!,
              markerId: i.toString(),
              widget: Stack(
                children: [
                  Positioned(
                    top: 25,
                    child: Image.asset(
                      widget.serviceType == 1
                          ? 'assets/images/Group 366.png'
                          : 'assets/images/img_1-removebg-preview(2).png',
                      width: 50,
                    ),
                  ),
                  Image.asset(
                    'assets/images/ic_edit_location.png',
                    width: 45,
                  ),
                  Positioned(
                      left: 15,
                      top: 11.5,
                      child: Container(
                          width: 14,
                          height: 17,
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            (_customMarkers2.length + 1).toString(),
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: kPrimaryColor, fontSize: 10),
                          ))),
                ],
              ),
            ));
    done2 = true;
    setState(() {});

  }

  Future<Map<String, String>> getExpectedTimeAndDistance(LatLng pLocation ,LatLng cLocation )async{
    final response2 = await http.get(
      Uri.parse('https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${pLocation.latitude} ${pLocation.longitude}&origins=${cLocation.latitude} ${cLocation.longitude}&key=AIzaSyCUIIMbkeIITf08F39BkuoqaTgq37hOgGA'),
    );
    String time ='';
    String distance ='';
    Map<String, String> data ={};
    if (response2.statusCode == 200) {
      dynamic map = json.decoder.convert(response2.body);
      print(map);
       time = map['rows'][0]['elements'][0]['duration']['text'].toString();
      distance = map['rows'][0]['elements'][0]['distance']['text'].toString();

      data['duration'] = time ;
      data['distance'] = distance ;
    } else {
      print(response2.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
    return data;
  }


  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    /*
    ProviderOrderCubit providerOrderCubit =
    ProviderOrderCubit.instance(context);
    providerOrderCubit.getProviders(
        initialdata, widget.serviceType!,widget.customerPosition, context);*/
    final size = MediaQuery.of(context).size;
    return MyDirectionality(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          title: Image.asset(
            'assets/images/logo app.png',
            width: 75,
            height: 75,
          ),
          centerTitle: true,
        ),
        body: done2!
            ? Stack(
          children: [
            done!
                ?done3!
                ?map(kGooglePlex: _kGooglePlex, circles: circles, customMarkers2: _customMarkers2)
            /*GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: _kGooglePlex,
              circles: circles,
              onMapCreated:
                  (GoogleMapController controller) {

              },
            )*/
                : Center(
              child: CircularProgressIndicator(),
            ): Center(
              child: CircularProgressIndicator(),
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      elevation: 1,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 100,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              languageCubit.choosept1_2!+providers.length.toString()+languageCubit.choosept1!,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              languageCubit.choosept2!,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    elevation: 8,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    child: Container(
                      width: double.infinity,
                      height: size.height *
                          0.475 /*+
                                  (_animationController.value *size.height * 0.31)*/ /*size.height * 0.8*/,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                /*    if (_animationController.status ==
                                            AnimationStatus.completed) {
                                          _animationController.reverse();
                                        } else {
                                          _animationController.forward();
                                        }*/
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 75,
                                        height: 5,
                                        color: Colors.grey)
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                /*     if (_animationController.status ==
                                            AnimationStatus.completed) {
                                          _animationController.reverse();
                                        } else {
                                          _animationController.forward();
                                        }*/
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  /*   _animationController.status !=
                                                  AnimationStatus.completed
                                              ? Icon(Icons.arrow_upward)
                                              :*/
                                  Icon(Icons.arrow_downward_rounded),
                                  Spacer(),
                                  Text(
                                    languageCubit.choosept3!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: kPrimaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 4.0, right: 4),
                          child: SizedBox(
                            width: double.infinity,
                            height: size.height * 0.3,
                            child: ListView.builder(
                                itemCount:
                                providers.length,
                                itemBuilder:
                                    (context, index) {
                                  return Padding(
                                    padding:
                                    const EdgeInsets
                                        .all(4.0),
                                    child:
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedProvider =
                                          providers[
                                          index];
                                          selected =
                                              index;
                                        });
                                      },
                                      child: Container(
                                        width: double
                                            .infinity,
                                        height: 130,
                                        decoration:
                                        BoxDecoration(
                                          color: selected ==
                                              index
                                              ? kPrimaryColor
                                              .withOpacity(
                                              0.4)
                                              : kPrimaryColor
                                              .withOpacity(
                                              0.1),
                                          borderRadius:
                                          const BorderRadius
                                              .all(
                                              Radius.circular(
                                                  15)),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets
                                              .all(
                                              8.0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width:
                                                90,
                                                height:
                                                75,
                                                child:
                                                Directionality(
                                                  textDirection:
                                                  TextDirection.ltr,
                                                  child:
                                                  Stack(
                                                    children: [
                                                      Positioned(
                                                        top: 25,
                                                        child: Image.asset(
                                                          widget.serviceType == 1 ? 'assets/images/Group 370.png' : 'assets/images/img_1-removebg-preview(2).png',
                                                          width: widget.serviceType == 1 ? 60 : 80,
                                                        ),
                                                      ),
                                                      Image.asset(
                                                        'assets/images/ic_edit_location.png',
                                                        width: 40,
                                                      ),
                                                      Positioned(
                                                          left: 12,
                                                          top: 10,
                                                          child: Container(
                                                              width: 14,
                                                              height: 15,
                                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                                                              child: Text(
                                                                (index + 1).toString(),
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(color: kPrimaryColor, fontSize: 10),
                                                              ))),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .end,
                                                children: [
                                                  Text(
                                                    "${providers[index].userName} ",
                                                    style:
                                                    TextStyle(
                                                      fontSize:
                                                      15,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color:
                                                      kPrimaryColor,
                                                    ),
                                                    textAlign:
                                                    TextAlign.center,
                                                  ),
                                                  RatingBar
                                                      .builder(
                                                    ignoreGestures:
                                                    true,
                                                    itemSize:
                                                    22,
                                                    initialRating:
                                                    providers[index].rate,
                                                    minRating:
                                                    0,
                                                    direction:
                                                    Axis.horizontal,
                                                    allowHalfRating:
                                                    true,
                                                    itemCount:
                                                    5,
                                                    itemPadding:
                                                    EdgeInsets.symmetric(horizontal: 2.0),
                                                    itemBuilder: (context, _) =>
                                                    const Icon(
                                                      Icons.star,
                                                      color:
                                                      Colors.amber,
                                                      size:
                                                      1,
                                                    ),
                                                    onRatingUpdate:
                                                        (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                  Row(
                                                    children: [
                                                      Directionality(

                                                        textDirection: TextDirection.ltr,
                                                        child: Text(
                                                          providers[index].time!,
                                                          style: TextStyle(
                                                            fontSize:10,
                                                            fontWeight: FontWeight.bold,
                                                            color: kPrimaryColor,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${languageCubit.choosept5!}',
                                                        style: TextStyle(
                                                          fontSize: 9,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      Icon(
                                                        Icons.access_time_rounded,
                                                        color: kPrimaryColor,
                                                        size: 15,
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Directionality(

                                                        textDirection: TextDirection.ltr,
                                                        child: Text(
                                                          providers[index].distance!,
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.bold,
                                                            color: kPrimaryColor,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                      Text(
                                                        languageCubit.language=='AR'?' -  المسافه  ':'distance',
                                                        style: TextStyle(
                                                          fontSize: 9,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      Icon(
                                                        Icons.access_time_rounded,
                                                        color: kPrimaryColor,
                                                        size: 15,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        /*    BlocConsumer<ProviderOrderCubit,
                                ProviderOrderStates>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state is StateInitial) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0, right: 4),
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: size.height * 0.3,
                                        child: ListView.builder(
                                            itemCount:
                                            providers.length,
                                            itemBuilder:
                                                (context, index) {
                                              return Padding(
                                                padding:
                                                const EdgeInsets
                                                    .all(4.0),
                                                child:
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedProvider =
                                                      providers[
                                                      index];
                                                      selected =
                                                          index;
                                                    });
                                                  },
                                                  child: Container(
                                                    width: double
                                                        .infinity,
                                                    height: 120,
                                                    decoration:
                                                    BoxDecoration(
                                                      color: selected ==
                                                          index
                                                          ? kPrimaryColor
                                                          .withOpacity(
                                                          0.4)
                                                          : kPrimaryColor
                                                          .withOpacity(
                                                          0.1),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .all(
                                                          Radius.circular(
                                                              15)),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(
                                                          8.0),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                            90,
                                                            height:
                                                            75,
                                                            child:
                                                            Directionality(
                                                              textDirection:
                                                              TextDirection.ltr,
                                                              child:
                                                              Stack(
                                                                children: [
                                                                  Positioned(
                                                                    top: 25,
                                                                    child: Image.asset(
                                                                      widget.serviceType == 1 ? 'assets/images/Group 370.png' : 'assets/images/img_1-removebg-preview(2).png',
                                                                      width: widget.serviceType == 1 ? 60 : 80,
                                                                    ),
                                                                  ),
                                                                  Image.asset(
                                                                    'assets/images/ic_edit_location.png',
                                                                    width: 40,
                                                                  ),
                                                                  Positioned(
                                                                      left: 12,
                                                                      top: 10,
                                                                      child: Container(
                                                                          width: 14,
                                                                          height: 15,
                                                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                                                                          child: Text(
                                                                            (index + 1).toString(),
                                                                            textAlign: TextAlign.center,
                                                                            style: TextStyle(color: kPrimaryColor, fontSize: 10),
                                                                          ))),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                            children: [
                                                              Text(
                                                                "${providers[index].userName} ",
                                                                style:
                                                                TextStyle(
                                                                  fontSize:
                                                                  16,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  color:
                                                                  kPrimaryColor,
                                                                ),
                                                                textAlign:
                                                                TextAlign.center,
                                                              ),
                                                              RatingBar
                                                                  .builder(
                                                                ignoreGestures:
                                                                true,
                                                                itemSize:
                                                                22,
                                                                initialRating:
                                                                providers[index].rate,
                                                                minRating:
                                                                0,
                                                                direction:
                                                                Axis.horizontal,
                                                                allowHalfRating:
                                                                true,
                                                                itemCount:
                                                                5,
                                                                itemPadding:
                                                                EdgeInsets.symmetric(horizontal: 2.0),
                                                                itemBuilder: (context, _) =>
                                                                const Icon(
                                                                  Icons.star,
                                                                  color:
                                                                  Colors.amber,
                                                                  size:
                                                                  1,
                                                                ),
                                                                onRatingUpdate:
                                                                    (rating) {
                                                                  print(rating);
                                                                },
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Directionality(

                                                                    textDirection: TextDirection.ltr,
                                                                    child: Text(
                                                                      providers[index].time!,
                                                                      style: TextStyle(
                                                                        fontSize: 10,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: kPrimaryColor,
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${languageCubit.choosept5!}',
                                                                    style: TextStyle(
                                                                      fontSize: 11,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.black,
                                                                    ),
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                  Icon(
                                                                    Icons.access_time_rounded,
                                                                    color: kPrimaryColor,
                                                                    size: 15,
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Directionality(

                                                                    textDirection: TextDirection.ltr,
                                                                    child: Text(
                                                                      providers[index].distance!,
                                                                      style: TextStyle(
                                                                        fontSize: 10,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: kPrimaryColor,
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    languageCubit.language=='AR'?' -  المسافه  ':'distance',
                                                                    style: TextStyle(
                                                                      fontSize: 11,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.black,
                                                                    ),
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                  Icon(
                                                                    Icons.access_time_rounded,
                                                                    color: kPrimaryColor,
                                                                    size: 15,
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    );
                                  } else if (state
                                  is GetProvidersFinishedSuccessfully) {
                                    return Center(
                                        child: CircularProgressIndicator(color: Colors.red,));
                                  } else {
                                    return Center(
                                        child: CircularProgressIndicator(color: Colors.green,));
                                  }
                                }),*/
                            GestureDetector(
                              onTap: () {
                                if (selectedProvider == null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior
                                          .floating,
                                      padding: EdgeInsets.all(10),
                                      content: Text(
                                        languageCubit
                                            .choosePFirst!,
                                        textAlign:
                                        TextAlign.center,
                                      )));
                                } else {
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) {
                                            return CompleteOrder(
                                              serviceType: widget.serviceType,
                                              provider: selectedProvider!,
                                              customerPosition:
                                              widget.customerPosition,
                                            );
                                          }));
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // padding: const EdgeInsets.all(10),
                                  height: 56,
                                  width: size.width * 0.75,
                                  decoration: const BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius:
                                      const BorderRadius.all(
                                          Radius.circular(7))),
                                  child: Center(
                                    child: Text(
                                      languageCubit.Continue!,
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
            : const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
      ),
    );
  }
}

class map extends StatefulWidget {
  const map({
    Key? key,
    required CameraPosition kGooglePlex,
    required this.circles,
    required List<WidgetMarker> customMarkers2,
  }) : _kGooglePlex = kGooglePlex, _customMarkers2 = customMarkers2, super(key: key);

  final CameraPosition _kGooglePlex;
  final Set<Circle> circles;
  final List<WidgetMarker> _customMarkers2;

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  @override
  Widget build(BuildContext context) {
    return WidgetMarkerGoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: widget._kGooglePlex,
              circles: widget.circles,
              widgetMarkers:widget._customMarkers2,
            );
  }
}
