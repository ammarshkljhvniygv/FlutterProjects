import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  ProfileItem({
    Key? key,
    required this.text,
    required this.val,
    required this.dropdown,
    this.icon,
  }) : super(key: key);
  String text;
  String val;
  Widget? icon;
  bool dropdown;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              icon!,
              const Spacer(),
              Text(text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  )),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              Text(val,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.withOpacity(0.5),
          )
        ],
      ),
    );
  }
}
