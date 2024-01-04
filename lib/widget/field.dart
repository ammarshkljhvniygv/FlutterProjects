import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';

import '../constant.dart';

class Field extends StatefulWidget {
  Field({
    Key? key,
    required this.text,
    required this.validatText,
    required this.readOnly,
    this.suffixIcon,
    required this.maxWidth,
    this.controller,
    this.onTap,
    this.keyboardType,
    this.maxLength,
    required this.obscureText,
  }) : super(key: key);
  String text;
  String validatText;
  bool readOnly;
  VoidCallback? onTap;
  dynamic controller;
  TextInputType? keyboardType;
  int? maxLength;
  Widget? suffixIcon;
  double maxWidth;
  bool obscureText;
  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return Directionality(
      textDirection: languageCubit.language == 'AR'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: TextFormField(
        obscureText: widget.obscureText,
        cursorHeight: 27,
        cursorColor: kPrimaryColor,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        validator: (text) {
          if (text == null || text == "") {
            return widget.validatText;
          }
          return null;
        },
        textAlign:languageCubit.language == 'AR'
            ? TextAlign.right
            : TextAlign.left, 
        style: GoogleFonts.cairo(
          height: 0.9,
          // fontSize: 16,
          // fontWeight: FontWeight.w300,
          // color: Color.fromARGB(255, 191, 191, 191),
        ),
        decoration: InputDecoration(
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(width: 1, color: kPrimaryColor),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(width: 1, color: kPrimaryColor),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(width: 1, color: kPrimaryColor),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(width: 1, color: kPrimaryColor),
            ),
            suffixIcon: widget.suffixIcon!,
            label: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12, right: 12),
              child: Text(widget.text,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 191, 191, 191),
                  )),
            )

            /* labelText: widget.text,
            labelStyle: GoogleFonts.cairo(
              fontSize: 14,
              // fontWeight: FontWeight.w300,
              color: Color.fromARGB(255, 191, 191, 191),

            )*/

            /* suffixIcon: Padding(
              padding: const EdgeInsets.only(top:12.0,bottom:12,right: 12),
              child: Text(widget.text,
                style:  GoogleFonts.cairo(
                  fontSize: 14,
                  // fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 191, 191, 191),

                )
              ),
            )*/
            ),
      ),
    );
  }
}
