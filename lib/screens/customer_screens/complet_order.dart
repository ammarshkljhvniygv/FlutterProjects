import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart'as fs;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/order_cubit.dart';
import 'package:onroad/StateManagement/blocs/services_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/manager/background_container2.dart';
import 'package:onroad/manager/cash_manager.dart';
import 'package:onroad/manager/notification_manager.dart';
import 'package:onroad/models/order.dart';
import 'package:onroad/models/provider.dart';
import 'package:onroad/screens/customer_screens/customer_order_state_screen.dart';
import 'package:onroad/screens/rouls_screen.dart';
import 'package:onroad/widget/mydirection.dart';

import '../../StateManagement/blocs/login_cubit.dart';
import '../../models/customer.dart';
import '../../models/service.dart';

class CompleteOrder extends StatefulWidget {
  const CompleteOrder(
      {Key? key,
      required this.serviceType,
      required this.provider,
      required this.customerPosition})
      : super(key: key);
  final int? serviceType;
  final Provider provider;
  final LatLng customerPosition;
  @override
  State<CompleteOrder> createState() => _CompleteOrderState();
}

class _CompleteOrderState extends State<CompleteOrder> {
  bool? val1 = false;
  String text = '';
  String text2 = '';
  int serviceId = 0;
  bool done = true;
  void initState() {
    print(serviceId);
    print(serviceId);
    print(serviceId);
    print(serviceId);
    print(serviceId);
    print(serviceId);
    serviceId = widget.serviceType==1
        ? 11
        : widget.serviceType == 22
        ? 15
        : widget.serviceType == 21
        ? 1
        : widget.serviceType==3
        ? 2
        : widget.serviceType==4
        ? 4
        :  widget.serviceType==51
        ? 3
        :  widget.serviceType==52
        ? 16
        : 0;
    print(serviceId);
    print(serviceId);
    print(serviceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    if (widget.serviceType == 1) {
      text = languageCubit.completeOrdert1!;
    }
    if (widget.serviceType == 21) {
      text = languageCubit.completeOrdert2_1!;
    }
    if (widget.serviceType == 22) {
      text = languageCubit.completeOrdert2_2!;
    }
    if (widget.serviceType == 3) {
      text = languageCubit.completeOrdert3!;
    }
    if (widget.serviceType == 4) {
      text = languageCubit.completeOrdert4_1!;
      //text2 = languageCubit.completeOrdert4_2!;
    }
    if (widget.serviceType == 51) {
      text = languageCubit.completeOrdert5_1!;
    }
    if (widget.serviceType == 52) {
      text = languageCubit.completeOrdert5_2!;
    }
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
          body: Stack(
            children: [
              RotatedBox(
                quarterTurns: 2,
                child: ClipPath(
                    clipper: BackgroundClipper2(),
                    child: Container(
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 20,
                                color: Colors.black,
                                offset: Offset(10, 0))
                          ]),
                    )),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        languageCubit.completeOrder!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: size.width * 0.8,
                      // height: 121,
                      decoration: const BoxDecoration(
                          color: kPrimaryColor2,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: SizedBox(
                        // height: 121,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                text,
                                style: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                text2,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Material(
                      elevation: 4,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        width: size.width * 0.8,
                        // height: 247,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.65,
                                    child: Text(
                                      languageCubit.copletOrdert7!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      maxLines: 3,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: const Icon(
                                      Icons.info,
                                      color: kPrimaryColor,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.65,
                                    child: Text(
                                      languageCubit.copletOrdert8!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      maxLines: 2,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: kPrimaryColor),
                                      child: const Icon(
                                        Icons.front_hand_rounded,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: Text(
                                      languageCubit.AcceptPrivacy!,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const ConditionsScreen();
                                      }));
                                    },
                                  ),
                                  Checkbox(
                                      activeColor: kPrimaryColor,
                                      value: val1,
                                      onChanged: (val) {
                                        setState(() {
                                          val1 = val!;
                                        });
                                      }),
                                ],
                              ),
                            ],
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      width: size.width * 0.62,
                      child: Text(languageCubit.copletOrdert9!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (val1!) {
                          setState(() {
                            done = false;
                          });
                          ServiceCubit serviceCubit = ServiceCubit.instance(context);
                          LoginCubit loginCubit = LoginCubit.instance(context);
                          List<Services> services = await serviceCubit.getServices2();
                          Services service = Services();
                          for(int i = 0 ; i < services.length ; i++){
                            if(serviceId.toString() == services[i].id.toString())
                              service = services[i];
                          }
                          OrderCubit orderCubit = OrderCubit.instance(context);
                          Order? order = await orderCubit.createOrder(
                              CacheManager.getInstance()!.getUserData().userId!,
                              widget.provider.id,
                              service.cost.toString(),
                              serviceId,
                              widget.provider.providerLocation!,
                              widget.customerPosition);
                          Customer customer =
                          await loginCubit.getCustomerById2(CacheManager.getInstance()!
                              .getUserData()
                              .userId!);
                          order!.customer = customer;
                          await fs.FirebaseFirestore.instance
                              .collection("Orders")
                              .doc(order.id.toString())
                              .set({
                            'order_id': order.id.toString(),
                            'provider_id': widget.provider.id,
                            'customer_name':order.customer!.userName.toString(),
                            'customer_id': int.parse(CacheManager.getInstance()!
                                .getUserData()
                                .userId!),
                            'service_type':serviceId == 11
                                ? languageCubit.Towing!
                                : serviceId == 1
                                ? languageCubit.batteryCable!
                                :serviceId == 15
                                ? languageCubit.changeBattery!
                                : serviceId == 2
                                ? languageCubit.Carlocked!
                                : serviceId == 3
                                ? languageCubit.Replacetire!:
                                  serviceId == 18
                                ? languageCubit.Repairtire2!
                                : languageCubit.Emptyfuel!,
                            'order_state': 'open',
                            'timer': 120,
                            'created_at':fs.Timestamp.now(),
                            'lat':0.0,
                            'lng':0.0,
                          });

                          CacheManager.getInstance()!
                              .storeOrderData(order.id.toString());
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CustomerOrderStateScreen(
                              order: order,
                              provider:widget.provider
                            );
                          }));
                          NotificationManager.sendNotification(
                              "p"+widget.provider.id.toString(),
                              "New Order",
                              "You have received new order , go to accept order now",
                            true,
                            false
                          );
                          setState(() {
                            done = true;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content:
                                  Text(languageCubit.youHaveToAcceptPrivacy!)));
                        }
                      },
                      child: Container(
                        width: size.width * 0.8,
                        height: 45,
                        decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Center(
                            child: Text(languageCubit.accept!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        if (widget.serviceType == 21||widget.serviceType == 22||widget.serviceType == 51||widget.serviceType == 52) {
                           Navigator.pop(context);
                        }
                        /*   Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const CustomerAcceptedOrderScreen();
                        }));*/
                      },
                      child: Container(
                        width: size.width * 0.8,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: kPrimaryColor),
                          borderRadius:
                              const BorderRadius.all(const Radius.circular(7)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Center(
                            child: Text(languageCubit.cancel!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              done
                  ? Container()
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.grey.withOpacity(0.2),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      ),
                    )
            ],
          )),
    );
  }
}
