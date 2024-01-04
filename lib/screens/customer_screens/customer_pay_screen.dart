import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/screens/add_card_screen.dart';
import 'package:onroad/widget/circle_checkbox.dart';
import 'package:onroad/widget/mydirection.dart';
import 'package:cloud_firestore/cloud_firestore.dart'as fs;
import 'package:google_fonts/google_fonts.dart';
import '../../StateManagement/blocs/order_cubit.dart';
import '../../models/order.dart';

class CustomerPayScreen extends StatefulWidget {
  const CustomerPayScreen({Key? key,required this.order}) : super(key: key);
  final Order order ;

  @override
  State<CustomerPayScreen> createState() => _CustomerPayScreenState();
}

class _CustomerPayScreenState extends State<CustomerPayScreen> {
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
  final TextEditingController _textEditingController4 = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }
  Future<void> updateOrderState() async {
    await fs.FirebaseFirestore.instance
        .collection("Orders")
        .doc( widget.order.id.toString())
        .update({'order_state': 'paycheck'});
  }
  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    final size = MediaQuery.of(context).size;
    if (x > 0) {
    } else {
      x = x + 1;
      Future.delayed(Duration(milliseconds: 100), () {
        showDialog(
            context: context,
            builder: (context) {
              return Theme(
                data: ThemeData(
                  dialogTheme: DialogTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                child: AlertDialog(
                  content: SizedBox(
                    width: 350,
                    height: 150,
                    child: Column(
                      children: [
                        Text(languageCubit.payT1!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(7)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 0.0),
                                  child: Center(
                                    child: Text(languageCubit.payT17!,
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
              );
            });
      });
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: double.infinity,
                  ),
                  Text(
                    languageCubit.payT2!,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: key,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            languageCubit.language=='AR'?'دينار':'KD',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                            width: 160,
                            height: 75,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                validator: (text) {
                                  if (text == null || text == "") {
                                    return  languageCubit.payT4!;
                                  }
                                  return null;
                                },
                                controller: _textEditingController4,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1, color: kPrimaryColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1, color: kPrimaryColor),
                                    ),

                                    label: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, bottom: 12, right: 12),
                                      child: Row(
                                        children: [

                                          Text(languageCubit.payT4!,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 191, 191, 191),
                                              )),
                                        ],
                                      ),
                                    )),
                              ),
                            )),
                        Spacer(),
                        Text(
                          languageCubit.payT4!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        /*CircleCheckBox(
                          onTap: () {
                            setState(() {
                              cost = false;
                            });
                          },
                          value: !cost,
                        )*/
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    languageCubit.payT5!,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        languageCubit.payT6!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      CircleCheckBox(
                        onTap: () {
                          setState(() {
                            payWay = true;
                          });
                        },
                        value: payWay,
                      )
                    ],
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        languageCubit.payT7!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      CircleCheckBox(
                        onTap: () {
                          setState(() {
                            payWay = false;
                          });
                        },
                        value: !payWay,
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async{
                          setState(() {
                            done = false;
                          });
 /*                         if (payWay) {
                            setState(() {
                              showAddCard = true;
                            });
                          } else {*/

                          OrderCubit orderCubit = OrderCubit.instance(context);

                            if(!key.currentState!.validate()){

                            }else{
                              await orderCubit.updateOrderCost(widget.order.id.toString(), _textEditingController4.text.toString());
                              await orderCubit.updateOrderState('paycheck', widget.order.id.toString());
                              await updateOrderState();

                              Navigator.pop(context);
                            }


                            /* setState(() {
                              show = true;
                            });*/

                          setState(() {
                            done = true;
                          });
                          /**/
                          /*Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ;
                          }));*/
                        },
                        child: Container(
                          width: size.width * 0.8,
                          height: 45,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(7)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 0.0),
                            child: Center(
                              child: Text(languageCubit.payT8!,
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
            done
                ? Container():Container(
              color: Colors.grey.withOpacity(0.4),
              width: size.width,
              height: size.height,
            ) ,

            done? Container():
            Center(child: CircularProgressIndicator(),),
            show
                ? Container(
                    color: Colors.grey.withOpacity(0.4),
                    width: size.width,
                    height: size.height,
                  )
                : Container(),
            show
                ? Center(
                    child: SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.7,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Image.asset('assets/images/Group 269.png'),
                              Text("${languageCubit.thanks} أحمد ",
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
                                    onTap: () {
                                      /*Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);*/
                                      SystemNavigator.pop();
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
                    ),
                  )
                : Container(),
            showAddCard
                ? AddCardScreen(
                    onTap: () {
                      setState(() {
                        show = true;
                        showAddCard = false;
                      });
                    },
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
