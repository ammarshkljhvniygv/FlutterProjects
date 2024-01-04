import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart'as fs;
import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/manager/notification_manager.dart';
import 'package:onroad/models/order.dart';
import 'package:onroad/widget/mydirection.dart';

import '../../StateManagement/blocs/order_cubit.dart';
import '../../constant.dart';
import '../../models/provider.dart';
import '../../widget/order_item.dart';

class ProviderAcceptableOrderScreen extends StatefulWidget {
  const ProviderAcceptableOrderScreen({Key? key, required this.order, required this.provider}) : super(key: key);
  final Order order;
  final Provider provider;

  @override
  State<ProviderAcceptableOrderScreen> createState() =>
      _ProviderAcceptableOrderScreenState();
}

class _ProviderAcceptableOrderScreenState
    extends State<ProviderAcceptableOrderScreen> {
  Timer? timer;
  double cunter = 120;
  String serviceType = '';
  Future<void> setStateUser() async {
//

    await fs.FirebaseFirestore.instance
        .collection('ActiveProvider')
        .doc(widget.provider.id.toString())
        .update({
      'active': 'inactive'

    });

    print("-------------------------------------------------------------");
  }

  @override
  void initState() {
/*    timer = Timer.periodic(const Duration(seconds: 1), (x) {
      setState(() {
        cunter = cunter - 1.0;
        if (cunter <= 0) {
          timer!.cancel();
          OrderCubit order = OrderCubit.instance(context);
          order.emit(OrderStateInitial());
          */ /*Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return BusyProviderScreen();
          }));*/ /*
        }
      });
    });*/

    super.initState();
  }

  Future<void> updateOrderState(String state) async {
    await fs.FirebaseFirestore.instance
        .collection("Orders")
        .doc(widget.order.id.toString())
        .update({'order_state': state});
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
          padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                languageCubit.acceptableT1!,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),StreamBuilder(
                stream: fs.FirebaseFirestore.instance
                    .collection("Orders").doc(widget.order.id.toString()).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                  return  Text(
                    '  ${snapshot.data['timer']} ${languageCubit.acceptableT2} ',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  );
                },),


              Material(
                elevation: 6,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.58,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          text:
                              languageCubit.acceptableT4! + " : " + serviceType,
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
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                NotificationManager.sendNotification(
                                    "c"+widget.order.customerId.toString(),
                                    "Rejected order",
                                    "Provider "+widget.provider.userName+" Rejected your order,you can choose another one",
                                  false,
                                  false,

                                );
                                updateOrderState('rejected');
                                OrderCubit order = OrderCubit.instance(context);
                                order.updateOrderState('rejected', widget.order.id.toString());
                                order.makeOrderRejected();
                              },
                              child: Container(
                                width: size.width * 0.4,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: kPrimaryColor),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(7)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 0.0),
                                  child: Center(
                                    child: Text(languageCubit.reject!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: kPrimaryColor,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async{
                                /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                    return SuccessRegistrationScreen();
                                  }));*/
                                await  fs.FirebaseFirestore.instance.collection('Chats').doc(widget.order.id.toString()).set({
                                  "provider_id":widget.order.providerId.toString(),
                                  "customer_id":widget.order.customerId.toString(),
                                  "time":fs.Timestamp.now(),
                                  "c_name":widget.order.customer!.userName,
                                  "p_name":widget.provider.userName,
                                });
                                await fs.FirebaseFirestore.instance.collection('Chats').doc(widget.order.id.toString())
                                    .collection(widget.order.id.toString()).doc(widget.order.id.toString()).set({
                                  'provider': 'null',
                                  'customer':'null',
                                  'time':fs.Timestamp.now(),
                                  "image_url":"null"
                                    });
                                NotificationManager.sendNotification(
                                    "c"+widget.order.customerId.toString(),
                                    "Accepted order",
                                    "Provider"+widget.provider.userName+" accepted your order",
                                  false,
                                  false,
                                );
                                await  setStateUser();
                              await  updateOrderState('accepted');
                                OrderCubit order = OrderCubit.instance(context);
                                await  order.updateOrderState('accepted', widget.order.id.toString());
                                order.makeOrderProviderAccepted(widget.order.id);
                              },
                              child: Container(
                                width: size.width * 0.4,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(7)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 0.0),
                                  child: Center(
                                    child: Text(languageCubit.accept!,
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
