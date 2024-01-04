



import 'package:flutter/material.dart';

import '../constant.dart';

class CircleCheckBox extends StatefulWidget {
   CircleCheckBox({Key? key,required this.value,required this.onTap,}) : super(key: key);
  bool value;
  VoidCallback  onTap ;

  @override
  State<CircleCheckBox> createState() => _CircleCheckBoxState();
}

class _CircleCheckBoxState extends State<CircleCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap:widget.onTap,
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey,width: 2),
            borderRadius: BorderRadius.all(Radius.circular(25)),
            // color: kPrimaryColor
          ),
          child:widget.value?
          Padding(
            padding: const EdgeInsets.all(2.5),
            child: Container(
              width: 10,height: 10,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                // color: kPrimaryColor
              ),
            ),
          ): null,
        ),
      ),
    );
  }
}
