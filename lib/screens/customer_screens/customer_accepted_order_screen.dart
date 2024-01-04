import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/models/order.dart';
import 'package:onroad/screens/chat_screen.dart';
import 'package:onroad/screens/customer_screens/customer_cancel_order_screen.dart';
import 'package:onroad/screens/customer_screens/customer_pay_screen.dart';
import 'package:onroad/screens/tracking_map_screen.dart';
import 'package:onroad/widget/mydirection.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../models/provider.dart';
import '../wait_screen.dart';

class CustomerAcceptedOrderScreen extends StatefulWidget {
  const CustomerAcceptedOrderScreen({Key? key, required this.order, required this.provider})
      : super(key: key);
  final Order order;
  final Provider provider ;
  @override
  State<CustomerAcceptedOrderScreen> createState() =>
      _CustomerAcceptedOrderScreenState();
}

class _CustomerAcceptedOrderScreenState
    extends State<CustomerAcceptedOrderScreen> {
  Future<void> launchingMobilePhone(String number) async {
    print('====');
    String url = "tel:+965$number";
    await launchUrlString(url);
  }
  int massageCounter = 0;

  @override
  void initState() {
    SetTimer.stopTimer();
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

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return MyDirectionality(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            title: Image.asset(
              'assets/images/logo app.png',
              width: 75,
              height: 75,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.025,
                ),
                Image.asset(
                  'assets/images/Group 242.png',
                  width: 160,
                ),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.025,
                ),
                Text(languageCubit.acceptedOrderT1!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    )),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: size.width * 0.7,
                  child: Text(languageCubit.acceptedOrderT2!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Material(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    elevation: 6,
                    child: Container(
                        width: size.width * 0.8,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    // width: 60,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: kPrimaryColor, width: 1.5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Center(
                                        child: Text(
                                          languageCubit.acceptedOrder!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(languageCubit.orderState!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                            return TrackingMapScreen(order: widget.order,);
                                          }));
                                    },
                                    child: Container(
                                      width: 110,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          color: kPrimaryColor2),
                                      child: Center(
                                        child: Text(
                                          languageCubit.openMap!,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    languageCubit.acceptedOrderT3!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: kAppBar,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset('assets/images/Group 243.png'),
                                ],
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  Container(
                                    width: 2,
                                    height: 30,
                                    color: kAppBar,
                                  ),
                                  SizedBox(
                                    width: 18,
                                    height: 30,
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap:(){
                                      launchingMobilePhone(widget.provider.phoneNumber);
                                    },
                                    child: Image.asset(
                                      'assets/images/Group 246.png',
                                    ),
                                  ),

                                  Stack(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              massageCounter = 0 ;
                                            });
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                      return ChatScreen(isProvider: false,orderId: widget.order.id.toString(),CId: widget.order.customerId.toString(),PId: widget.order.providerId.toString(),);
                                                    }));
                                          },
                                          child: Image.asset(
                                              'assets/images/Group 247.png')),
                                      massageCounter==0?Container():Positioned(
                                        top: 23,
                                        left: 23,
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
                                          top: languageCubit.language=='EN'?24 : 20,
                                          left: 27,
                                          child: Text(massageCounter.toString(),
                                            style: TextStyle(fontSize: 12,color: Colors.white),)),
                                    ],
                                  ),

                                  Spacer(),
                                  Text(
                                    languageCubit.acceptedOrderT4!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: kAppBar,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset('assets/images/Group 244.png'),
                                ],
                              ),
                            ],
                          ),
                        ))),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  width: 250,
                  child: Text(languageCubit.acceptedOrderT5!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CustomerPayScreen(order: widget.order,);
                    }));
                  },
                  child: Container(
                    width: size.width * 0.8,
                    height: 45,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(7)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.0),
                      child: Center(
                        child: Text(languageCubit.pay!,
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
                  height: size.height * 0.025,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CutomerCancelOrderScreen(
                        order: widget.order,
                      );
                    }));
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
