import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/manager/background_container.dart';
import 'package:onroad/widget/mydirection.dart';

class CustomerThanksScreen extends StatefulWidget {
  const CustomerThanksScreen({Key? key}) : super(key: key);

  @override
  State<CustomerThanksScreen> createState() => _CustomerThanksScreenState();
}

class _CustomerThanksScreenState extends State<CustomerThanksScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    LoginCubit loginCubit = LoginCubit.instance(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MyDirectionality(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            title: Image.asset(
              'assets/images/logo app.png',
              width: 75,
              height: 75,
            ),
            centerTitle: true,
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
                    )),
              ),
              Center(
                  child: Material(
                elevation: 6,
                borderRadius: const BorderRadius.all(const Radius.circular(10)),
                child: Container(
                    height: 472,
                    width: size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
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
                            height: size.height * 0.05,
                          ),
                          Image.asset(
                            'assets/images/Group 167.png',
                            width: 154,
                            height: 154,
                          ),
                          SizedBox(
                            height: size.height * 0.06,
                          ),
                          Text(
                            '${languageCubit.thanks}  ',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: Text(
                              languageCubit.thanksT1!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigator.pop(context);
                                  SystemNavigator.pop();
                                },
                                child: Container(
                                  width: size.width * 0.4,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(7)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 0.0),
                                    child: Center(
                                      child: Text(languageCubit.thanksT2!,
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
                        ],
                      ),
                    )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
