import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/manager/background_container.dart';

import '../../StateManagement/blocs/provider_cubit.dart';

class ProviderRejectedOrderScreen extends StatefulWidget {
  const ProviderRejectedOrderScreen({Key? key}) : super(key: key);

  @override
  State<ProviderRejectedOrderScreen> createState() =>
      _ProviderRejectedOrderScreenState();
}

class _ProviderRejectedOrderScreenState
    extends State<ProviderRejectedOrderScreen> {
  Timer? timer ;
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      ProviderHomeCubit providerHomeCubit =
      ProviderHomeCubit.instance(context);
      providerHomeCubit.makeHomeScreenStates();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);

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
                height: 472,
                width: size.width * 0.75,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Text(
                      languageCubit.rejectDon!,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.cairo(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    /*Text(
                      'شكراً لكونك من مزودينا الرائعين',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.cairo(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF44455B),
                      ),
                    ),*/
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    Image.asset(
                      'assets/images/Group 167.png',
                      width: 164,
                      height: 164,
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                  ],
                )),
          ))
        ],
      ),
    );
  }
}
