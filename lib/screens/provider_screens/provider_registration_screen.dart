import 'package:flutter/material.dart';
// import 'package:flutter_masked_text2/flutter_masked_text2.dart';
// import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/screens/add_card_screen.dart';
import 'package:onroad/screens/provider_screens/provider_login_screen.dart';
import 'package:onroad/screens/provider_screens/provider_registration_scren2.dart';
import 'package:onroad/screens/rouls_screen.dart';
import 'package:onroad/widget/field.dart';
import 'package:onroad/widget/field2.dart';
import 'package:onroad/widget/mydirection.dart';

class ProviderRegistrationScreen extends StatefulWidget {
  const ProviderRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<ProviderRegistrationScreen> createState() =>
      _ProviderRegistrationScreenState();
}

class _ProviderRegistrationScreenState
    extends State<ProviderRegistrationScreen> {
  String? countryNumber;
  List<dynamic>? filterModels;
  List<dynamic>? models;
  bool filter = false;
  bool openFilter = false;
  bool model = false;
  bool phone = false;
  bool? val1 = false;
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
  bool? obscureText = false;
  bool addCard = false;
  bool done = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);

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
              child: Form(
                key: key,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
/*
                            Image.asset(
                              'assets/images/Group 43.png',
                              width: size.width * 0.15,
                              color: Colors.grey.withOpacity(0.35),
                            ),
*/
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            children: [
                              Text(
                                languageCubit.t1r!,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.cairo(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor2,
                                ),
                              ),
                              Text(
                                languageCubit.t2r!,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.cairo(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
/*
                            Image.asset(
                              'assets/images/Group 42.png',
                              width: size.width * 0.15,
                              color: Colors.grey.withOpacity(0.35),
                            ),
*/
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.95,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 45, left: 50),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Field(
                                text: languageCubit.UserName!,
                                validatText: languageCubit.youHaveTo! +
                                    languageCubit.UserName!,
                                readOnly: false,
                                suffixIcon: SizedBox(
                                  width: 0,
                                  height: 0,
                                ),
                                controller: _textEditingController5,
                                maxWidth: 49,
                                obscureText: false),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                          /*  Field(
                                text: languageCubit.Email!,
                                validatText: languageCubit.youHaveTo! +
                                    languageCubit.Email!,
                                readOnly: false,
                                suffixIcon: Icon(Icons.email),
                                controller: _textEditingController1,
                                maxWidth: 100,
                                obscureText: false),
                            SizedBox(
                              height: size.height * 0.02,
                            ),*/
                            Field(
                              text: languageCubit.Password!,
                              validatText: languageCubit.youHaveTo! +
                                  languageCubit.Password!,
                              readOnly: false,
                              suffixIcon: !obscureText!
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obscureText = true;
                                        });
                                      },
                                      icon: Icon(Icons.visibility_off),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obscureText = false;
                                        });
                                      },
                                      icon: Icon(Icons.visibility),
                                    ),
                              maxWidth: 110,
                              obscureText: obscureText!,
                              controller: _textEditingController2,
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
                              style: const TextStyle(height: 0.9),
                              decoration: InputDecoration(
                                  // labelStyle: const TextStyle(height: 10,),

                                  hintStyle:
                                      const TextStyle(color: kPrimaryColor2),
                                  label: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0, bottom: 12, right: 12),
                                    child: Text(languageCubit.Mobile!,
                                        style: GoogleFonts.cairo(
                                          fontSize: 14,
                                          // fontWeight: FontWeight.w300,
                                          color: Color.fromARGB(
                                              255, 191, 191, 191),
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
                              height: size.height * 0.02,
                            ),
                            Field(
                              keyboardType: TextInputType.phone,
                                text: languageCubit.Yourcarnumber!,
                                validatText: languageCubit.youHaveTo! +
                                    languageCubit.Yourcarnumber!,
                                controller: _textEditingController3,
                                readOnly: false,
                                suffixIcon: SizedBox(
                                  width: 0,
                                  height: 0,
                                ),
                                // keyboardType: TextInputType.number,
                                // maxLength: 4,
                                // controller: controller,
                                maxWidth: 150,
                                obscureText: false),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            /*Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: Text(
                                    languageCubit.addCard!,
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.cairo(
                                      decoration: TextDecoration.underline,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      addCard = true;
                                    });
                                  },
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      addCard = true;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: Text(
                                    languageCubit.AcceptPrivacy!,
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.cairo(
                                      decoration: TextDecoration.underline,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ConditionsScreen();
                                    }));
                                  },
                                ),
                                Checkbox(
                                    value: val1,
                                    onChanged: (val) {
                                      setState(() {
                                        val1 = val!;
                                      });
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    /* Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return ProviderRegistrationScreen2();
                                    }));*/
                                    if (val1!) {
                                      if (!key.currentState!.validate()) {
                                        // return;
                                      } else {
                                        setState(() {
                                          done = true;
                                        });
                                        LoginCubit loginCubit =
                                            LoginCubit.instance(context);

                                        if (await loginCubit
                                                .checkProviderUserName(
                                                    _textEditingController5
                                                        .text) ==
                                            'true') {
                                          setState(() {
                                            done = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  content: Text(
                                                    'قم بتغيير اسم المستخدم الذي قمت بإدخاله ',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.cairo(),
                                                  )));
                                        } else {
                                          setState(() {
                                            done = false;
                                          });
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return ProviderRegistrationScreen2(
                                              carNumber:
                                                  _textEditingController3.text,
                                              userName:
                                                  _textEditingController5.text,
                                              phoneNumber:
                                                  _textEditingController4.text,
                                              email:
                                                  _textEditingController1.text,
                                              password:
                                                  _textEditingController2.text,
                                            );
                                          }));
                                        }
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.red,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              padding: const EdgeInsets.all(10),
                                              content: Text(
                                                languageCubit
                                                    .youHaveToAcceptPrivacy!,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.cairo(),
                                              )));
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
                                      child: Text(
                                          languageCubit.ContinueRegistration!,
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
                              height: size.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ProviderLoginScreen();
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
                              height: size.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.grey,width: 2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      color: kPrimaryColor),
                                ),
                                SizedBox(
                                  width: size.width * 0.05,
                                ),
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
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
        addCard
            ? AddCardScreen(onTap: () {
                setState(() {
                  addCard = false;
                });
              })
            : Container()
      ],
    );
  }
}
