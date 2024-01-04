

import 'package:flutter/material.dart';

import '../../StateManagement/blocs/language_cubit.dart';
import '../../constant.dart';
import '../../manager/background_container.dart';

class ProviderPayDoesNotCheckScreen extends StatefulWidget {
  const ProviderPayDoesNotCheckScreen({Key? key,required this.orderId}) : super(key: key);
  final orderId ;

  @override
  State<ProviderPayDoesNotCheckScreen> createState() => _ProviderPayDoesNotCheckScreenState();
}

class _ProviderPayDoesNotCheckScreenState extends State<ProviderPayDoesNotCheckScreen> {
  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        return false ;
      },
      child: Scaffold(
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
                      height: 300,
                      width: size.width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [

                            Text(
                              languageCubit.doesNotCheck!,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Text(
                              languageCubit.chatSupport!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
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
