




import '../widget/message.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message extends StatefulWidget {
  const Message({Key? key,required this.message,required this.type,required this.image,required this.messageTime,required this.messageSender,required this.isProvider}) : super(key: key);
final String message ;
final String messageSender ;
final bool isProvider ;
final bool image ;
final Timestamp messageTime ;
  final String type;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {

    return widget.image?
    Directionality(
      textDirection: (widget.messageSender=='p'&&widget.isProvider)||(widget.messageSender=='c'&& !widget.isProvider)?TextDirection.rtl:TextDirection.ltr,
      child: Column(
        children: [
          Row(
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
                  padding: EdgeInsets.all(10),
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(25))),
                  child: Center(
                      child: Image.network(widget.message)),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(widget.messageTime.toDate().hour.toString()+":"+widget.messageTime.toDate().minute.toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    )),
              ),
            ],
          ),
        ],
      ),
    ):
    Directionality(
      textDirection: (widget.messageSender=='p'&&widget.isProvider)||(widget.messageSender=='c'&& !widget.isProvider)?TextDirection.rtl:TextDirection.ltr,
      child: Column(
        children: [
          Row(
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
                  padding: EdgeInsets.all(10),
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(25))),
                  child: Center(
                      child: Text(widget.message,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                            fontSize: 14,
                            color: Colors.black,
                          ))),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(widget.messageTime.toDate().hour.toString()+":"+widget.messageTime.toDate().minute.toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
