

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:onroad/StateManagement/blocs/provider_order_cubit.dart';
import 'package:onroad/models/order.dart';
import '../../StateManagement/blocs/language_cubit.dart';
import '../../constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;

import '../../manager/cash_manager.dart';


class CustomerRateScreen extends StatefulWidget {
  const CustomerRateScreen({Key? key,required this.order}) : super(key: key);
  final Order order ;

  @override
  State<CustomerRateScreen> createState() => _CustomerRateScreenState();
}

class _CustomerRateScreenState extends State<CustomerRateScreen> {
  bool cost = true;
  bool payWay = false;
  bool show = false;
  bool done = true;
  bool showAddCard = false;
  String serviceRating = '1';
  double speedRate = 0.0;
  double easyRate = 0.0;
  double connectRate = 0.0;
  String providerRating = '1';
  double speedProviderRate = 0.0;
  double behaviorRate = 0.0;
  double efficiencyRate = 0.0;
  int x = 0;
  Future<void> updateOrderState(String state) async {

    await fs.FirebaseFirestore.instance
        .collection("Orders")
        .doc(widget.order.id.toString())
        .update({'order_state': state});
  }
  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        return false ;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Image.asset('assets/images/logo app.png',
            width: 75,
            height: 75,),
        ),
        body: Stack(children: [
          Center(
            child: SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.7,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset('assets/images/Group 269.png'),
                    Text("${languageCubit.thanks}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        )),
                    Text(languageCubit.payT9!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                    /* Text("لمساهمتنا  في حل مشكتك ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),*/
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        serviceRating == '1'
                            ? RatingBar.builder(
                          // ignoreGestures: true,
                          itemSize: 22,
                          initialRating: speedRate,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(
                              horizontal: 2.0),
                          itemBuilder: (context, _) =>
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 1,
                          ),
                          onRatingUpdate: (rating) {
                            speedRate = rating;
                            print(rating);
                          },
                        )
                            : serviceRating == '2'
                            ? RatingBar.builder(
                          // ignoreGestures: true,
                          itemSize: 22,
                          initialRating: connectRate,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(
                              horizontal: 2.0),
                          itemBuilder: (context, _) =>
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 1,
                          ),
                          onRatingUpdate: (rating) {
                            connectRate = rating;
                            print(rating);
                          },
                        )
                            : RatingBar.builder(
                          // ignoreGestures: true,
                          itemSize: 22,
                          initialRating: easyRate,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(
                              horizontal: 2.0),
                          itemBuilder: (context, _) =>
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 1,
                          ),
                          onRatingUpdate: (rating) {
                            easyRate = rating;
                            print(rating);
                          },
                        ),
                        Spacer(),
                        Text(languageCubit.payT10!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        serviceRating == '1'
                            ? Container(
                          width: 70,
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: kPrimaryColor,
                                width: 1.5),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20)),
                          ),
                          child: Center(
                            child: Text(
                              languageCubit.payT11!,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        )
                            : GestureDetector(
                          onTap: () {
                            setState(() {
                              serviceRating = '1';
                            });
                          },
                          child: Container(
                            width: 70,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                                color: kPrimaryColor),
                            child: Center(
                              child: Text(
                                languageCubit.payT11!,
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
                        serviceRating == '2'
                            ? Container(
                          // width: 70,
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: kPrimaryColor,
                                width: 1.5),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Center(
                              child: Text(
                                languageCubit.payT12!,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        )
                            : GestureDetector(
                          onTap: () {
                            setState(() {
                              serviceRating = '2';
                            });
                          },
                          child: Container(
                            // width: 70,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                                color: kPrimaryColor),
                            child: Padding(
                              padding:
                              const EdgeInsets.all(3.0),
                              child: Center(
                                child: Text(
                                  languageCubit.payT12!,
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
                        ),
                        serviceRating == '3'
                            ? Container(
                          width: 70,
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: kPrimaryColor,
                                width: 1.5),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20)),
                          ),
                          child: Center(
                            child: Text(
                              languageCubit.payT13!,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        )
                            : GestureDetector(
                          onTap: () {
                            setState(() {
                              serviceRating = '3';
                            });
                          },
                          child: Container(
                            width: 70,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                                color: kPrimaryColor),
                            child: Center(
                              child: Text(
                                languageCubit.payT13!,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        providerRating == '1'
                            ? RatingBar.builder(
                          // ignoreGestures: true,
                          itemSize: 22,
                          initialRating: speedProviderRate,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(
                              horizontal: 2.0),
                          itemBuilder: (context, _) =>
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 1,
                          ),
                          onRatingUpdate: (rating) {
                            speedProviderRate = rating;
                            print(rating);
                          },
                        )
                            : providerRating == '2'
                            ? RatingBar.builder(
                          // ignoreGestures: true,
                          itemSize: 22,
                          initialRating: efficiencyRate,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(
                              horizontal: 2.0),
                          itemBuilder: (context, _) =>
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 1,
                          ),
                          onRatingUpdate: (rating) {
                            efficiencyRate = rating;
                            print(rating);
                          },
                        )
                            : RatingBar.builder(
                          // ignoreGestures: true,
                          itemSize: 22,
                          initialRating: behaviorRate,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(
                              horizontal: 2.0),
                          itemBuilder: (context, _) =>
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 1,
                          ),
                          onRatingUpdate: (rating) {
                            behaviorRate = rating;
                            print(rating);
                          },
                        ),
                        Spacer(),
                        Text(languageCubit.payT14!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        providerRating == '1'
                            ? Container(
                          width: 70,
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: kPrimaryColor,
                                width: 1.5),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20)),
                          ),
                          child: Center(
                            child: Text(
                              languageCubit.payT11!,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        )
                            : GestureDetector(
                          onTap: () {
                            setState(() {
                              providerRating = '1';
                            });
                          },
                          child: Container(
                            width: 70,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                                color: kPrimaryColor),
                            child: Center(
                              child: Text(
                                languageCubit.payT11!,
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
                        providerRating == '2'
                            ? Container(
                          width: 70,
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: kPrimaryColor,
                                width: 1.5),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20)),
                          ),
                          child: Center(
                            child: Text(
                              languageCubit.payT15!,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        )
                            : GestureDetector(
                          onTap: () {
                            setState(() {
                              providerRating = '2';
                            });
                          },
                          child: Container(
                            width: 70,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                                color: kPrimaryColor),
                            child: Center(
                              child: Text(
                                languageCubit.payT15!,
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
                        providerRating == '3'
                            ? Container(
                          width: 70,
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: kPrimaryColor,
                                width: 1.5),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20)),
                          ),
                          child: Center(
                            child: Text(
                              languageCubit.payT16!,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        )
                            : GestureDetector(
                          onTap: () {
                            setState(() {
                              providerRating = '3';
                            });
                          },
                          child: Container(
                            width: 70,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                                color: kPrimaryColor),
                            child: Center(
                              child: Text(
                                languageCubit.payT16!,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async{
                            /*Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);*/
                            setState(() {
                              done = false;
                            });
                            ProviderOrderCubit providerOrder = ProviderOrderCubit.instance(context);
                            await providerOrder.addOrderRate(widget.order.id.toString(), speedRate.toString(),connectRate.toString() ,easyRate.toString() );
                            await providerOrder.addProviderRate(widget.order.id.toString(), widget.order.providerId.toString(), speedProviderRate.toString(), efficiencyRate.toString(), behaviorRate.toString());
                            await CacheManager.getInstance()!.orderDone();
                            await updateOrderState('complet');
                            await CacheManager.getInstance()!.orderDone();
                            setState(() {
                              done = true;
                            });
                            exit(0);
                           // SystemNavigator.pop();
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
                                child:
                                Text(languageCubit.cancelOrderT9!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
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
          ),

          done?Container():SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Container(color: Colors.grey.withOpacity(0.2),)),
          done?Container():Center(
            child: CircularProgressIndicator(),
          )
        ],),
      ),
    );
  }
}
