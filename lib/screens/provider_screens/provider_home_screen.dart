import 'package:cloud_firestore/cloud_firestore.dart'as fs;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/StateManagement/blocs/provider_cubit.dart';
import 'package:onroad/StateManagement/blocs/provider_order_cubit.dart';
import 'package:onroad/StateManagement/blocs/provider_order_state.dart';
import 'package:onroad/models/customer.dart';
import 'package:onroad/models/order.dart';
import 'package:onroad/models/provider.dart';
import 'package:onroad/screens/provider_screens/provider_ordertap_screen.dart';
import 'package:onroad/widget/mydirection.dart';
import 'package:workmanager/workmanager.dart';
import '../../StateManagement/blocs/order_cubit.dart';
import '../../StateManagement/blocs/order_states.dart';
import '../../constant.dart';

class ProviderHomeScreen extends StatefulWidget {
  const ProviderHomeScreen({Key? key, required this.provider})
      : super(key: key);
  final Provider provider;
  @override
  State<ProviderHomeScreen> createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
  String serviceType = '';
  bool orderTap = false;
  List<Order> orders = [];
  List<Order> orders2 = [];
  List<Order>? orders3 = [];
  bool done = false;
  Order order = Order(
    id: '',
    orderState: '',
    customerId: '',
    providerId: '',
    cost: '',
    serviceId: '',
    paymentWay: '',
    providerLocation: LatLng(0, 0),
    customerLocation: LatLng(0, 0),
    createdTime: fs.Timestamp(0, 0),
  );
  Future<Order> getOrder(String orderId) async {
    OrderCubit orderCubit = OrderCubit.instance(context);
    Order? order = await orderCubit.getOrder(orderId.toString());
    return order! ;


  }
  late  fs.QuerySnapshot<Map<String, dynamic>> initialdata;
  @override
  void initState() {


    initialData();
    super.initState();
  }

  Future<void> initialData() async {
    initialdata = await fs.FirebaseFirestore.instance
        .collection("Orders")
        .where('provider_id', isEqualTo: widget.provider.id).orderBy('created_at',descending: true)
        .get();
    Future.delayed(Duration(milliseconds: 500), () async {
      // setState(() {});
      orders.clear();
      for (int i = 0; i < initialdata.size; i++) {
        // await getOrder2(initialdata!.docs[i].data()['order_id']);

       /*   LoginCubit loginCubit = LoginCubit.instance(context);
          OrderCubit orderCubit = OrderCubit.instance(context);
          Order order = (await orderCubit.getOrder(
              initialdata!.docs[i].data()['order_id']))!;
          Customer customer =
          await loginCubit.getCustomerById2(order.customerId.toString());
          order.customer = customer;*/
          Map<String, dynamic>? map = {
            'id': order.id.toString(),
            'type': "1"
          };
          if (initialdata.docs[i].data()['order_state']! == 'open') {
            Workmanager().registerOneOffTask(
                UniqueKey().toString(), UniqueKey().toString(), inputData: map,
                initialDelay:
                Duration(seconds: initialdata.docs[i].data()['timer']!));
          }
       /*   orders.add(order);
          orders.sort((a, b) {
            return b.createdTime.compareTo(a.createdTime);
          });
*/
          //setState(() {});

      }
      done = true;
      setState(() {});
    });
  }
  Future<void> initialData2(dynamic initialdata) async {

    Future.delayed(Duration(milliseconds: 500), () async {
      // setState(() {});

      orders.clear();

      for (int i = 0; i < initialdata!.size; i++) {
        // await getOrder2(initialdata!.docs[i].data()['order_id']);

          OrderCubit orderCubit = OrderCubit.instance(context);
/*
          Order order = (await orderCubit.getOrder(
              initialdata!.docs[i].data()['order_id']))!;
*/

          Map<String, dynamic>? map = {
            'id': order.id.toString(),
            'type': "1"
          };
          if (initialdata!.docs[i].data()['order_state']! == 'open') {
            Workmanager().registerOneOffTask(
                UniqueKey().toString(), UniqueKey().toString(), inputData: map,
                initialDelay:
                Duration(seconds: initialdata!.docs[i].data()['timer']!));
          }
         // orders.add(order);
       /*   orders.sort((a, b) {
            return b.createdTime.compareTo(a.createdTime);
          });*/

         // setState(() {});

      }
      //done = true;
     // setState(() {});
    });
  }

  Future<void> getOrder2(dynamic data) async {
    LoginCubit loginCubit = LoginCubit.instance(context);
    OrderCubit orderCubit = OrderCubit.instance(context);
    Order order = (await orderCubit.getOrder(data))!;
    Customer customer =
        await loginCubit.getCustomerById2(order.customerId.toString());
    order.customer = customer;

    orders.add(order);

    setState(() {});
  }

  bool done2 = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18, right: 18, top: 16),
          child: MyDirectionality(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '  ${languageCubit.t1lc!} ${widget.provider.userName} ',
                  textDirection: languageCubit.language == 'EN'
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.cairo(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                StreamBuilder(
                  stream: fs.FirebaseFirestore.instance
                      .collection("Orders")
                      .where('provider_id', isEqualTo: widget.provider.id).orderBy('created_at',descending: true)
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print(widget.provider.id);
                    // Future.delayed(Duration(milliseconds: 2000), () async {
                    if (snapshot.data != null) {
                      initialdata = snapshot.data;
                      initialData2(initialdata);
                    }
                    OrderCubit order =
                    OrderCubit.instance(context);
                    ProviderHomeCubit providerHomeCubit =
                    ProviderHomeCubit.instance(context);

                    for(int i = 0 ; i < initialdata.docs.length ;i++){
                      print(initialdata.docs[i]
                          .data()['order_id']);

                    if (initialdata.docs[i]
                        .data()['order_state'] ==
                        'paycheck') {
                      print('-------');

                      print(initialdata.docs[i]
                          .data()['order_state'].toString());
                      providerHomeCubit
                          .makeOrderTapScreenStates(
                          initialdata.docs[i]
                              .data()['order_id']);
                      order.makeOrderPayCheck();
                    }

                    if (initialdata.docs[i]
                        .data()['order_state'] ==
                        'paynotcheck') {
                      print('-------');

                      providerHomeCubit
                          .makeOrderTapScreenStates(
                          initialdata.docs[i]
                              .data()['order_id']);
                      order.makeOrderPayDoesNotCheck();
                    }
                      if (initialdata.docs[i]
                          .data()['order_state'] ==
                          'accepted') {
                        print('-------');

                        providerHomeCubit
                            .makeOrderTapScreenStates(
                            initialdata.docs[i]
                                .data()['order_id']);
                        order.makeOrderAccepted();
                      }
                    }

                    // });
                    /*orders2.clear();
                    orders.clear();*/
                    done2 = false;

                    return SizedBox(
                      width: double.infinity,
                      height: size.height * 0.7,
                      child: ListView.builder(
                        //reverse: true,
                          itemCount: initialdata.size,
                          itemBuilder: (context, index) {
                            fs.Timestamp createdAt = initialdata.docs[index].data()['created_at'];
                          /*  orders[index].serviceType =
                            orders[index].serviceId == 11
                                ? languageCubit.Towing!
                                : orders[index].serviceId == 1
                                ? languageCubit.batteryCable!
                                :orders[index].serviceId == 15
                                ? languageCubit.changeBattery!
                                : orders[index].serviceId == 2
                                ? languageCubit.Carlocked!
                                : orders[index].serviceId == 3
                                ? languageCubit.Replacetire!:
                            orders[index].serviceId == 18
                                ? languageCubit.Repairtire2!
                                : languageCubit.Emptyfuel!;*/
                            return
                              GestureDetector(
                                onTap: () async{
                                  print('-------');
                                  print('-------');
                                  print('-------');
                                  print('-------');
                                  print('-------');
                                  print(initialdata.docs[index]
                                      .data()['order_state'].toString());
                                  OrderCubit order =
                                  OrderCubit.instance(context);
                                  ProviderHomeCubit providerHomeCubit =
                                  ProviderHomeCubit.instance(context);

                                  if (initialdata.docs[index]
                                      .data()['order_state'] ==
                                      'open') {
                                    setState(() {
                                      done = false;
                                    });
                                    Order order1 = await getOrder(initialdata.docs[index]
                                        .data()['order_id']);
                                    providerHomeCubit
                                        .makeOrderTapScreenStates(
                                        initialdata.docs[index]
                                            .data()['order_id']);
                                    order.makeOrderProviderAcceptAble(
                                        order1);
                                  }
                                  if (initialdata.docs[index]
                                      .data()['order_state'] ==
                                      'rejected') {
                                    providerHomeCubit
                                        .makeOrderTapScreenStates(
                                        initialdata.docs[index]
                                            .data()['order_id']);
                                    order.makeOrderRejected();
                                  }
                                  if (initialdata.docs[index]
                                      .data()['order_state'] ==
                                      'accepted') {
                                    setState(() {
                                      done = false;
                                    });
                                    Order order1 = await getOrder(initialdata.docs[index]
                                        .data()['order_id']);

                                    providerHomeCubit
                                      .makeOrderTapScreenStates(
                                      initialdata.docs[index]
                                          .data()['order_id']);
                                  order.makeOrderProviderAccepted(order1);
                                  }
                                  if (initialdata.docs[index]
                                      .data()['order_state'] ==
                                      'complete') {
                                    providerHomeCubit
                                        .makeOrderTapScreenStates(
                                        initialdata.docs[index]
                                            .data()['order_id']);
                                    order
                                        .makeOrderOrderFinishedSuccessfully();
                                  }
                                  if (initialdata.docs[index]
                                      .data()['order_state'] ==
                                      'canceled') {
                                    providerHomeCubit
                                        .makeOrderTapScreenStates(
                                        initialdata.docs[index]
                                            .data()['order_id']);
                                    order.makeOrderCanceled();
                                  }
                                  if (initialdata.docs[index]
                                      .data()['order_state'] ==
                                      'paycheck') {
                                    print('-------');
                                    print('-------');
                                    print('-------');
                                    print('-------');
                                    print('-------');
                                    print(initialdata.docs[index]
                                        .data()['order_state'].toString());
                                    providerHomeCubit
                                        .makeOrderTapScreenStates(
                                        initialdata.docs[index]
                                            .data()['order_id']);
                                    order.makeOrderPayCheck();
                                  }

                                  setState(() {
                                    orderTap = true;
                                  });

                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    elevation: 6,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10)),
                                    child: Container(
                                      width: size.width * 0.9,
                                      height: 130,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.white),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${languageCubit.timeSend!} :${createdAt.toDate().year}/${createdAt.toDate().month}/${createdAt.toDate().day} ${createdAt.toDate().hour}:${createdAt.toDate().minute}",
                                                  textAlign:
                                                  TextAlign.end,
                                                  style:
                                                  GoogleFonts.cairo(
                                                    fontSize: 10,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '${languageCubit.orderNumber} : ${initialdata.docs[index].data()['order_id'].toString()}',
                                                  textAlign:
                                                  TextAlign.end,
                                                  style:
                                                  GoogleFonts.cairo(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                              color: Colors.grey,
                                              width: double.infinity,
                                              height: 1,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              height: 70,
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  initialdata.docs[index]
                                                      .data()[
                                                  'order_state'] ==
                                                      'open'
                                                      ? Container(
                                                    width: 80,
                                                    height: 45,
                                                    decoration: const BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(
                                                            20)),
                                                        color:
                                                        kPrimaryColor),
                                                    child: Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(
                                                          languageCubit
                                                              .open!,
                                                          textAlign:
                                                          TextAlign
                                                              .end,
                                                          style: GoogleFonts
                                                              .cairo(
                                                            fontSize:
                                                            15,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            color: Colors
                                                                .white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                      : initialdata.docs[index]
                                                      .data()[
                                                  'order_state'] ==
                                                      'rejected'
                                                      ? Container(
                                                    width: 80,
                                                    height: 35,
                                                    decoration:
                                                    BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                          kAppBar,
                                                          width:
                                                          1.5),
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                    ),
                                                    child:
                                                    Center(
                                                      child:
                                                      Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Text(
                                                          languageCubit
                                                              .rejected!,
                                                          textAlign:
                                                          TextAlign.end,
                                                          style: GoogleFonts
                                                              .cairo(
                                                            fontSize:
                                                            15,
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            color:
                                                            kAppBar,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                      : initialdata.docs[index].data()[
                                                  'order_state'] ==
                                                      'canceled'
                                                      ? Container(
                                                    // width:
                                                    // 70,
                                                    height:
                                                    40,
                                                    decoration:
                                                    BoxDecoration(
                                                      border: Border.all(
                                                          color: kAppBar,
                                                          width: 1.5),
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(20)),
                                                    ),
                                                    child:
                                                    Center(
                                                      child:
                                                      Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Text(
                                                          languageCubit.canceled!,
                                                          textAlign:
                                                          TextAlign.end,
                                                          style:
                                                          GoogleFonts.cairo(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600,
                                                            color: kAppBar,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                      : initialdata.docs[index].data()['order_state'] ==
                                                      'accepted'
                                                      ? Container(

                                                    height:
                                                    40,
                                                    decoration:
                                                    BoxDecoration(
                                                      border: Border.all(color: kAppBar, width: 1.5),
                                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                                    ),
                                                    child:
                                                    Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Text(
                                                          languageCubit.acceptedOrder!,
                                                          textAlign: TextAlign.end,
                                                          style: GoogleFonts.cairo(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600,
                                                            color: kAppBar,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                      : initialdata.docs[index].data()['order_state'] ==
                                                      'timeout'
                                                      ? Container(
                                                  //  width: 70,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.red, width: 1.5),
                                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Text(
                                                          languageCubit.timeout!,
                                                          textAlign: TextAlign.end,
                                                          style: GoogleFonts.cairo(
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                      : initialdata.docs[index].data()['order_state'] ==
                                                      'paycheck'
                                                      ? Container(
                                                   // width: 100,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: kPrimaryColor, width: 1.5),
                                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Text(
                                                          languageCubit.payCheck!,
                                                          textAlign: TextAlign.end,
                                                          style: GoogleFonts.cairo(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600,
                                                            color: kPrimaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                      : Container(
                                                    // width: 70,
                                                    height: 40,
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.grey.shade800),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                      child: Center(
                                                        child: Text(
                                                          languageCubit.complete!,
                                                          textAlign: TextAlign.end,
                                                          style: GoogleFonts.cairo(
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Text(
                                                        initialdata.docs[index].data()['customer_name'],
                                                        textAlign:
                                                        TextAlign.end,
                                                        style: GoogleFonts
                                                            .cairo(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight
                                                              .w600,
                                                          color: Colors
                                                              .black,
                                                        ),
                                                      ),
                                                      Text(initialdata.docs[index].data()['service_type']
                                                        /*orders[index].serviceId == 11
                                                            ? languageCubit.Towing!
                                                            : orders[index].serviceId == 1
                                                            ? languageCubit.batteryCable!
                                                            :orders[index].serviceId == 15
                                                            ? languageCubit.changeBattery!
                                                            : orders[index].serviceId == 2
                                                            ? languageCubit.Carlocked!
                                                            : orders[index].serviceId == 3
                                                            ? languageCubit.Replacetire!:
                                                        orders[index].serviceId == 18
                                                            ? languageCubit.Repairtire2!
                                                            : languageCubit.Emptyfuel!*/,
                                                        textAlign:
                                                        TextAlign.end,
                                                        style: GoogleFonts
                                                            .cairo(
                                                          fontSize: 14 ,
                                                          fontWeight:
                                                          FontWeight
                                                              .w600,
                                                          color:
                                                          kPrimaryColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 7,
                                                  ),
                                                  Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration:
                                                    BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                          kPrimaryColor,
                                                          width: 1.5),
                                                      borderRadius:
                                                      BorderRadius
                                                          .all(Radius
                                                          .circular(
                                                          5)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                          }),
                    ) ;
                  },
                ),
              ],
            ),
          ),
        ),
        done
            ? Container()
            : Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                ),
              )
      ],
    );
  }
}
/*FutureBuilder<List<Order>>(
                      initialData: orders,
                      future: getOrder1(initialdata!),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Order>> snapshot) {
                        if (snapshot.data != null) {
                          // orders.clear();
                          orders = snapshot.data!;
                          done2 = true;
                        }

                        print('-------------------------------');
                        print('-------------------------------');
                        print(orders.length);
                        print('-------------------------------');
                        print('-------------------------------');
                        return ;
                      },
                    );*/
/*Stack(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: size.height * 0.7,
                                  child: ListView.builder(
                                      itemCount: orders.length,
                                      itemBuilder: (context, index) {
                                        orders[index].serviceType = serviceType =
                                        orders[index].serviceId == 11
                                            ? languageCubit.Towing!
                                            : orders[index].serviceId == 1
                                            ? languageCubit.Batteryservices!
                                            : orders[index].serviceId == 2
                                            ? languageCubit.Carlocked!
                                            : orders[index].serviceId ==
                                            3
                                            ? languageCubit
                                            .Repairtire!
                                            : languageCubit
                                            .Emptyfuel!;
                                        return GestureDetector(
                                          onTap: () {
                                            OrderCubit order =
                                            OrderCubit.instance(context);
                                            ProviderHomeCubit providerHomeCubit =
                                            ProviderHomeCubit.instance(context);
                                            providerHomeCubit
                                                .makeOrderTapScreenStates(
                                                orders[index]);
                                            if (initialdata!.docs[index]
                                                .data()['order_state'] ==
                                                'open') {
                                              order.makeOrderProviderAcceptAble(
                                                  orders[index]);
                                            }
                                            if (initialdata!.docs[index]
                                                .data()['order_state'] ==
                                                'rejected') {
                                              order.makeOrderRejected();
                                            }
                                            if (initialdata!.docs[index]
                                                .data()['order_state'] ==
                                                'accepted') {
                                              order.makeOrderProviderAccepted(
                                                  orders[index]);
                                            }
                                            if (initialdata!.docs[index]
                                                .data()['order_state'] ==
                                                'complete') {
                                              order.emit(
                                                  OrderFinishedSuccessfully());
                                            }
                                            if (initialdata!.docs[index]
                                                .data()['order_state'] ==
                                                'canceled') {
                                              order.emit(OrderCanceled());
                                            }
                                            if (initialdata!.docs[index]
                                                .data()['order_state'] ==
                                                'timeout') {
                                              order.emit(OrderTimeOut());
                                            }

                                            setState(() {
                                              orderTap = true;
                                            });
                                            /* Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProviderOrderTapScreen();
                                }));*/
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Material(
                                              elevation: 6,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              child: Container(
                                                width: size.width * 0.85,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10)),
                                                    color: Colors.white),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            languageCubit
                                                                .timeSend! +
                                                                orders[index]
                                                                    .createdTime
                                                                    .toString()
                                                                    .substring(
                                                                    11, 16),
                                                            textAlign:
                                                            TextAlign.end,
                                                            style:
                                                            GoogleFonts.cairo(
                                                              fontSize: 12,
                                                              color: Colors.grey,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            '${languageCubit.orderNumber} : ${initialdata!.docs[index].data()['order_id']}',
                                                            textAlign:
                                                            TextAlign.end,
                                                            style:
                                                            GoogleFonts.cairo(
                                                              fontSize: 12,
                                                              color: Colors.grey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Container(
                                                        color: Colors.grey,
                                                        width: double.infinity,
                                                        height: 1,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      SizedBox(
                                                        height: 70,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            initialdata!.docs[index]
                                                                .data()[
                                                            'order_state'] ==
                                                                'open'
                                                                ? Container(
                                                              width: 70,
                                                              height: 35,
                                                              decoration: const BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius.all(Radius.circular(
                                                                      20)),
                                                                  color:
                                                                  kPrimaryColor),
                                                              child: Center(
                                                                child: Text(
                                                                  languageCubit
                                                                      .open!,
                                                                  textAlign:
                                                                  TextAlign
                                                                      .end,
                                                                  style: GoogleFonts
                                                                      .cairo(
                                                                    fontSize:
                                                                    15,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                                : initialdata!.docs[index]
                                                                .data()[
                                                            'order_state'] ==
                                                                'rejected'
                                                                ? Container(
                                                              width: 70,
                                                              height: 35,
                                                              decoration:
                                                              BoxDecoration(
                                                                border: Border.all(
                                                                    color:
                                                                    kAppBar,
                                                                    width:
                                                                    1.5),
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(20)),
                                                              ),
                                                              child:
                                                              Center(
                                                                child:
                                                                Text(
                                                                  languageCubit
                                                                      .rejected!,
                                                                  textAlign:
                                                                  TextAlign.end,
                                                                  style: GoogleFonts
                                                                      .cairo(
                                                                    fontSize:
                                                                    15,
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                    color:
                                                                    kAppBar,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                                : initialdata!.docs[index].data()[
                                                            'order_state'] ==
                                                                'canceled'
                                                                ? Container(
                                                              width:
                                                              70,
                                                              height:
                                                              35,
                                                              decoration:
                                                              BoxDecoration(
                                                                border: Border.all(
                                                                    color: kAppBar,
                                                                    width: 1.5),
                                                                borderRadius:
                                                                BorderRadius.all(Radius.circular(20)),
                                                              ),
                                                              child:
                                                              Center(
                                                                child:
                                                                Text(
                                                                  languageCubit.canceled!,
                                                                  textAlign:
                                                                  TextAlign.end,
                                                                  style:
                                                                  GoogleFonts.cairo(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: kAppBar,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                                : initialdata!.docs[index].data()['order_state'] ==
                                                                'accepted'
                                                                ? Container(
                                                              width:
                                                              70,
                                                              height:
                                                              35,
                                                              decoration:
                                                              BoxDecoration(
                                                                border: Border.all(color: kAppBar, width: 1.5),
                                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                              ),
                                                              child:
                                                              Center(
                                                                child: Text(
                                                                  languageCubit.acceptedOrder!,
                                                                  textAlign: TextAlign.end,
                                                                  style: GoogleFonts.cairo(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: kAppBar,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                                : initialdata!.docs[index].data()['order_state'] ==
                                                                'timeout'
                                                                ? Container(
                                                              width: 70,
                                                              height: 35,
                                                              decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.red, width: 1.5),
                                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  languageCubit.timeout!,
                                                                  textAlign: TextAlign.end,
                                                                  style: GoogleFonts.cairo(
                                                                    fontSize: 17,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Colors.red,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                                : Container(
                                                              // width: 70,
                                                              height: 35,
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.grey.shade800),
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                                child: Center(
                                                                  child: Text(
                                                                    languageCubit.complete!,
                                                                    textAlign: TextAlign.end,
                                                                    style: GoogleFonts.cairo(
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.w600,
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                              children: [
                                                                Text(
                                                                  orders[index]
                                                                      .customer!
                                                                      .userName,
                                                                  textAlign:
                                                                  TextAlign.end,
                                                                  style: GoogleFonts
                                                                      .cairo(
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  orders[index]
                                                                      .serviceType,
                                                                  textAlign:
                                                                  TextAlign.end,
                                                                  style: GoogleFonts
                                                                      .cairo(
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                    color:
                                                                    kPrimaryColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 7,
                                                            ),
                                                            Container(
                                                              width: 60,
                                                              height: 60,
                                                              decoration:
                                                              BoxDecoration(
                                                                border: Border.all(
                                                                    color:
                                                                    kPrimaryColor,
                                                                    width: 1.5),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    5)),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                done2
                                    ? Container()
                                    : Container(
                                  width: double.infinity,
                                  height: size.height * 0.7,
                                  color: Colors.white,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                )
                              ],
                            )*/
