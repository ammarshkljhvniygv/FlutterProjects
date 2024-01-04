import 'package:flutter/material.dart';
// import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/screens/customer_screens/customer_registration_screen.dart';
import 'package:onroad/screens/otpverification_screen.dart';
import 'package:onroad/widget/field2.dart';
import 'package:onroad/widget/mydirection.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({Key? key}) : super(key: key);

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  String countryNumber = '';
  List<dynamic>? filterModels;
  List<dynamic>? models;
  bool filter = false;
  bool openFilter = false;
  bool model = false;
  bool done = false;
  bool phone = false;
  final TextEditingController _textEditingController4 = TextEditingController();
  // var controller = MaskedTextController(mask: '0000/0000', text: '12345678');
  GlobalKey<FormState> key = GlobalKey();

  String? makeId;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);
/*    */
    return Stack(
    children: [
      Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 35, left: 35),
            child: Form(
              key: key,
              child: MyDirectionality(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.0,
                    ),
                    Image.asset('assets/images/logo_with_logen.png'),

                    Text(
                      languageCubit.t1lc!,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor2,
                      ),
                    ),
                    Text(
                      languageCubit.t2lc!,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor2,
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
                          return languageCubit.youHaveTo! + languageCubit.Mobile!;
                        }
                        return null;
                      },
                      disableLengthCheck: true,
                      textAlign: languageCubit.language == 'AR'
                          ? TextAlign.right
                          : TextAlign.left,
                      style: const TextStyle(height: 0.9),
                      decoration: InputDecoration(
                        // labelStyle: const TextStyle(height: 10,),

                          hintStyle: const TextStyle(color: kPrimaryColor2),
                          label: Padding(
                            padding: const EdgeInsets.only(
                                top: 12.0, bottom: 12, right: 12),
                            child: Text(languageCubit.Mobile!,
                                style: TextStyle(
                                  fontSize: 12,
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
                    // phone? Row(
                    //   children:  [
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 20,top: 8,bottom: 8),
                    //       child: Text(
                    //         'يجب عليك ادخال رقم الهاتف',
                    //
                    //         style: TextStyle(
                    //             color: const Color(0xFFB30211).withOpacity(0.7),
                    //             fontSize: 13
                    //
                    //         ),),
                    //     ),
                    //   ],
                    // ):Container(),
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
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
                                    .checkPhoneNumber(countryNumber) ==
                                    'false') {
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
                                        languageCubit.phoneDNotE!,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.cairo(),
                                      )));

                                } else {
                                  bool done2 = await loginCubit
                                      .loginCustomer2(countryNumber);
                                  // Navigator.pop(context);
                                  if(done2) {
                                    setState(() {
                                      done = false ;
                                    });
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                          return VerificationScreen(
                                            countryNumber: countryNumber,
                                            carMake: '',
                                            userName: '',
                                            carModel: '',
                                            carColor: '',
                                          );
                                        }));

                                  }else{
                                    setState(() {
                                      done = false ;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior
                                            .floating,
                                        padding:
                                        EdgeInsets.all(
                                            10),
                                        content: Text(
                                          languageCubit.language == 'AR'?
                                          'الحساب غير مفعل':"Acoount Doesn't Active",

                                          textAlign:
                                          TextAlign.center,
                                        )));

                                  }
                                }

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
                              padding: EdgeInsets.only(top: 0.0),
                              child: Center(
                                child: Text(languageCubit.sendCode!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                  return RegistrationScreen();
                                }));
                          },
                          child: Text(languageCubit.regyourcar!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: kPrimaryColor2,
                              )),
                        ),
                        Text(languageCubit.DHaveaccount!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: kPrimaryColor,
                            )),
                      ],
                    )
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
    ],
    );
  }
}
