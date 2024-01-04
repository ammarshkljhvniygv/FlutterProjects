import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/StateManagement/blocs/update_profile_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/manager/cash_manager.dart';
import 'package:onroad/models/provider.dart';
import 'package:onroad/screens/add_card_screen.dart';
import 'package:onroad/widget/circle_checkbox.dart';
import 'package:onroad/widget/field.dart';
import 'package:onroad/widget/mydirection.dart';
import 'package:pinput/pinput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../main.dart';
import '../../manager/notification_manager.dart';
import '../../models/user_data.dart';


class ProviderProfileScreen extends StatefulWidget {
  const ProviderProfileScreen({Key? key, required this.provider})
      : super(key: key);
  final Provider provider;

  @override
  State<ProviderProfileScreen> createState() => _ProviderProfilScreenState();
}

class _ProviderProfilScreenState extends State<ProviderProfileScreen>
    with TickerProviderStateMixin {
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


  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late TabController tabController;
  late PageController pageController = PageController();
  int currentIndex = 0;
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  final TextEditingController _textEditingController4 = TextEditingController();
  final TextEditingController _textEditingController5 = TextEditingController();
  bool? obscureText = false;
  bool? update = true;
  bool addCard = false;
  String? result;
  @override
  void initState() {


    _textEditingController1.setText(widget.provider.email);
    _textEditingController5.setText(widget.provider.userName);
    _textEditingController2.setText(widget.provider.password);
    _textEditingController4.setText(widget.provider.phoneNumber);
    val1 = widget.provider.repairShop;
    val2 = widget.provider.license;

    val3 = widget.provider.workType == 'Company' ? true : false;
    val4 = widget.provider.services!.contains(3) ? true : false;
    val10 = widget.provider.services!.contains(4) ? true : false;
    val5 = widget.provider.services!.contains(2) ? true : false;
    val7 = widget.provider.services!.contains(1) ? true : false;
    val6 = widget.provider.services!.contains(15) ? true : false;
    val8 = widget.provider.services!.contains(16) ? true : false;
    val9 = widget.provider.services!.contains(11) ? true : false;
    // val9 = widget.provider.services!.contains(1) ? true : false;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }
  Future<void> updateServices(dynamic services) async {
    await FirebaseFirestore.instance
        .collection("ActiveProvider")
        .doc(widget.provider.id.toString())
        .update({'services': services});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    UpdateProfileCubit updateProfileCubit =
        UpdateProfileCubit.instance(context);
       // updateProfileCubit.emit(UpdateProfileStateInitial());
    return MyDirectionality(
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.015,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (update!) {
                      update = false;
                    } else {
                      update = true;
                    }
                  });
                },
                child: Container(
                  width: size.width * 0.9,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: kPrimaryColor),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(7)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Center(
                      child: Text(
                          !update! ? languageCubit.show! : languageCubit.edit!,
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
              SizedBox(
                height: size.height * 0.015,
              ),
              Material(
                elevation: 6,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: size.width * 0.9,
                  // height: size.height * 0.,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: SizedBox(
                            height: size.height * 0.58,
                            child: PageView(
                              onPageChanged: (index) {
                                /* setState(() {
                              currentIndex = index;
                            });*/
                              },
                              physics: const NeverScrollableScrollPhysics(),
                              controller: pageController,
                              children: [
                                update!
                                    ? ProviderShowForm(
                                        onPressed: () {
                                          setState(() {
                                            addCard = true;
                                          });
                                        },
                                        provider: widget.provider,
                                      )
                                    : Column(
                                        children: [
                                          Field(
                                              text: languageCubit.UserName!,
                                              validatText:
                                                  languageCubit.youHaveTo! +
                                                      languageCubit.UserName!,
                                              readOnly: false,
                                              suffixIcon: Icon(Icons.person),
                                              controller:
                                                  _textEditingController5,
                                              maxWidth: 49,
                                              obscureText: false),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          Field(
                                              text: languageCubit.email!,
                                              validatText:
                                                  languageCubit.youHaveTo! +
                                                      languageCubit.email!,
                                              readOnly: false,
                                              suffixIcon: Icon(Icons.email),
                                              controller:
                                                  _textEditingController1,
                                              maxWidth: 100,
                                              obscureText: false),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          Field(
                                            text: languageCubit.Password!,
                                            validatText:
                                                languageCubit.youHaveTo! +
                                                    languageCubit.Password!,
                                            readOnly: false,
                                            suffixIcon: !obscureText!
                                                ? IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        obscureText = true;
                                                      });
                                                    },
                                                    icon: Icon(
                                                        Icons.visibility_off),
                                                  )
                                                : IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        obscureText = false;
                                                      });
                                                    },
                                                    icon:
                                                        Icon(Icons.visibility),
                                                  ),
                                            maxWidth: 110,
                                            obscureText: obscureText!,
                                            controller: _textEditingController2,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          /*    IntlPhoneField2(
                                            phone: false,
                                            cursorHeight: 25,
                                            cursorColor: kPrimaryColor,
                                            controller: _textEditingController4,
                                            validator: (text) {
                                              if (text == null || text == "") {
                                                return languageCubit.Mobile!;
                                              }
                                              return null;
                                            },
                                            disableLengthCheck: true,
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(height: 0.9),
                                            decoration: InputDecoration(
                                                // labelStyle: const TextStyle(height: 10,),

                                                hintStyle: const TextStyle(
                                                    color: kPrimaryColor2),
                                                label: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12.0,
                                                          bottom: 12,
                                                          right: 12),
                                                  child: Text(
                                                      languageCubit.Mobile!,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        // fontWeight: FontWeight.w300,
                                                        color: Color.fromARGB(
                                                            255, 191, 191, 191),
                                                      )),
                                                )

                                                */ /*suffixIcon:  Padding(
                              padding:  EdgeInsets.only(top:12.0,bottom:12,right: 12),
                              child: Text(" : رقم الهاتف",
                                style: TextStyle(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.w300,
                                  color: Color.fromARGB(255, 191, 191, 191),

                                )
                              ),
                            ),*/ /*
                                                ),
                                            initialValue: "+965",
                                            onChanged: (phone) {
                                              print(phone.completeNumber);
                                              setState(() {
                                                // countryNumber = phone.completeNumber;
                                              });
                                            },
                                            onCountryChanged: (country) {
                                              print('Country changed to: ' +
                                                  country.name);
                                            },
                                          ),*/
                                        ],
                                      ),
                                Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: size.width,
                                        ),
                                        Text(
                                          languageCubit.tq1r2!,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              languageCubit.no!,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontSize: 14,
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
                                              style: TextStyle(
                                                fontSize: 14,
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
                                          height: size.height * 0.0,
                                        ),
                                        Text(
                                          languageCubit.tq2r2!,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        SizedBox(
                                          height: 45,
                                          width: 200,
                                          child: Field(
                                              text: languageCubit.WriteAddress!,
                                              validatText: languageCubit
                                                      .youHaveTo! +
                                                  languageCubit.WriteAddress!,
                                              readOnly: false,
                                              suffixIcon: SizedBox(
                                                width: 0,
                                                height: 0,
                                              ),
                                              // controller: _textEditingController1,
                                              maxWidth: 100,
                                              obscureText: false),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.0,
                                        ),
                                        Text(
                                          languageCubit.tq3r2!,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              languageCubit.no!,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontSize: 14,
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
                                              style: TextStyle(
                                                fontSize: 14,
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
                                          height: size.height * 0.00,
                                        ),
                                        Text(
                                          languageCubit.tq4r2!,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              languageCubit.Company!,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontSize: 14,
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
                                              style: TextStyle(
                                                fontSize: 14,
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
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.85,
                                          height: size.height * 0.2,
                                          child: GridView.count(
                                            physics: NeverScrollableScrollPhysics(),
                                            controller:
                                            ScrollController(keepScrollOffset: false),
                                            crossAxisCount: 2,
                                            childAspectRatio: 4.5,
                                            mainAxisSpacing: 0,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    languageCubit.Replacetire2!,
                                                    textAlign: TextAlign.end,
                                                    style: GoogleFonts.cairo(
                                                      fontSize: 16,
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
                                                      fontSize: 16,
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
                                                      fontSize: 16,
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
                                                      fontSize: 16,
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
                                                          ? 13
                                                          : 16,
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
                                                      fontSize: 16,
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
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  Checkbox(
                                                      activeColor: kPrimaryColor,
                                                      value: false,
                                                      onChanged: (val) {
                                                       /* setState(() {
                                                          val5 = val!;
                                                        });*/
                                                      }),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: TabBar(
                            indicatorColor: kPrimaryColor,
                            tabs: [
                              Text(
                                ' 1',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              Text(
                                '2',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                            ],
                            controller: TabController(length: 2, vsync: this),
                            onTap: (index) {
                              pageController.animateToPage(index,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.linear);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              GestureDetector(
                onTap: () async {
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

                  UpdateProfileCubit updateProfileCubit =
                      UpdateProfileCubit.instance(context);

                  await updateServices(services);
                  result = await updateProfileCubit.updateProviderProfile(
                      widget.provider.id,
                      _textEditingController5.text,
                      _textEditingController4.text,
                      _textEditingController1.text,
                      _textEditingController2.text,
                      val2,
                      val1,
                      !val3 ? 'Independent' : 'Company',
                      widget.provider.carNumber,
                      services,
                      context);
                  //setState(() {});


                  /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                    return SuccessRegistrationScreen();
                                  }));*/
                },
                child: Container(
                  width: size.width * 0.9,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Center(
                      child: Text(languageCubit.Save!,
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
          ),
          addCard
              ? AddCardScreen(onTap: () {
                  setState(() {
                    addCard = false;
                  });
                })
              : Container()
        ],
      ),
    );
  }
}

class ProviderShowForm extends StatefulWidget {
  const ProviderShowForm(
      {Key? key, required this.onPressed, required this.provider})
      : super(key: key);
  final VoidCallback onPressed;
  final Provider provider;

  @override
  State<ProviderShowForm> createState() => _ProviderShowFormState();
}

class _ProviderShowFormState extends State<ProviderShowForm> {
  bool? active = false;

  @override
  void initState() {
    active = CacheManager.getInstance()!.getUserData().sound!;
    print(active);
    print(active);
    print(active);
    print(active);
    print(active);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        ProfileItem(
          text: languageCubit.UserName!,
          val: widget.provider.userName,
          dropdown: false,
          icon: const Icon(
            Icons.person,
            color: Colors.grey,
            size: 30,
          ),
        ),
        ProfileItem(
          text: languageCubit.email!,
          val: widget.provider.email,
          dropdown: false,
          icon: const Icon(
            Icons.email_outlined,
            color: Colors.grey,
            size: 30,
          ),
        ),
        ProfileItem(
          text: languageCubit.Password!,
          val: widget.provider.password,
          dropdown: false,
          icon: const Icon(
            Icons.visibility_off_rounded,
            color: Colors.grey,
            size: 30,
          ),
        ),
        ProfileItem(
            text: languageCubit.Mobile!,
            val: widget.provider.phoneNumber,
            dropdown: false,
            icon: SizedBox(
              width: 0,
              height: 0,
            )),
       /* ProfileItem(
          text: languageCubit.addCard!,
          val: "لا يوجد ",
          dropdown: false,
          icon: IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.add,
              color: Colors.grey,
              size: 30,
            ),
          ),
        ),*/
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Theme(
                        data: ThemeData(
                          dialogTheme: DialogTheme(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                        child: AlertDialog(
                          content: SizedBox(
                            width: 350,
                            height: 175,
                            child: Column(
                              children: [
                                Text(languageCubit.deleteAccount2!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: size.width * 0.3,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(7)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 0.0),
                                          child: Center(
                                            child: Text(languageCubit.no!,
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
                                    GestureDetector(
                                      onTap: () async {
                                        UpdateProfileCubit updateProfileCubit =
                                            UpdateProfileCubit.instance(
                                                context);
                                        if (await updateProfileCubit
                                            .updateProviderAccountState(
                                                widget.provider.id.toString(),false)) {
                                          await FirebaseFirestore.instance
                                              .collection('ActiveProvider')
                                              .doc(widget.provider.id.toString())
                                              .update({
                                            'active': 'inactive',
                                          });
                                          await CacheManager.getInstance()!
                                              .logout();
                                          Navigator.pop(context);
                                          LoginCubit loginCubit =
                                              LoginCubit.instance(context);
                                          loginCubit.logout();

                                        }

                                        /* OrderCubit order =
                                                  OrderCubit.instance(context);
                                                  order.makeOrderCanceled();*/
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: kPrimaryColor),
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(7)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 0.0),
                                          child: Center(
                                            child: Text(languageCubit.yes!,
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
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              child: Container(
                width: size.width * 0.3,
               // height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: kPrimaryColor2),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(7)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all( 8.0),
                  child: Center(
                    child: Text(languageCubit.deleteAccount!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor2,
                        )),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(

                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          languageCubit.notificationSetting!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                    content: MyDirectionality(
                      child: SizedBox(
                        height: 80,
                        width: size.width*0.75,
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 0, top: 6, left: 0, bottom: 6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Transform.scale(
                                        scale: 1.2,
                                        child: Switch(
                                            inactiveTrackColor: Colors.grey,
                                            activeColor: kAppBar,
                                            value: active!,
                                            onChanged: (val) async{
                                              if(val){
                                                await FirebaseMessaging.instance.subscribeToTopic('p'+widget.provider.id.toString());

                                              }else{
                                                await FirebaseMessaging.instance.unsubscribeFromTopic('p'+widget.provider.id.toString());
                                              }

                                              UserData user = await CacheManager.getInstance()!
                                                  .getUserData();
                                              print(val);
                                              print(val);
                                              print(val);
                                              user.sound = val;
                                              await CacheManager.getInstance()!
                                                  .storeUserData(user);
                                               user = CacheManager.getInstance()!
                                                  .getUserData();
                                              print(user.sound);
                                              print(user.sound);
                                              print(user.sound);
                                              print(user.sound);

                                              await NotificationManager.listen!.cancel();

                                             RestartWidget.restartApp(context);

                                            }),
                                      ),
                                    ),
                                    // SizedBox(width: 50,),
                                    Spacer(),
                                    Text(
                                      languageCubit.notification!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryColor.withOpacity(0.7),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.notifications,
                                      color: /* color != index
                                                  ?*/
                                      kPrimaryColor
                                          .withOpacity(0.7) /* : Colors.white*/,
                                      size: 30,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                }, );
              },
              child: Container(
                width: size.width * 0.4,
              //  height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: kPrimaryColor2),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(7)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all( 8.0),
                  child: Center(
                    child: Text(languageCubit.notificationSetting!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor2,
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),

        /*   ProfileItem(
          text: "كلمة المرور الجديدة",
          val: "*********",
          dropdown: false,
          icon: const Icon(
            Icons.visibility_off,
            color: Colors.grey,
            size: 30,
          ),
        ),*/
      ],
    );
  }
}

class ProfileItem extends StatelessWidget {
  ProfileItem({
    Key? key,
    required this.text,
    required this.val,
    required this.dropdown,
    this.icon,
  }) : super(key: key);
  String text;
  String val;
  Widget? icon;
  bool dropdown;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              icon!,
              const Spacer(),
              Text(text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  )),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              Text(val,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.withOpacity(0.5),
          )
        ],
      ),
    );
  }
}
