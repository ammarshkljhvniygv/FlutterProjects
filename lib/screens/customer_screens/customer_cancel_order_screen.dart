import 'package:cloud_firestore/cloud_firestore.dart'as fs;
import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/order_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/manager/notification_manager.dart';
import 'package:onroad/models/order.dart';
import 'package:onroad/screens/customer_screens/custemer_thanks_screen.dart';
import 'package:onroad/widget/mydirection.dart';

import '../../manager/cash_manager.dart';

class CutomerCancelOrderScreen extends StatefulWidget {
  const CutomerCancelOrderScreen({Key? key, required this.order})
      : super(key: key);
  final Order order;
  @override
  State<CutomerCancelOrderScreen> createState() =>
      _CutomerCancelOrderScreenState();
}

class _CutomerCancelOrderScreenState extends State<CutomerCancelOrderScreen> {
  bool val1 = false;
  bool val2 = false;
  bool val3 = false;
  bool val4 = false;
  bool val5 = false;
  Future<void> setStateUser() async {
//

    await fs.FirebaseFirestore.instance
        .collection('ActiveProvider')
        .doc(widget.order.providerId.toString())
        .update({
      'active': 'active'

    });

    print("-------------------------------------------------------------");
  }

  Future<void> updateOrderState() async {
    await fs.FirebaseFirestore.instance
        .collection("Orders")
        .doc( widget.order.id.toString())
        .update({'order_state': 'canceled'});
  }

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    final size = MediaQuery.of(context).size;
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                ),
                Text(languageCubit.cancelOrderT10!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    )),
                SizedBox(
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                      ),
                      Text(languageCubit.cancelOrderT1!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(languageCubit.cancelOrderT2!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          Checkbox(
                              activeColor: kPrimaryColor,
                              value: val1,
                              onChanged: (val) {
                                setState(() {
                                  val1 = val!;
                                });
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(languageCubit.cancelOrderT3!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          Checkbox(
                              activeColor: kPrimaryColor,
                              value: val2,
                              onChanged: (val) {
                                setState(() {
                                  val2 = val!;
                                });
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(languageCubit.cancelOrderT4!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          Checkbox(
                              activeColor: kPrimaryColor,
                              value: val3,
                              onChanged: (val) {
                                setState(() {
                                  val3 = val!;
                                });
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(languageCubit.cancelOrderT5!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          Checkbox(
                              activeColor: kPrimaryColor,
                              value: val4,
                              onChanged: (val) {
                                setState(() {
                                  val4 = val!;
                                });
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(languageCubit.cancelOrderT6!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          Checkbox(
                              activeColor: kPrimaryColor,
                              value: val5,
                              onChanged: (val) {
                                setState(() {
                                  val5 = val!;
                                });
                              })
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: size.height * 0.25,
                  child: Directionality(
                    textDirection: languageCubit.language == 'AR'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: TextField(
                      textAlign: languageCubit.language == 'AR'
                          ? TextAlign.right
                          : TextAlign.left,
                      controller: _textEditingController,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(width: 1, color: kPrimaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(width: 1, color: kPrimaryColor),
                          ),
                          label: Padding(
                            padding: const EdgeInsets.only(
                                top: 12.0, bottom: 12, right: 12),
                            child: Text(languageCubit.cancelOrderT7!,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 191, 191, 191),
                                )),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                GestureDetector(
                  onTap: () async{
                   await setStateUser();
                    NotificationManager.sendNotification(
                        "p"+widget.order.providerId.toString(),
                        'OrderCanceled',
                        'Customer canceled order!!',
                      false,
                        false
                    );
                   await updateOrderState();
                    OrderCubit orderCubit = OrderCubit.instance(context);
                    orderCubit.updateOrderState('canceled', widget.order.id.toString());

                    await CacheManager.getInstance()!.orderDone();

                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
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
                        child: Text(languageCubit.cancelOrderT8!,
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
                  onTap: () async{
                    await setStateUser();
                    String? reasoun;
                    List<String> reasouns =[];
                    if (val1) {
                      reasoun = 'Provider late';
                      reasouns.add(reasoun);
                    }
                    if (val2) {
                      reasoun = 'Cost not good';
                      reasouns.add(reasoun);

                    }
                    if (val3) {
                      reasoun = 'Receive another service';
                      reasouns.add(reasoun);

                    }
                    if (val4) {
                      reasoun = 'Problem solved';
                      reasouns.add(reasoun);

                    }
                    if (val5) {
                      if (_textEditingController.text == '' ||
                          _textEditingController.text == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                padding: EdgeInsets.all(10),
                                content: Text(
                                  'يجب إدخال سبب إلغاء الخدمة في حال اختيار (أخرى)',
                                  textAlign: TextAlign.center,
                                )));
                      } else {
                        reasoun = _textEditingController.text;
                        reasouns.add(reasoun);

                      }
                    }
                    if (val1 || val2 || val3 || val4 || val5) {

                      NotificationManager.sendNotification(
                          "p"+ widget.order.providerId.toString(),
                          'OrderCanceled',
                          'Customer canceled order!!',
                        false,
                        false,
                      );
                      OrderCubit orderCubit = OrderCubit.instance(context);
                      for(int i =  0 ; i<reasouns.length;i++){
                        orderCubit.addCanceledOrderReason(
                            widget.order.id.toString(), reasouns[i]);

                      }
                      orderCubit.updateOrderState('canceled', widget.order.id.toString());
                      updateOrderState();
                      await CacheManager.getInstance()!.orderDone();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CustomerThanksScreen();
                      }));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          padding: const EdgeInsets.all(10),
                          content: Text(
                            languageCubit.cancelOrderT1!,
                            textAlign: TextAlign.center,
                          )));
                    }

                    // Navigator.pop(context);
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
                        child: Text(languageCubit.cancelOrderT9!,
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
