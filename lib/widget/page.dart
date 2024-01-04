import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/screens/lang_screen.dart';

class BuildPage extends StatelessWidget {
  BuildPage({
    Key? key,
    required this.size,
    required this.img,
    required this.text1,
    required this.text2,
    required this.skip,
  }) : super(key: key);

  Size size;
  String img, text1, text2;
  bool skip;

  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 50, left: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return ChooseScreen();
                      }));
                    },
                    child: skip
                        ? Container(
                            /* decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                            ),*/
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                languageCubit.skip!,
                                style: GoogleFonts.cairo(fontSize: 18),
                              ),
                            ),
                          )
                        : Container() /*Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'استمر',
                                style: GoogleFonts.cairo(fontSize: 18),
                              ),
                            ),
                          )*/
                    )
              ],
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Image.asset(
              img,
              // width: double.infinity,
              //   height:MediaQuery.of(context).size.height*0.3,
              // fit: BoxFit.fill,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              text1,
              style:
                  GoogleFonts.cairo(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              text2,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 18,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
