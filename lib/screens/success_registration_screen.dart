import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';

class SuccessRegistrationScreen extends StatelessWidget {
  const SuccessRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Stack(
              children: [
                Center(
                    child:
                        Image.asset('assets/images/ic_new_releases_24px.png')),
                Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: Image.asset('assets/images/ic_check_-12.png')),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /*  Image.asset(
                  'assets/images/Group 42.png',
                  width: size.width * 0.1,
                  color: Colors.grey.withOpacity(0.35),
                ),*/
                Column(
                  children: [
                    Text(
                      languageCubit.rsuccessfully!,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                /*  Image.asset(
                  'assets/images/Group 43.png',
                  width: size.width * 0.1,
                  color: Colors.grey.withOpacity(0.35),
                ),*/
              ],
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            Text(
              languageCubit.trs1!,
              textAlign: TextAlign.end,
              style: GoogleFonts.cairo(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: kPrimaryColor,
              ),
            ),
            Text(
              languageCubit.trs2!,
              textAlign: TextAlign.end,
              style: GoogleFonts.cairo(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    SystemNavigator.pop();
                  },
                  child: Container(
                    width: size.width * 0.4,
                    height: 45,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(7)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.0),
                      child: Text(languageCubit.trclose!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
