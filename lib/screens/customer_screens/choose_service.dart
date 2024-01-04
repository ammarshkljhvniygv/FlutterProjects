import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/manager/background_container.dart';
import 'package:onroad/screens/customer_screens/custmer_location_screen.dart';
import 'package:onroad/widget/circle_checkbox.dart';
import 'package:onroad/widget/mydirection.dart';

class ChooseService extends StatefulWidget {
  ChooseService({Key? key, required this.battery}) : super(key: key);
  bool battery;

  @override
  State<ChooseService> createState() => _ChooseServiceState();
}

class _ChooseServiceState extends State<ChooseService> {
  bool val1 = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return MyDirectionality(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kAppBar,
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
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: RotatedBox(
                          quarterTurns: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  languageCubit.chserv!,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 125,
                  ),
                  Material(
                    elevation: 6,
                    child: Container(
                        height: 274,
                        width: size.width * 0.75,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                widget.battery
                                    ? languageCubit.batteryServ!
                                    : languageCubit.tireServ!,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              /*Text(
                          'شكراً لكونك من مزودينا الرائعين',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF44455B),
                          ),
                        ),*/
                              SizedBox(
                                height: size.height * 0.04,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    val1 = true;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.battery
                                          ? languageCubit.batteryCable!
                                          : languageCubit.Replacetire!,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    CircleCheckBox(
                                      onTap: () {
                                        setState(() {
                                          val1 = true;
                                        });
                                      },
                                      value: val1,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    val1 = false;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.52,
                                      child: Text(
                                        widget.battery
                                            ? languageCubit.changeBattery!
                                            : languageCubit.Repairtire2!,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    CircleCheckBox(
                                      onTap: () {
                                        setState(() {
                                          val1 = false;
                                        });
                                      },
                                      value: !val1,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!widget.battery) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CustomerLocationScreen(
                              serviceType: val1 ? 51 : 52);
                        }));
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CustomerLocationScreen(
                              serviceType: val1 ? 21: 22);
                        }));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 56,
                      width: size.width * 0.75,
                      decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7))),
                      child: Center(
                        child: Text(
                          languageCubit.location!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
