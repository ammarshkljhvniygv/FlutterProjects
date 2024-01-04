import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/models/order.dart';
import 'package:onroad/screens/map_screen.dart';

import '../constant.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderItem extends StatelessWidget {
  OrderItem(
      {Key? key,
      this.order,
      required this.text,
       this.text2='',
      required this.icon,
      this.phone = false,
      required this.openMap})
      : super(key: key);
  String text;
  String text2;
  Widget icon;
  bool openMap;
  bool phone;
  Order? order;
  Future<void> launchingMobilePhone(String number) async {
    print('====$number');
    String url = "tel:$number";
    await launchUrlString(url);
  }
  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, right: 10, left: 10, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          openMap
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MapScreen(
                        order: order!,
                      );
                    }));
                  },
                  child: Container(
                    width: 110,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: kPrimaryColor2),
                    child: Center(
                      child: Text(
                        languageCubit.openMap!,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          Spacer(),
          !phone?Text(
            text,
            textAlign: TextAlign.end,
            textDirection: languageCubit.language == 'EN'
                ? TextDirection.ltr
                : TextDirection.rtl,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ):
          Row(
            children: [
              TextButton(
                onPressed: ()async{
                 await launchingMobilePhone(text2);
                }, child: Text(
                text2,
                textAlign: TextAlign.end,
                /*textDirection: languageCubit.language == 'EN'
                    ? TextDirection.rtl
                    : TextDirection.rtl,*/
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),),
              Text(
                text,
                textAlign: TextAlign.end,
                textDirection: languageCubit.language == 'EN'
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

            ],
          ),
          SizedBox(
            width: 15,
          ),
          Material(
            elevation: 3,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.white,
                ),
                child: icon),
          )
        ],
      ),
    );
  }
}
