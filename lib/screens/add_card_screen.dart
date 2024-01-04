import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/widget/mydirection.dart';

class AddCardScreen extends StatefulWidget {
  AddCardScreen({Key? key, required this.onTap}) : super(key: key);
  VoidCallback onTap;
  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return MyDirectionality(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.withOpacity(0.3),
        body: Center(
          child: SizedBox(
              width: size.width * 0.85,
              height: 500,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(languageCubit.addCardT1!,
                          textAlign: TextAlign.end,
                          style: GoogleFonts.cairo(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          )),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(languageCubit.addCardT2!,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.cairo(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              )),
                        ],
                      ),
                      Directionality(
                        textDirection: languageCubit.language == 'AR'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: TextFormField(
                          textAlign: languageCubit.language == 'AR'
                              ? TextAlign.right
                              : TextAlign.left,
                          decoration: InputDecoration(
                              disabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(const Radius.circular(20)),
                                borderSide: const BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(const Radius.circular(20)),
                                borderSide: const BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              hintText: '1234 7843 1237 1279',
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.25)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(languageCubit.addCardT3!,
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.cairo(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      )),
                                ],
                              ),
                              SizedBox(
                                width: size.width * 0.25,
                                height: 50,
                                child: Directionality(
                                  textDirection: languageCubit.language == 'AR'
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  child: TextFormField(
                                    textAlign: languageCubit.language == 'AR'
                                        ? TextAlign.right
                                        : TextAlign.left,
                                    decoration: InputDecoration(
                                        disabledBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              const Radius.circular(20)),
                                          borderSide: const BorderSide(
                                              width: 0,
                                              color: Colors.transparent),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              const Radius.circular(20)),
                                          borderSide: const BorderSide(
                                              width: 0,
                                              color: Colors.transparent),
                                        ),
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.transparent),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.transparent),
                                        ),
                                        hintText: '***',
                                        filled: true,
                                        fillColor:
                                            Colors.grey.withOpacity(0.25)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(languageCubit.addCardT4!,
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.cairo(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      )),
                                ],
                              ),
                              SizedBox(
                                width: size.width * 0.25,
                                height: 50,
                                child: Directionality(
                                  textDirection: languageCubit.language == 'AR'
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  child: TextFormField(
                                    textAlign: languageCubit.language == 'AR'
                                        ? TextAlign.right
                                        : TextAlign.left,
                                    decoration: InputDecoration(
                                        disabledBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              const Radius.circular(20)),
                                          borderSide: const BorderSide(
                                              width: 0,
                                              color: Colors.transparent),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              const Radius.circular(20)),
                                          borderSide: const BorderSide(
                                              width: 0,
                                              color: Colors.transparent),
                                        ),
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.transparent),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.transparent),
                                        ),
                                        hintText: '10/24',
                                        filled: true,
                                        fillColor:
                                            Colors.grey.withOpacity(0.25)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(languageCubit.addCardT5!,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.cairo(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              )),
                        ],
                      ),
                      Directionality(
                        textDirection: languageCubit.language == 'AR'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: TextFormField(
                          textAlign: languageCubit.language == 'AR'
                              ? TextAlign.right
                              : TextAlign.left,
                          decoration: InputDecoration(
                              disabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(const Radius.circular(20)),
                                borderSide: const BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(const Radius.circular(20)),
                                borderSide: const BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              hintText: 'Ahmed Mohamed Mohsen',
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.25)),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Container(
                          width: size.width * 0.4,
                          height: 45,
                          decoration: const BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Text(languageCubit.addCardT6!,
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
                ),
              )),
        ),
      ),
    );
  }
}
