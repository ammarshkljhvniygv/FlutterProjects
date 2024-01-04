import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/order_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/manager/background_container3.dart';
import 'package:onroad/manager/background_container4.dart';
import 'package:workmanager/workmanager.dart';

import 'package:flutter_background_service/flutter_background_service.dart';

class WaitScreen extends StatefulWidget {
  const WaitScreen({Key? key, required this.orderId}) : super(key: key);
  final String orderId;
  @override
  State<WaitScreen> createState() => WaitScreenState();
}

class WaitScreenState extends State<WaitScreen> with  WidgetsBindingObserver{
  AppLifecycleState? appLifecycleState;
 static final SetTimer setTimer = SetTimer();
  Timer? timer;
  int cunter = 120;


  Future<void> updateOrderTimer(dynamic timer) async {
    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(widget.orderId.toString())
        .update({'timer': timer});
  }


  @override
  void dispose() {
    // TODO: implement dispose
    print('dispose called.............');
    print('dispose called.............');
    print('dispose called.............');
    print('dispose called.............');
    SetTimer.stopTimer();
    timer!.cancel();

    // WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  final service = FlutterBackgroundService();


  @override
  void initState() {

    Map<String, dynamic>? map ={'id':widget.orderId.toString(),'type':"1"};
    Workmanager().registerOneOffTask(UniqueKey().toString(), UniqueKey().toString(),inputData: map,initialDelay: Duration(seconds: 120));

    WidgetsBinding.instance.addObserver(this);
    //  getOrderTimer();
     setTimer.start(widget.orderId.toString(),context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);


    return WillPopScope(
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
        body: Stack(
          children: [
            Container(
              height: size.height * 0.6,
              width: double.infinity,
              color: Color(0xFF2F3E8C),
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.3,
                  ),
                  ClipPath(
                    clipper: BackgroundClipper3(),
                    child: Container(
                      width: double.infinity,
                      height: 400,
                      color: Color(0xFF6268BD),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.3,
                  ),
                  ClipPath(
                    clipper: BackgroundClipper4(),
                    child: Container(
                      width: double.infinity,
                      height: 400,
                      color: kAppBar,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: Text(languageCubit.timerT!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                  Stack(
                    children: [
                      Image.asset('assets/images/Group 227.png'),
                      Positioned(
                        top: 75,
                        left: 85,
                        child: StreamBuilder<int>(
                          stream: setTimer.stream,
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<int> snapshot,
                          ) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.connectionState ==
                                    ConnectionState.active ||
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const Text('Error');
                              } else if (snapshot.hasData) {
                                return Text(
                                    /*cunter.toInt().toString()*/ snapshot.data
                                            .toString() +
                                        '',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.cairo(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ));
                              } else {
                                return const Text('Empty data');
                              }
                            } else {
                              return Text('State: ${snapshot.connectionState}');
                            }
                          },
                        ) /*Text(
                            */ /*cunter.toInt().toString()*/ /* _setTimer._seconds
                                    .toString() +
                                '',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ))*/
                        ,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class SetTimer {
  static int _seconds = 0;
  static final _streamController = StreamController<int>.broadcast();
  static Timer? _timer;

  // Getters
  Stream<int> get stream => _streamController.stream;

  // Setters
  void start(String orderId,BuildContext context) async {
    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(orderId.toString())
        .get()
        .then((value) {
      print(value.data()!['timer']);
      _seconds = value.data()!['timer'];
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (x) {
      print('------------------1');
      _seconds = _seconds - 1;
      _streamController.sink.add(_seconds);
      updateOrderTimer(_seconds, orderId);
      if (_seconds <= 0){
        _timer!.cancel();
        updateOrderState(orderId);
        OrderCubit orderCubit = OrderCubit.instance(context);
        orderCubit.updateOrderState('timeout', orderId.toString());

      }
    });
  }
  static void stopTimer(){
    _timer!.cancel();
  }

  Future<void> updateOrderTimer(dynamic timer, String orderId) async {
    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(orderId.toString())
        .update({'timer': timer});
  }

  Future<void> updateOrderState(String orderId) async {
    DocumentSnapshot<Map<String, dynamic>> order = await FirebaseFirestore
        .instance
        .collection("Orders")
        .doc(orderId.toString())
        .get();
    if (order.data()!['order_state'] == 'open') {
      await FirebaseFirestore.instance
          .collection("Orders")
          .doc(orderId.toString())
          .update({'order_state': 'timeout'});
    }
  }
}
