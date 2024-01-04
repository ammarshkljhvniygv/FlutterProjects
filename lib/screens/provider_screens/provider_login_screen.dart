import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/screens/lang_screen.dart';
import 'package:onroad/screens/provider_screens/provider_registration_screen.dart';
import 'package:onroad/widget/mydirection.dart';

import '../../constant.dart';
import '../../widget/field.dart';

class ProviderLoginScreen extends StatefulWidget {
  const ProviderLoginScreen({Key? key}) : super(key: key);

  @override
  State<ProviderLoginScreen> createState() => _ProviderLoginScreenState();
}

class _ProviderLoginScreenState extends State<ProviderLoginScreen> {
  String? countryNumber;
  List<dynamic>? filterModels;
  List<dynamic>? models;
  bool filter = false;
  bool openFilter = false;
  bool model = false;
  bool done = true;
  bool? obscureText = false;
  final TextEditingController _textEditingController2 = TextEditingController();
  final TextEditingController _textEditingController5 = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  late Animation<double> _fadeAnimation;
  late AnimationController _animationController;
  String? makeId;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return MyDirectionality(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return ChooseScreen();
                  }));
                },
                icon: Icon(Icons.arrow_back_rounded),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: key,
                child: Directionality(
                  textDirection: languageCubit.language == 'AR'
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Image.asset(
                        'assets/images/logo_with_logen.png',
                        width: 350,
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
                              Image.asset(
                                'assets/images/Group 42.png',
                                width: size.width * 0.25,
                                color: Colors.grey.withOpacity(0.35),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              children: [
                                Text(
                                  languageCubit.LDiscover!,
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.cairo(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: kPrimaryColor2,
                                  ),
                                ),
                                Text(
                                  languageCubit.wwhtoday!,
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.cairo(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
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
                              Image.asset(
                                'assets/images/Group 43.png',
                                width: size.width * 0.25,
                                color: Colors.grey.withOpacity(0.35),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 30, left: 30),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.05,
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
                              height: size.height * 0.03,
                            ),
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
                              height: size.height * 0.06,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    if (!key.currentState!.validate()) {
                                      // return;

                                    } else {
                                      setState(() {
                                        done = false;
                                      });
                                      LoginCubit loginCubit =
                                          LoginCubit.instance(context);
                                      String? result =
                                          await loginCubit.loginProvider(
                                              _textEditingController5.text,
                                              _textEditingController2.text);
                                      setState(() {
                                        done = true;
                                      });
                                      print(result);
                                      if (result != null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: Colors.red,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                padding: EdgeInsets.all(10),
                                                content: Text(
                                                  languageCubit.language == 'EN'
                                                      ? result
                                                      : result ==
                                                              'wrong password'
                                                          ? 'كلمة المرور غير صحيحة'
                                                          :result ==
                                                      "username doesn't exist"?
                                                  'اسم المستخدم غير موجود'
                                                  :'الحساب غير مفعل',
                                                  textAlign: TextAlign.center,
                                                )));
                                      }
                                      /* Navigator.pop(context);
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ProviderScreen();
                                  }));*/
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
                                      child: Text(languageCubit.login!,
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
                                      return ProviderRegistrationScreen();
                                    }));
                                  },
                                  child: Text(languageCubit.Createanaccount!,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.cairo(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: kPrimaryColor2,
                                      )),
                                ),
                                Text(languageCubit.DHaveaccount!,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.cairo(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: kPrimaryColor,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                          ],
                        ),
                      )
                    ],
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
                  color: Colors.grey.withOpacity(0.2),
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
