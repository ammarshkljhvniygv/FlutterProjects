import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_states.dart';
import 'package:onroad/manager/cash_manager.dart';
import 'package:onroad/models/user_data.dart';
import 'package:onroad/screens/customer_screens/customer_islogin_screen.dart';
import 'package:onroad/widget/mydirection.dart';
import 'package:pinput/pinput.dart';

import '../constant.dart';
class SetTimer2 {
  static int _seconds = 120;
  static final _streamController = StreamController<int>.broadcast();
  static Timer? _timer;

  // Getters
  Stream<int> get stream => _streamController.stream;

  // Setters
  void start() async {

    _timer = Timer.periodic(const Duration(seconds: 1), (x) {
      print('------------------1');
      _seconds = _seconds - 1;
      _streamController.sink.add(_seconds);
      if (_seconds <= 0){
        _timer!.cancel();
        _seconds = 120;
      }
    });
  }
   void stopTimer(){
    _timer!.cancel();
    _seconds = 120;
  }
}

class VerificationScreen extends StatefulWidget {
  VerificationScreen(
      {Key? key,
      required this.userName,
      required this.carMake,
      required this.carModel,
      required this.carColor,
      required this.countryNumber})
      : super(key: key);
  final String userName;
  final String countryNumber;
  final String carMake;
  final String carModel;
  final String carColor;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  static final SetTimer2 setTimer = SetTimer2();

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode = '';
  dynamic value;
  Timer? timer;
  int counter = 120;
  bool save = false;
  bool reSend = false;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color(0xFFDBDCDC),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.transparent,
    ),
  );

  @override
  void initState() {
    setTimer.start();
    print('------------------countryNumber : ========');

    print(widget.countryNumber);
/*   timer = Timer.periodic(Duration(seconds: 1), (timer) {
     setState(() {
       counter = counter - 1 ;
if(counter <=0){
  timer.cancel();
  reSend = true ;
}
     });

   });*/
    _verifyPhone();

    // TODO: implement initState
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
            key: _scaffoldkey,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Image.asset(
                'assets/images/logo app.png',
                width: 75,
                height: 75,
              ),
              centerTitle: true,
              // title: Image.asset(
              //   "assets/images/logo-removebg-preview.png",
              //   height: 75,
              //   width: 75,
              // ),
            ),
            body: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, right: 35, left: 35),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      Image.asset(
                        'assets/images/Group-76.png',
                        height: 201,
                        fit: BoxFit.contain,
                        width: 208,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        languageCubit.otp!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor2,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        languageCubit.t1otp!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                          color: kPrimaryColor2,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Pinput(
                            length: 6,
                            defaultPinTheme: PinTheme(
                              width: 35,
                              height: 45,
                              margin: const EdgeInsets.all(1),
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(30, 60, 87, 1),
                                  fontWeight: FontWeight.w600),
                              decoration: BoxDecoration(
                                border: Border.all(color: kPrimaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            focusNode: _pinPutFocusNode,
                            controller: _pinPutController,
                            pinAnimationType: PinAnimationType.fade,
                            onChanged: (val) {
                              setState(() {
                                value = val;
                                print(value);
                              });
                            },
                            onSubmitted: (pin) async {
                              try {
                                print('-------------------------1');

                                await FirebaseAuth.instance
                                    .signInWithCredential(
                                        PhoneAuthProvider.credential(
                                            verificationId: _verificationCode!,
                                            smsCode: pin))
                                    .then((value) async {
                                  if (value.user != null) {
                                    setState(() {
                                      save = false;
                                    });
                                    LoginCubit loginCubit =
                                    LoginCubit.instance(context);
                                    // loginCubit.login();
                                    if (widget.carMake != '') {
                                      await loginCubit.registrationCustomer(
                                        widget.userName,
                                        widget.countryNumber,
                                        widget.carMake,
                                        widget.carModel,
                                        widget.carColor,
                                      );
                                    } else {
                                      await loginCubit
                                          .loginCustomer(widget.countryNumber);
                                    }
                                  }
                                  else {
                                    print('-----------------------------e');

                                    FocusScope.of(context).unfocus();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: const Text('invalid OTP')));
                                  }
                                });
                              } catch (e) {
                                setState(() {
                                  save = false;
                                });
                                FocusScope.of(context).unfocus();
                                /*_scaffoldkey.currentState?.showSnackBar(
                                    const SnackBar(
                                        content: Text('invalid OTP')));*/
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      GestureDetector(
                        onTap: () async {
                          print('-------------------------1');

                          await FirebaseAuth.instance
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: _verificationCode!,
                                      smsCode: value))
                              .then((value) async {
                            if (value.user != null) {

                              LoginCubit loginCubit =
                                  LoginCubit.instance(context);
                              // loginCubit.login();
                              if (widget.carMake != '') {
                                await loginCubit.registrationCustomer(
                                  widget.userName,
                                  widget.countryNumber,
                                  widget.carMake,
                                  widget.carModel,
                                  widget.carColor,
                                );
                              } else {
                                await loginCubit
                                    .loginCustomer(widget.countryNumber);
                              }
                            }
                            else {
                              print('-----------------------------e');

                              FocusScope.of(context).unfocus();
                              /*_scaffoldkey.currentState.*/
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: const Text('invalid OTP')));
                            }
                          });
                          /*  } catch (e) {

                          }*/
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 56,
                          width: 228,
                          decoration: const BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7))),
                          child: Center(
                            child: Text(
                              languageCubit.Verification!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          reSend?MaterialButton(
                            onPressed: () async {
                              // _verifyPhone();
                              // Navigator.pop(context);
                              setTimer.start();
                              setState(() {
                                reSend = false ;
                              });
                              _verifyPhone();
                            },
                            child: Text(
                              languageCubit.resend!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kPrimaryColor2,
                              ),
                            ),
                          ):StreamBuilder<int>(
                            stream: setTimer.stream,
                            builder: (
                                BuildContext context,
                                AsyncSnapshot<int> snapshot,
                                ) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.connectionState ==
                                  ConnectionState.active ||
                                  snapshot.connectionState ==
                                      ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return const Text('Error');
                                } else if (snapshot.hasData) {
                                  if(snapshot.data! <= 0){
                                    setState(() {
                                      reSend = true ;
                                      // counter = 120;
                                    });
                                  }
                                  return Text(
                                     snapshot.data
                                      .toString() +
                                      '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: kPrimaryColor2,
                                    ),
                                  );
                                } else {
                                  return const Text('Empty data');
                                }
                              } else {
                                return Text('State: ${snapshot.connectionState}');
                              }
                            },
                          ),
                          Text(
                            languageCubit.t2otp!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                save
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black12,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        ))
                    : Container()
              ],
            ),
          ),
        ),
        BlocConsumer<LoginCubit, LoginStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LoginFinishedSuccessfully) {
                UserData userData = UserData(
                    sound: true,
                    userId: state.customer!.id.toString(),
                    userType: 'customer');
                CacheManager.getInstance()!.storeUserData(userData);
                Future.delayed(Duration(milliseconds: 500), () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return CustomerIsLoginScreen();
                  }));
                });
                return const SizedBox();
              } else if (state is LoginStarted) {
                return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black12,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    ));
              } else {
                return const SizedBox();
              }
            })
      ],
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.countryNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print(
              "-----------------------------------------onCompleted------------------------------------------");

          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {

              LoginCubit loginCubit =
              LoginCubit.instance(context);
              if (widget.carMake != '') {
                await loginCubit.registrationCustomer(
                  widget.userName,
                  widget.countryNumber,
                  widget.carMake,
                  widget.carModel,
                  widget.carColor,
                );
              } else {
                await loginCubit.loginCustomer(widget.countryNumber);
              }
            }
            else {
              print('-----------------------------e');

              FocusScope.of(context).unfocus();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: const Text('invalid OTP')));
            }
          });

        },
        verificationFailed: (FirebaseAuthException e) {
          print(
              "----------------------------------------------------hi------------------------------------------");

          print(e.message);
        },
        codeSent: (String verficationID, int? resendToken) async {
          print("----------------------------------------------------onsend------------------------------------------");

          /*print(resendToken!);
          print(verficationID!);*/

          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          print(        "----------------------------------------------------codeAutoRetrievalTimeout------------------------------------------");

          setState(() {
            _verificationCode = verificationID;
            reSend = true;
          });
          print(verificationID);
        },
        timeout: const Duration(seconds: 120));
  }
}
