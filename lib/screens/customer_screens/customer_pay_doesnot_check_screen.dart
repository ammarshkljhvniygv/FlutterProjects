



import 'package:flutter/material.dart';
import 'package:onroad/manager/cash_manager.dart';
import 'package:onroad/screens/support_chat_screen.dart';

import '../../StateManagement/blocs/language_cubit.dart';
import '../../StateManagement/blocs/order_cubit.dart';
import '../../constant.dart';
import '../../manager/background_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerPayDoesNotCheckScreen extends StatefulWidget {
  const CustomerPayDoesNotCheckScreen({Key? key,required this.orderId}) : super(key: key);
  final  String orderId ;

  @override
  State<CustomerPayDoesNotCheckScreen> createState() => _CustomerPayDoesNotCheckScreenState();
}

class _CustomerPayDoesNotCheckScreenState extends State<CustomerPayDoesNotCheckScreen> {
  Future<void> updateOrderState(String state) async {

    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(widget.orderId.toString())
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
        ),
        body: Stack(
          children: [
            RotatedBox(
              quarterTurns: 2,
              child: ClipPath(
                  clipper: BackgroundClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 320,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter,
                            colors: [kAppBar, kPrimaryColor])),
                  )),
            ),
            Center(
                child: Material(
                  elevation: 6,
                  child: Container(
                      height: 400,
                      width: size.width * 0.75,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [

                            Text(
                              languageCubit.doesNotCheck!,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Text(
                              languageCubit.chatSupport2!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF44455B),
                              ),
                            ),
                            Text(
                              languageCubit.language == 'AR'?'رقم الطلب : '+ widget.orderId:'Order number :'+ widget.orderId,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF44455B),
                              ),
                            ),
                            Spacer(),
                            MaterialButton(
                              onPressed: ()async{
                                await updateOrderState('paycheck');
                                OrderCubit orderCubit = OrderCubit.instance(context);
                                orderCubit.updateOrderState('paycheck', widget.orderId.toString());

                              },
                              color: kPrimaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  languageCubit.payT8!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            MaterialButton(
                              onPressed: ()async{
                                String id = CacheManager.getInstance()!.getUserData().userId!;

                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return SupportChatScreen(isProvider: false, CId: id, PId: '');
                                }));

                              },
                              color: kPrimaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  languageCubit.chatUs!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
