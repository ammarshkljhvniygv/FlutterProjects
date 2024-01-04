import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/models/provider.dart';
import 'package:onroad/screens/success_registration_screen.dart';

import '../../constant.dart';
import '../../manager/notification_manager.dart';
import '../../widget/circle_checkbox.dart';
import '../../widget/field.dart';
import '../../widget/mydirection.dart';

class ProviderRegistrationScreen2 extends StatefulWidget {
  const ProviderRegistrationScreen2(
      {Key? key,
      required this.userName,
      required this.password,
      required this.phoneNumber,
      required this.email,
      required this.carNumber})
      : super(key: key);
  final String userName;
  final String phoneNumber;
  final String email;
  final String password;
  final String carNumber;

  @override
  State<ProviderRegistrationScreen2> createState() =>
      _ProviderRegistrationScreen2State();
}

class _ProviderRegistrationScreen2State
    extends State<ProviderRegistrationScreen2> {
  bool val1 = false;
  bool val2 = false;
  bool val3 = false;
  bool val4 = false;
  bool val5 = false;
  bool val6 = false;
  bool val7 = false;
  bool val8 = false;
  bool val9 = false;
  bool val10 = false;
  bool done = true;
  final TextEditingController addressController = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return MyDirectionality(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Image.asset(
                'assets/images/logo app.png',
                width: 75,
                height: 75,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: key,
                  child: MyDirectionality(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*  Image.asset(
                          'assets/images/Group 42.png',
                          width: size.width * 0.25,
                          color: Colors.grey.withOpacity(0.35),
                        ),*/
                            Column(
                              children: [
                                Text(
                                  languageCubit.t1r2!,
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.cairo(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor2,
                                  ),
                                ),
                                Text(
                                  languageCubit.t2r2!,
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.cairo(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryColor2,
                                  ),
                                ),
                              ],
                            ),
                            /* Image.asset(
                          'assets/images/Group 43.png',
                          width: size.width * 0.25,
                          color: Colors.grey.withOpacity(0.35),
                        ),*/
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 15, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: size.width,
                              ),
                              Text(
                                languageCubit.tq1r2!,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.cairo(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: kPrimaryColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    languageCubit.no!,
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.cairo(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  CircleCheckBox(
                                      // fillColor: MaterialStateProperty.(kPrimaryColor),
                                      // shape: const CircleBorder(),
                                      value: val1,
                                      onTap: () {
                                        setState(() {
                                          val1 = true;
                                        });
                                      }),
                                  SizedBox(
                                    width: size.width * 0.15,
                                  ),
                                  Text(
                                    languageCubit.yes!,
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.cairo(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  CircleCheckBox(
                                      value: !val1,
                                      onTap: () {
                                        setState(() {
                                          val1 = false;
                                        });
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                languageCubit.tq2r2!,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.cairo(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: kPrimaryColor,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Field(
                                  text: languageCubit.WriteAddress!,
                                  controller: addressController,
                                  validatText: languageCubit.youHaveTo! +
                                      languageCubit.WriteAddress!,
                                  readOnly: false,
                                  suffixIcon: SizedBox(
                                    width: 0,
                                    height: 0,
                                  ),
                                  // controller: _textEditingController1,
                                  maxWidth: 100,
                                  obscureText: false,),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                languageCubit.tq3r2!,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.cairo(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: kPrimaryColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    languageCubit.no!,
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.cairo(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  CircleCheckBox(
                                      value: val2,
                                      onTap: () {
                                        setState(() {
                                          val2 = true;
                                        });
                                      }),
                                  SizedBox(
                                    width: size.width * 0.15,
                                  ),
                                  Text(
                                    languageCubit.yes!,
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.cairo(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  CircleCheckBox(
                                      value: !val2,
                                      onTap: () {
                                        setState(() {
                                          val2 = false;
                                        });
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                languageCubit.tq4r2!,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.cairo(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: kPrimaryColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    languageCubit.Company!,
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.cairo(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  CircleCheckBox(
                                      value: val3,
                                      onTap: () {
                                        setState(() {
                                          val3 = true;
                                        });
                                      }),
                                  SizedBox(
                                    width: size.width * 0.15,
                                  ),
                                  Text(
                                    languageCubit.Independent!,
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.cairo(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  CircleCheckBox(
                                      value: !val3,
                                      onTap: () {
                                        setState(() {
                                          val3 = false;
                                        });
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                languageCubit.tq5r2!,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.cairo(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: kPrimaryColor,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.84,
                                height: size.height * 0.25,
                                child: GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  controller:
                                      ScrollController(keepScrollOffset: false),
                                  crossAxisCount: 2,
                                  childAspectRatio: 4,
                                  mainAxisSpacing: 0,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          languageCubit.Replacetire2!,
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            // color: kPrimaryColor,
                                          ),
                                        ),
                                        Checkbox(
                                            activeColor: kPrimaryColor,
                                            value: val4,
                                            onChanged: (val) {
                                              setState(() {
                                                val4 = val!;
                                              });
                                            }),
                                        /*   SizedBox(
                                          width: 47,
                                        ),*/
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          languageCubit.Repairtire3!,
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            // color: kPrimaryColor,
                                          ),
                                        ),
                                        Checkbox(
                                            activeColor: kPrimaryColor,
                                            value: val8,
                                            onChanged: (val) {
                                              setState(() {
                                                val8 = val!;
                                              });
                                            }),
                                        /*   SizedBox(
                                          width: 47,
                                        ),*/
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            languageCubit.changeBattery!,
                                            textAlign: TextAlign.end,
                                            style: GoogleFonts.cairo(
                                              fontSize: 14.5,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Checkbox(
                                            activeColor: kPrimaryColor,
                                            value: val6,
                                            onChanged: (val) {
                                              setState(() {
                                                val6 = val!;
                                              });
                                            }),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          languageCubit.batteryCable!,
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Checkbox(
                                            activeColor: kPrimaryColor,
                                            value: val7,
                                            onChanged: (val) {
                                              setState(() {
                                                val7 = val!;
                                              });
                                            }),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          languageCubit.Carlocked!,
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Checkbox(
                                            activeColor: kPrimaryColor,
                                            value: val5,
                                            onChanged: (val) {
                                              setState(() {
                                                 val5 = val!;
                                              });
                                            }),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          languageCubit.Towing!,
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.cairo(
                                            fontSize:
                                                languageCubit.language == 'AR'
                                                    ? 11
                                                    : 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Checkbox(
                                            activeColor: kPrimaryColor,
                                            value: val9,
                                            onChanged: (val) {
                                              setState(() {
                                                val9 = val!;
                                              });
                                            }),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          languageCubit.Emptyfuel!,
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Checkbox(
                                            activeColor: kPrimaryColor,
                                            value: val10,
                                            onChanged: (val) {
                                              setState(() {
                                                val10 = val!;
                                              });
                                            }),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          languageCubit.otherServ!,
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Checkbox(
                                            activeColor: kPrimaryColor,
                                            value: false,
                                            onChanged: (val) {
                                              setState(() {
                                                //val5 = val!;
                                              });
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (!val1) {
                                        if (!key.currentState!.validate()) {
                                          // return;
                                        } else {
                                          if (val4 ||
                                              val5 ||
                                              val6 ||
                                              val7 ||
                                              val8 ||
                                              val9||
                                          val10) {
                                            setState(() {
                                              done = false;
                                            });
                                            List<dynamic> services = [];
                                            if (val4) {
                                              services.add(3);
                                            }
                                            if (val5) {
                                              services.add(2);
                                            }
                                            if (val6) {
                                              services.add(15);
                                            }
                                            if (val7) {
                                              services.add(1);
                                            }
                                            if (val8) {
                                              services.add(16);
                                            }
                                            if (val9) {
                                              services.add(11);
                                            }
                                            if (val10) {
                                              services.add(4);
                                            }

                                            String address = addressController.text ;
                                            print(addressController.text);
                                            print(address);
                                            print(address);

                                            LoginCubit loginCubit =
                                                LoginCubit.instance(context);
                                            Provider provider = await loginCubit
                                                .registrationProvider(
                                                    widget.userName,
                                                    widget.phoneNumber,
                                                    widget.email,
                                                    widget.password,
                                                    val2,
                                                    val1,
                                                    address,
                                                    widget.carNumber,
                                                    !val3
                                                        ? 'Independent'
                                                        : 'Company',
                                                    services);
                                           await loginCubit.addJoiningRequest(providerId: provider.id.toString());
                                            try{
                                              await  FirebaseFirestore.instance.collection('DashBoardChats').doc('p'+provider.id.toString()).set({
                                                "provider_id":provider.id.toString(),
                                                "time":Timestamp.now(),
                                                "p_name":provider.userName,
                                                "customer_id":'null',
                                                "c_name":'null',
                                              });
                                              await FirebaseFirestore.instance.collection('DashBoardChats').doc('p'+provider.id.toString())
                                                  .collection('p'+provider.id.toString()).doc(provider.id.toString()).set({
                                                'provider': 'null',
                                                'support':'null',
                                                'time':Timestamp.now(),
                                                "image_url":"null"
                                              });
                                              print('doooooooooone');
                                            }catch(e){
                                              print(e);
                                            }
                                            await FirebaseFirestore.instance
                                                .collection('ActiveProvider')
                                                .doc(provider.id.toString())
                                                .set({
                                              'provider_id': provider.id,
                                              'lat': 0,
                                              'lng': 0,
                                              'active': 'inactive',
                                              'services': provider.services,
                                              'online':'false'

                                            });
                                            NotificationManager.sendNotification(
                                                "support",
                                                'New Joining Request',
                                                'There is new provider joining requests ,Go to active account for provider',
                                                false,
                                                false
                                            );
                                            setState(() {
                                              done = true;
                                            });

                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return SuccessRegistrationScreen();
                                            }));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor: Colors.red,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    content: Text(
                                                      languageCubit.r2t1!,
                                                      textAlign:
                                                          TextAlign.center,
                                                    )));
                                          }
                                        }
                                      } else {
                                        if (val4 ||
                                            val5 ||
                                            val6 ||
                                            val7 ||
                                            val8 ||
                                            val9||
                                            val10) {
                                          setState(() {
                                            done = false;
                                          });
                                          List<dynamic> services = [];
                                          if (val4) {
                                            services.add(3);
                                          }
                                          if (val5) {
                                            services.add(2);
                                          }
                                          if (val6) {
                                            services.add(15);
                                          }
                                          if (val7) {
                                            services.add(1);
                                          }
                                          if (val8) {
                                            services.add(16);
                                          }
                                          if (val9) {
                                            services.add(11);
                                          }
                                          if (val10) {
                                            services.add(4);
                                          }
                                          print('no address');
                                          print('no address');
                                          print('no address');

                                          LoginCubit loginCubit =
                                              LoginCubit.instance(context);
                                          Provider provider = await loginCubit
                                              .registrationProvider(
                                                  widget.userName,
                                                  widget.phoneNumber,
                                                  widget.email,
                                                  widget.password,
                                                  val2,
                                                  val1,
                                              'no address',
                                                  widget.carNumber,
                                                  !val3
                                                      ? 'Independent'
                                                      : 'Company',
                                                  services);
                                          await loginCubit.addJoiningRequest(providerId: provider.id.toString());
                                          try{
                                            await  FirebaseFirestore.instance.collection('DashBoardChats').doc('p'+provider.id.toString()).set({
                                              "provider_id":provider.id.toString(),
                                              "customer_id":'null',
                                              "c_name":'null',
                                              "time":Timestamp.now(),
                                              "p_name":provider.userName,

                                            });
                                            await FirebaseFirestore.instance.collection('DashBoardChats').doc('p'+provider.id.toString())
                                                .collection('p'+provider.id.toString()).doc(provider.id.toString()).set({
                                              'provider': 'null',
                                              'support':'null',
                                              'time':Timestamp.now(),
                                              "image_url":"null"
                                            });
                                            print('doooooooooone');
                                          }catch(e){
                                            print(e);
                                          }
                                          await FirebaseFirestore.instance
                                              .collection('ActiveProvider')
                                              .doc(provider.id.toString())
                                              .set({
                                            'provider_id': provider.id,
                                            'lat': 0,
                                            'lng': 0,
                                            'active': 'inactive',
                                            'services': provider.services,
                                            'online':'false'
                                          });
                                          NotificationManager.sendNotification(
                                              "support",
                                              'New Joining Request',
                                              'There is new provider joining requests ,Go to active account for provider',
                                              false,
                                              false
                                          );
                                          setState(() {
                                            done = true;
                                          });

                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return SuccessRegistrationScreen();
                                          }));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  content: Text(
                                                    languageCubit.r2t1!,
                                                    textAlign: TextAlign.center,
                                                  )));
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: size.width * 0.8,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(7)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 5.0),
                                        child: Text(languageCubit.SignUp!,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.cairo(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                  ),
                                  /*  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: size.width * 0.4,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border:
                                            Border.all(color: kPrimaryColor),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(7)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 5.0),
                                        child: Text(
                                            languageCubit.Customerservices!,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.cairo(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: kPrimaryColor,
                                            )),
                                      ),
                                    ),
                                  ),*/
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        // border: Border.all(color: Colors.grey,width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        color: kPrimaryColor),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        // border: Border.all(color: Colors.grey,width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        color: kPrimaryColor),
                                  ),
                                ],
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
          ),
          done
              ? Container()
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey.withOpacity(0.3),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
