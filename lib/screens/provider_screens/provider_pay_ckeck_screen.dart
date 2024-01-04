



import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/order_cubit.dart';

import '../../StateManagement/blocs/language_cubit.dart';
import '../../constant.dart';
import '../../manager/background_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart'as fs;

import '../../models/order.dart';

class ProviderPayCheckScreen extends StatefulWidget {
  const ProviderPayCheckScreen({Key? key,required this.orderId}) : super(key: key);
final  String orderId ;

  @override
  State<ProviderPayCheckScreen> createState() => _ProviderPayCheckScreenState();
}

class _ProviderPayCheckScreenState extends State<ProviderPayCheckScreen> {
 Order? order  ;
 bool? done = false ;

 Future<void> setStateUser(String providerId) async {
   await fs.FirebaseFirestore.instance
       .collection('ActiveProvider')
       .doc(providerId.toString())
       .update({
     'active': 'active'
   });
   print("-------------------------------------------------------------");
 }

  Future<void> updateOrderState(String state) async {

    await fs.FirebaseFirestore.instance
        .collection("Orders")
        .doc(widget.orderId.toString())
        .update({'order_state': state});
  }
  @override
  void initState() {
    getOrder(widget.orderId);
    // TODO: implement initState
    super.initState();
  }
  Future getOrder(id)async{
    OrderCubit orderCubit = OrderCubit.instance(context);
    order = await orderCubit.getOrder(id);
    setState(() {
      done = true ;
    });

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
body:done!? Stack(
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
                      languageCubit.payCheck!,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Text(
                      languageCubit.payCheck2!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF44455B),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Text(
                         order!.cost.toString() + ((languageCubit.language)=='AR'?' دينار ':' KD ') ,
                      textAlign: TextAlign.center,
                      textDirection:(languageCubit.language)=='AR'? TextDirection.rtl:TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF44455B),
                      ),
                    ),
                    Spacer(),
                    MaterialButton(
                        onPressed: ()async{
                         await setStateUser(order!.providerId.toString());
                          OrderCubit order1 = OrderCubit.instance(context);
                         await updateOrderState('paychecked');
                          order1.updateOrderState('paychecked', widget.orderId.toString());

                          order1.makeOrderOrderFinishedSuccessfully();
                        },
                      color: kPrimaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          languageCubit.checked!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
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
                          await updateOrderState('paynotcheck');
                          OrderCubit order = OrderCubit.instance(context);
                          order.updateOrderState('pay not check', widget.orderId.toString());

                        },
                      color: kPrimaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          languageCubit.doesNotCheck!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
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
):Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
