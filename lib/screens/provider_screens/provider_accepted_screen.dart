import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart'as fs;
import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/manager/notification_manager.dart';
import 'package:onroad/models/order.dart';
import 'package:onroad/screens/chat_screen.dart';
import 'package:onroad/widget/mydirection.dart';
import 'package:location/location.dart';
import '../../StateManagement/blocs/login_cubit.dart';
import '../../StateManagement/blocs/order_cubit.dart';
import '../../constant.dart';
import '../../models/provider.dart';
import '../../widget/order_item.dart';

class ProviderAcceptedScreen extends StatefulWidget {
  const ProviderAcceptedScreen({Key? key, required this.order})
      : super(key: key);
  final Order order;
  @override
  State<ProviderAcceptedScreen> createState() => _ProviderAcceptedScreenState();
}

class _ProviderAcceptedScreenState extends State<ProviderAcceptedScreen> {
  String serviceType = '';
  Future<void> updateOrderState(String state) async {
    await fs.FirebaseFirestore.instance
        .collection("Orders")
        .doc(widget.order.id.toString())
        .update({'order_state': state});
  }
  Future<void> updateProviderLocation(double lat,double lng) async {

   fs.DocumentSnapshot<Map<String, dynamic>> data = await fs.FirebaseFirestore.instance
        .collection("Orders")
        .doc(widget.order.id.toString()).get();
   print(data['order_state']);
    if(data['order_state'] == 'accepted'){
      await fs.FirebaseFirestore.instance
          .collection("Orders")
          .doc(widget.order.id.toString())
          .update({'lat': lat,'lng':lng});
    }
  }
 void updateLocation()async{
   Location location = new Location();

   bool _serviceEnabled;
   bool _enableBackgroundMode;
   PermissionStatus _permissionGranted;
   LocationData _locationData;

   _serviceEnabled = await location.serviceEnabled();
   if (!_serviceEnabled) {
     _serviceEnabled = await location.requestService();
     if (!_serviceEnabled) {
       return;
     }
   }

   _permissionGranted = await location.hasPermission();
   if (_permissionGranted == PermissionStatus.denied) {
     _permissionGranted = await location.requestPermission();
     if (_permissionGranted != PermissionStatus.granted) {
       return;
     }
   }
   _enableBackgroundMode = await location.isBackgroundModeEnabled();
   if (!_enableBackgroundMode) {
     _enableBackgroundMode= await location.enableBackgroundMode(enable: true);
     if (!_enableBackgroundMode) {
       return;
     }
   }
   location.onLocationChanged.listen((event) {
     print(event.longitude.toString());
     updateProviderLocation(event.latitude!,event.longitude!);
   });}
  @override
  void initState() {
   updateLocation();
  /*  Location location =  Location();
    location.onLocationChanged.listen((event) {
      print(event.longitude);
      updateProviderLocation(event.latitude!,event.longitude!);
    });*/
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    serviceType = widget.order.serviceId == 11
        ? languageCubit.Towing!
        : widget.order.serviceId == 1
        ? languageCubit.batteryCable!
        :widget.order.serviceId == 15
        ? languageCubit.changeBattery!
        : widget.order.serviceId == 2
        ? languageCubit.Carlocked!
        : widget.order.serviceId == 3
        ? languageCubit.Replacetire!:
    widget.order.serviceId == 18
        ? languageCubit.Repairtire2!
        : languageCubit.Emptyfuel!;
    return MyDirectionality(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: double.infinity,
                      ),
                      /*   Text(
                        languageCubit.acceptedPT1!,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),*/
                      Text(
                        '${languageCubit.orderNumber} : ${widget.order.id.toString()}',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9395F0),
                        ),
                      ),
                    ],
                  ),
                ),
                Material(
                  elevation: 6,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    width: size.width * 0.9,
                    height: size.height * 0.55,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            OrderItem(
                              text: languageCubit.acceptableT3! +
                                  ' : ' +
                                  widget.order.cost,
                              openMap: false,
                              icon: Icon(
                                Icons.attach_money,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            OrderItem(
                              text: languageCubit.acceptableT4! +
                                  " : " +
                                  serviceType,
                              openMap: false,
                              icon: Icon(
                                Icons.home_repair_service_outlined,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            OrderItem(
                              order: widget.order,
                              text: languageCubit.acceptableT5!,
                              openMap: true,
                              icon: Icon(
                                Icons.location_pin,
                                color: kPrimaryColor2,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            OrderItem(
                              openMap: false,
                              text: languageCubit.acceptableT6! +
                                  ' : ' +
                                  widget.order.customer!.cars![0].carMake,
                              icon: Icon(
                                Icons.list,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            OrderItem(
                              openMap: false,
                              text: languageCubit.acceptableT7! +
                                  ' : ' +
                                  widget.order.customer!.cars![0].carModel,
                              icon: Icon(
                                Icons.car_repair,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            OrderItem(
                              openMap: false,
                              text: languageCubit.acceptableT8! +
                                  ' : ' +
                                  widget.order.customer!.cars![0].carColor,
                              icon: Icon(
                                Icons.format_color_fill,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            OrderItem(
                              phone: true,
                              openMap: false,
                              text: languageCubit.acceptedPT4! ,
                              text2:
                              widget.order.customer!.phoneNumber
                                  .toString()
                                  +
                                  ' : ',
                              icon: Icon(
                                Icons.phone,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChatScreen(isProvider: true,orderId: widget.order.id.toString(),CId: widget.order.customerId.toString(),PId: widget.order.providerId.toString(),);
                    }));
                  },
                  child: Container(
                    width: size.width * 0.9,
                    height: 45,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(7)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.0),
                      child: Center(
                        child: Text(languageCubit.acceptedPT2!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Text(languageCubit.language=='AR'?'رجاء قم بالتواصل مع خدمة العملاء لإلغاء الطلب في حال عدم الإتفاق مع العميل ':
                'Please contact support to cancel the order in case of disagreement with the customer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),


               /* SizedBox(
                  height: size.height * 0.015,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return Theme(
                            data: ThemeData(
                              dialogTheme: DialogTheme(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                            child: AlertDialog(
                              content: SizedBox(
                                width: 350,
                                height: 175,
                                child: Column(
                                  children: [
                                    Text(languageCubit.acceptedPT3!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryColor,
                                        )),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: size.width * 0.3,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      const Radius.circular(7)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(top: 0.0),
                                              child: Center(
                                                child: Text(languageCubit.no!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async{
                                            LoginCubit loginCubit = LoginCubit.instance(context);
                                            Provider provider = await loginCubit.getProviderById(
                                                widget.order.providerId.toString());
                                            NotificationManager.sendNotification(
                                                "c"+ widget.order.customerId
                                                    .toString(),
                                                "Canceled order",
                                                "Provider " +provider.userName.toString() +" canceled your order,you can choose another one",
                                              false,
                                              false,
                                            );
                                            Navigator.pop(context);
                                            updateOrderState('canceled');
                                            OrderCubit order =
                                                OrderCubit.instance(context);
                                            order.updateOrderState('canceled', widget.order.id.toString());

                                            order.makeOrderCanceled();
                                          },
                                          child: Container(
                                            width: size.width * 0.3,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: kPrimaryColor),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      const Radius.circular(7)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(top: 0.0),
                                              child: Center(
                                                child: Text(languageCubit.yes!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: kPrimaryColor,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: size.width * 0.85,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: kPrimaryColor),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(7)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.0),
                      child: Center(
                        child: Text(languageCubit.cancelOrder!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                            )),
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
