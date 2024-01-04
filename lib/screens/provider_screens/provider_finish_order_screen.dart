import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';

import '../../StateManagement/blocs/provider_cubit.dart';
import '../../constant.dart';
import '../../manager/background_container.dart';

class ProviderFinishOrderScreen extends StatefulWidget {
  const ProviderFinishOrderScreen({Key? key}) : super(key: key);

  @override
  State<ProviderFinishOrderScreen> createState() =>
      _ProviderFinishOrderScreenState();
}


class _ProviderFinishOrderScreenState extends State<ProviderFinishOrderScreen> {
  Timer? timer ;
  @override
  void initState() {

   /*

   timer = Timer.periodic(Duration(seconds: 2), (timer) {
      ProviderHomeCubit providerHomeCubit =
      ProviderHomeCubit.instance(context);
      providerHomeCubit.makeHomeScreenStates();
   });

   */


    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                height: size.height *0.65,
                width: size.width * 0.75,
                child: Column(

                  children: [
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Text(
                      languageCubit.helpDon!,
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
                      languageCubit.thanksP!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF44455B),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Image.asset(
                      'assets/images/Group 167.png',
                      width: 160,
                      height: 160,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.thumb_up,
                          color: kPrimaryColor2,
                        ),
                        SizedBox(
                          width: 250,
                          child: Text(
                            languageCubit.payDon!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        ProviderHomeCubit providerHomeCubit =
                        ProviderHomeCubit.instance(context);
                        providerHomeCubit.makeHomeScreenStates();
                      },
                      child: Container(
                        width: size.width * 0.3,
                        height: 45,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius:
                          const BorderRadius.all(const Radius.circular(7)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Center(
                            child: Text(languageCubit.trclose!,
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
                )),
          ))
        ],
      ),
    );
  }
}
