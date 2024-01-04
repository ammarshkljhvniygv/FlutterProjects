import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/screens/customer_screens/customer_login_screen.dart';
import 'package:onroad/screens/otpverification_screen.dart';
import 'package:onroad/widget/mydirection.dart';
import 'package:pinput/pinput.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../StateManagement/blocs/aboutas_cubit.dart';
import '../../StateManagement/blocs/car_cubit.dart';
import '../../StateManagement/blocs/car_state.dart';
import '../../constant.dart';
import '../../widget/field.dart';
import '../../widget/field2.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? countryNumber;
  List<dynamic> filterModels=[];
  List<dynamic> models=[];
  bool filter = false;
  bool openFilter = false;
  bool model = false;
  bool phone = false;
  bool done = false;
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  final TextEditingController _textEditingController3 = TextEditingController();
  final TextEditingController _textEditingController4 = TextEditingController();
  final TextEditingController _textEditingController5 = TextEditingController();
  // var controller = MaskedTextController(mask: '0000/0000', text: '12345678');
  GlobalKey<FormState> key = GlobalKey();
  late Animation<double> _fadeAnimation;
  late AnimationController _animationController;
  String? makeId;
  Future<void> launchingWhatsApp(String number) async {
    String url = "whatsapp://send?phone=+$number";
    await launchUrlString(url);
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    SettingCubit settingCubit = SettingCubit.instance(context);

    return Stack(
      children: [
        MyDirectionality(
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Image.asset(
                'assets/images/logo app.png',
                width: 75,
                height: 75,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 45, left: 50),
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.0,
                      ),
                      Row(
                        children: [
                          // Image.asset('assets/images/logo-removebg-preview.png',width: 100,height: 100,fit: BoxFit.fill,),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                languageCubit.t2rc!,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cairo(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor2,
                                ),
                              ),
                              Text(
                                languageCubit.t1rc!,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cairo(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Field(
                        obscureText: false,
                        text: languageCubit.UserName!,
                        validatText:
                            languageCubit.youHaveTo! + languageCubit.UserName!,
                        readOnly: false,
                        suffixIcon: Container(
                          width: 0,
                          height: 0,
                        ),
                        controller: _textEditingController5,
                        maxWidth: 49,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Field(
                          text: languageCubit.carMade!,
                          validatText:
                              languageCubit.youHaveTo! + languageCubit.carMade!,
                          readOnly: true,
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          controller: _textEditingController1,
                          onTap: () {
                            CarDataCubit carDataCubit =
                                CarDataCubit.instance(context);
                            carDataCubit.getCarMakes();
                            setState(() {
                              filter = false;
                              model = false;
                              openFilter = true;
                            });
                          },
                          maxWidth: 100,
                          obscureText: false),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Field(
                        text: languageCubit.carModel!,
                        validatText:
                            languageCubit.youHaveTo! + languageCubit.carModel!,
                        readOnly: true,
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        maxWidth: 110,
                        obscureText: false,
                        controller: _textEditingController2,
                        onTap: () {
                          CarDataCubit carDataCubit =
                              CarDataCubit.instance(context);
                          carDataCubit.getCarModelsByCarMake(makeId!);
                          setState(() {
                            filter = false;
                            model = true;
                            openFilter = true;
                          });
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Field(
                        text: languageCubit.carColor!,
                        validatText:
                            languageCubit.youHaveTo! + languageCubit.carColor!,
                        readOnly: false,
                        // keyboardType: TextInputType.number,
                        // maxLength: 4,
                        obscureText: false,

                        controller: _textEditingController3,
                        maxWidth: 100,
                        suffixIcon: Container(
                          width: 0,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      IntlPhoneField2(
                        phone: phone,
                        cursorHeight: 25,
                        cursorColor: kPrimaryColor,
                        controller: _textEditingController4,
                        validator: (text) {
                          if (text == null || text == "") {
                            return languageCubit.youHaveTo! +
                                languageCubit.Mobile!;
                          }
                          return null;
                        },
                        disableLengthCheck: true,
                        textAlign: TextAlign.right,
                        style: const TextStyle(height: 0.9),
                        decoration: InputDecoration(
                            // labelStyle: const TextStyle(height: 10,),

                            hintStyle: const TextStyle(color: kPrimaryColor2),
                            label: Padding(
                              padding: const EdgeInsets.only(
                                  top: 12.0, bottom: 12, right: 12),
                              child: Text(languageCubit.Mobile!,
                                  style: GoogleFonts.cairo(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 191, 191, 191),
                                  )),
                            )

                            /*suffixIcon:  Padding(
                            padding:  EdgeInsets.only(top:12.0,bottom:12,right: 12),
                            child: Text(" : رقم الهاتف",
                              style: GoogleFonts.cairo(
                                fontSize: 14,
                                // fontWeight: FontWeight.w300,
                                color: Color.fromARGB(255, 191, 191, 191),

                              )
                            ),
                          ),*/
                            ),
                        initialValue: "+965",
                        onChanged: (phone) {
                          print(phone.completeNumber);
                          setState(() {
                            countryNumber = phone.completeNumber;
                          });
                        },
                        onCountryChanged: (country) {
                          print('Country changed to: ' + country.name);
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {

                              /* Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) {
                                return */ /*OTPScreen(countryNumber!)*/ /*VerificationScreen(
                                    countryNumber: countryNumber
                                );
                              }));*/
                              if (!key.currentState!.validate()) {
                                // return;
                                if (_textEditingController4.text == '') {
                                  setState(() {
                                    phone = true;
                                  });
                                } else {
                                  setState(() {
                                    phone = false;
                                  });
                                }
                              } else {
                                if (_textEditingController4.text == '') {
                                  setState(() {
                                    phone = true;
                                  });
                                } else {

                                  setState(() {
                                    phone = false;
                                    done = true ;
                                  });
                                  LoginCubit loginCubit =
                                      LoginCubit.instance(context);
                                  if (await loginCubit
                                          .checkPhoneNumber(countryNumber!) ==
                                      'true') {
                                    setState(() {
                                      done = false ;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            duration: Duration(seconds: 5),
                                            backgroundColor: kAppBar,
                                            behavior: SnackBarBehavior.floating,
                                            padding: const EdgeInsets.all(10),
                                            content: Text(
                                              languageCubit.phoneUsed!,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.cairo(),
                                            )));
                                  } else {
                                    LoginCubit loginCubit =
                                    LoginCubit.instance(context);
                                    // loginCubit.login();
                                  /*  await loginCubit.registrationCustomer(
                                      _textEditingController5.text,
                                      countryNumber!,
                                      _textEditingController1.text,
                                      _textEditingController2.text,
                                      _textEditingController3.text,

                                    );*/
                                    setState(() {
                                      done = false ;

                                    });
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return VerificationScreen(
                                        countryNumber: countryNumber!,
                                        userName: _textEditingController5.text,
                                        carMake: _textEditingController1.text,
                                        carModel: _textEditingController2.text,
                                        carColor: _textEditingController3.text,
                                      );
                                    }));
                                  }
                                  /* loginCubit.registrationCustomer(
                                      _textEditingController5.text,
                                      _textEditingController4.text,
                                      _textEditingController1.text,
                                      _textEditingController2.text,
                                      _textEditingController3.text);*/
                                }
                              }
                            },
                            child: Container(
                              width: size.width * 0.75,
                              height: 56,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(7)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Text(languageCubit.sendCode!,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.cairo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                    return CustomerLoginScreen();
                                  }));
                            },
                            child: Text(languageCubit.login!,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cairo(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: kPrimaryColor2,
                                )),
                          ),
                          Text(languageCubit.Ahaveanaccount!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cairo(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: kPrimaryColor,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 75,
                            height: 1,
                            color: kPrimaryColor2,
                          ),
                          SizedBox(width: 5,),
                          Center(
                            child: Text(languageCubit.or!,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cairo(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: kPrimaryColor2,
                                )),
                          ),
                          SizedBox(width: 5,),

                          Container(
                            width: 75,
                            height: 1,
                            color: kPrimaryColor2,
                          ),
                        ],
                      ),

                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      FutureBuilder(
                        future: settingCubit.getOthers(),
                        builder: (context,links) {
                          return GestureDetector(
                            onTap: ()async{
                             await launchingWhatsApp(links.data![0]);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text(languageCubit.sendToUs!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: kPrimaryColor,
                                    )),
                                SizedBox(
                                width: 10,
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.facebook,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        done?Center(
          child: CircularProgressIndicator(),
        ):Container(),
        done?Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey.withOpacity(0.2),
        ):Container(),
        openFilter
            ? Scaffold(
                backgroundColor: Colors.black12,
                resizeToAvoidBottomInset: false,
                body: Center(
                  child: Container(
                    width: 325,
                    height: 600,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(width: 1, color: kPrimaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          /*    const Text("من فصلك قم باختيار موديل السيارة",
                        style: const TextStyle(
                          fontSize:17,
                          fontWeight: FontWeight.bold,
                          // color: kPrimaryColor2
                        ),
                      ),*/
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                filter = true;
                                if (val == "") {
                                  filterModels = models;
                                } else {
                                  if (model) {
                                    filterModels = models.where((element) => element
                                            .toString()
                                            .toLowerCase()
                                            .startsWith(val))
                                        .toList();
                                  } else {
                                    filterModels = models.where((element) => element.name
                                            .toString()
                                            .toLowerCase()
                                            .startsWith(val))
                                        .toList();
                                  }
                                }
                              });
                            },
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search),
                              hintText: "Search car brand",
                              hintStyle: GoogleFonts.cairo(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                                // color: kPrimaryColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 350,
                            height: 450,
                            child: BlocConsumer<CarDataCubit, CarDataStates>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state is GetCarModelsStarted) {
                                    return const Center(
                                        child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ));
                                  } else if (state
                                      is GetCarModelsFinishedSuccessfully) {
                                    print("---------${filterModels.length}");
                                    if (model) {
                                      models = state.carModels!;
                                    } else {
                                      models = state.carMakes!;
                                    }
                                    if (!filter) {
                                      filterModels = models;
                                    }
                                    return ListView.builder(
                                        itemCount: filterModels.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (model) {
                                                _textEditingController2
                                                    .setText(
                                                        filterModels[index]
                                                            .toString());
                                              } else {
                                                setState(() {
                                                  makeId =
                                                      filterModels[index]
                                                          .id
                                                          .toString();
                                                });
                                                _textEditingController1
                                                    .setText(
                                                        filterModels[index]
                                                            .name
                                                            .toString());
                                              }
                                              setState(() {
                                                openFilter = false;
                                              });
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                  border: const Border
                                                          .symmetric(
                                                      horizontal: BorderSide(
                                                          color: Colors.black,
                                                          width: 0.5))),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    model
                                                        ? filterModels[index]
                                                            .toString()
                                                        : filterModels[index]
                                                            .name
                                                            .toString(),
                                                    style: GoogleFonts.cairo(
                                                      fontSize: 16,
                                                      // fontWeight: FontWeight.w300,
                                                      // color: kPrimaryColor,
                                                    ),
                                                  )),
                                            ),
                                          );
                                        });
                                  } else {
                                    return Center(
                                      child: Container(
                                        color: Colors.transparent,
                                        height: 100,
                                        child: Text(
                                          'Error occurred while loading lessons,\nplease try again later ..',
                                          style: GoogleFonts.cairo(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            // color: kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  if (model) {
                                    _textEditingController2.setText('');
                                  } else {
                                    _textEditingController1.setText('');
                                  }
                                  setState(() {
                                    openFilter = false;
                                  });
                                },
                                child: Text(
                                  "ألغاء",
                                  style: GoogleFonts.cairo(
                                    fontSize: 16,
                                    // fontWeight: FontWeight.w400,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
