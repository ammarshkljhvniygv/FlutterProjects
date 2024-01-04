



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Person extends StatefulWidget {
  const Person({Key? key,required this.customerName,required this.time,required this.type}) : super(key: key);
final String customerName;
final Timestamp time;
final String type;
  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            widget.type == 'p'?
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(40),

              child: Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 11.0),
                    child: Center(child: Image.asset('assets/images/icons8-mechanic-48.png')),
                  )),
            ):widget.type == 'c'?
            Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(40),

                child: Container(
                    padding: EdgeInsets.all(10),
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Image.asset('assets/images/icons8-customer-64.png',width: 40,))):
            Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(40),

                child: Container(
                    padding: EdgeInsets.all(10),
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Center(child: Text('S',style: TextStyle(fontSize: 25,color: Colors.indigo,fontWeight: FontWeight.bold),)))),
            SizedBox(
              width: 20,
            ),
            Material(
              // elevation: 4,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              child: Container(
                width: size.width * 0.65,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(widget.customerName,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                            fontSize: 14,
                            color: Colors.black,
                          )),
                      Spacer(),
                     Text(widget.time.toDate().hour.toString()+":"+widget.time.toDate().minute.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
