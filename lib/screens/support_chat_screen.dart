

import 'package:flutter/material.dart';

import '../constant.dart';
import 'package:flutter/material.dart';
import 'package:onroad/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import '../manager/notification_manager.dart';
import '../widget/message.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'dart:io';


import 'package:pinput/pinput.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({Key? key,required this.isProvider,required this.CId,required this.PId}) : super(key: key);
  final bool isProvider;
  final String CId;
  final String PId;
  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final TextEditingController _textEditingController1 = TextEditingController();
  bool? send = true ;
  List<Message> messages = [];
  List<XFile>? images = <XFile>[];
  XFile? image;
  bool? sheet=false;
  Future<void> pickImageFromGallary()async{
    final ImagePicker picker = ImagePicker();
    images = await picker.pickMultiImage(/*source: ImageSource.gallery*/);
    if(images != null) {
      setState(() {
        sheet = true;
      });
    }


    print("------------------------------------");
    print(image!);
  }
  Future<void> pickImageFromCamer()async{
    final ImagePicker _picker = ImagePicker();
    // Pick an image

    image = (await _picker.pickImage(source: ImageSource.camera));
    images = [image!];
    if(images!.isNotEmpty) {
      setState(() {
        sheet = true;
      });
    }else{print("lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll");}
  }

  Future<void> sendMassageP() async {

    Timestamp time = Timestamp.now();
    late String url ;
    await FirebaseFirestore.instance
        .collection('DashBoardChats')
        .doc("p"+widget.PId.toString()).update({'time':time});

    if(images!.isNotEmpty){
      setState((){ send=false;});
      if(images!.length==1){
    /*    final ref=  FirebaseStorage.instance.ref().child('images').child(images![0].name);
        await ref.putFile(File(images![0].path));
        url = await ref.getDownloadURL();*/
        await FirebaseFirestore.instance
            .collection('DashBoardChats')
            .doc("p"+widget.PId.toString())
            .collection("p"+widget.PId.toString())
            .doc()
            .set({
          'provider': 'p',
          'support': 'null',
          'time': Timestamp.now(),
          'image_url':'url',

        });
        if(_textEditingController1.text.isNotEmpty) {

          await FirebaseFirestore.instance
              .collection('DashBoardChats')
              .doc("p"+widget.PId.toString())
              .collection("p"+widget.PId.toString())
              .doc()
              .set({
            'provider': 'null',
            'support':
            _textEditingController1.text.toString(),
            'time': Timestamp.now(),
            'image_url': 'null',

          });
          NotificationManager.sendNotification(
              "support",
              "New Message",
              _textEditingController1.text.toString(),
              false,
              true
          );
        }


      }else{
        print("----------------------------------------------------------------------------------1");
        print(images!.length);
        for(int i = 0 ; i<images!.length;i++){
          print("---------------------------------------------------------------------------------2");

         /* final ref=  FirebaseStorage.instance.ref().child('images').child(images![i].name);
          await ref.putFile(File(images![i].path));
          url = await ref.getDownloadURL();*/
          await FirebaseFirestore.instance
              .collection('DashBoardChats')
              .doc("p"+widget.PId.toString())
              .collection("p"+widget.PId.toString())
              .doc()
              .set({
            'provider':
            'p',
            'support':'null',
            'time': Timestamp.now(),
            'image_url':'url',

          });
        }
        if(_textEditingController1.text.isNotEmpty){

          await FirebaseFirestore.instance
              .collection('DashBoardChats')
              .doc("p"+widget.PId.toString())
              .collection("p"+widget.PId.toString())
              .doc()
              .set({
            'provider':_textEditingController1.text.toString(),
            'support':'null',
            'time': Timestamp.now(),
            'image_url':'null',

          });
          NotificationManager.sendNotification(
              "support",
              "New Message",
              _textEditingController1.text.toString(),
              false,
              true
          );
        }


      }
    }else {
      if (_textEditingController1.text.isNotEmpty) {

        await FirebaseFirestore.instance
            .collection('DashBoardChats')
            .doc("p"+widget.PId.toString())
            .collection("p"+widget.PId.toString())
            .doc()
            .set({
          'support':
          'null',
          'provider': _textEditingController1.text.toString(),
          'image_url': 'null',
          'time': Timestamp.now()
        });
        NotificationManager.sendNotification(
            "support",
            "New Message",
            _textEditingController1.text.toString(),
            false,
            true
        );
      }
    }

    images!.clear();
    setState((){image=null; send=true;});
    print("-------------------------------------------------");
  }
  Future<void> sendMassageC() async {

    Timestamp time = Timestamp.now();
    late String url ;
    await FirebaseFirestore.instance
        .collection('DashBoardChats')
        .doc("c"+widget.CId.toString()).update({'time':time});
    if(images!.isNotEmpty){
      setState((){ send=false;});
      if(images!.length==1){
/*        final ref=  FirebaseStorage.instance.ref().child('images').child(images![0].name);
        await ref.putFile(File(images![0].path));
        url = await ref.getDownloadURL();*/
        await FirebaseFirestore.instance
            .collection('DashBoardChats')
            .doc("c"+widget.CId.toString())
            .collection("c"+widget.CId.toString())
            .doc()
            .set({
          'customer':
          'c',
          'support': 'null',
          'time': Timestamp.now(),
          'image_url':'url',

        });
        if(_textEditingController1.text.isNotEmpty) {

          await FirebaseFirestore.instance
              .collection('DashBoardChats')
              .doc("c"+widget.CId.toString())
              .collection("c"+widget.CId.toString())
              .doc()
              .set({
            'customer': _textEditingController1.text.toString(),
            'support':
            'null',
            'time': Timestamp.now(),
            'image_url': 'null',

          });
          NotificationManager.sendNotification(
              "support",
              "New Message",
              _textEditingController1.text.toString(),
              false,
              true
          );
        }


      }else{
        print("----------------------------------------------------------------------------------1");
        print(images!.length);
        for(int i = 0 ; i<images!.length;i++){
          print("---------------------------------------------------------------------------------2");

    /*      final ref=  FirebaseStorage.instance.ref().child('images').child(images![i].name);
          await ref.putFile(File(images![i].path));
          url = await ref.getDownloadURL();*/
          await FirebaseFirestore.instance
              .collection('DashBoardChats')
              .doc("c"+widget.CId.toString())
              .collection("c"+widget.CId.toString())
              .doc()
              .set({
            'customer':
           'c',
            'support': 'null',
            'time': Timestamp.now(),
            'image_url':'url',

          });
        }
        if(_textEditingController1.text.isNotEmpty){

          await FirebaseFirestore.instance
              .collection('DashBoardChats')
              .doc("c"+widget.CId.toString())
              .collection("c"+widget.CId.toString())
              .doc()
              .set({
            'customer': _textEditingController1.text.toString(),
            'support':
            'null',
            'time': Timestamp.now(),
            'image_url':'null',

          });
          NotificationManager.sendNotification(
              "support",
              "New Message",
              _textEditingController1.text.toString(),
              false,
              true
          );
        }


      }
    }else {
      if (_textEditingController1.text.isNotEmpty) {

        await FirebaseFirestore.instance
            .collection('DashBoardChats')
            .doc("c"+widget.CId.toString())
            .collection("c"+widget.CId.toString())
            .doc()
            .set({
          'customer': _textEditingController1.text.toString(),
          'support':
          'null',
          'image_url': 'null',
          'time': Timestamp.now()
        });
        NotificationManager.sendNotification(
            "support",
            "New Message",
            _textEditingController1.text.toString(),
            false,
            true
        );
      }
    }

    images!.clear();
    setState((){image=null; send=true;});
    print("-------------------------------------------------");
  }

  Future<void> getMassagesP(List<QueryDocumentSnapshot> allMessages ) async{

    List<QueryDocumentSnapshot<Map<String, dynamic>>>  allMassages2 =[] ;
    List<Timestamp>? allTime =[];

    for(int i = 0 ; i< allMessages.length;i++){
      print(allMessages[i]['time']);
      allTime.add(allMessages[i]['time']);
    }
    allTime.sort((a,b){
      return  b.compareTo(a);
    });
    messages.clear();
    for(int j = 0 ; j< allTime.length;j++){
      for(int i = 0 ; i< allMessages.length;i++){
        Timestamp time = allMessages[i]['time'];
        if(time.toDate().day==allTime[j].toDate().day &&
            time.toDate().hour==allTime[j].toDate().hour &&
            time.toDate().minute==allTime[j].toDate().minute &&
            time.toDate().second==allTime[j].toDate().second&&
            time.toDate().microsecond==allTime[j].toDate().microsecond&&
            time.toDate().microsecond==allTime[j].toDate().microsecond){
          // allMassages2.add(allMessages[i]);
          if(allMessages[i]['support']=='null'&&allMessages[i]['provider']=='p'&&allMessages[i]['image_url']!='null'){
            messages.add(
                Message(
                  message: allMessages[i]['image_url'],
                  image: true,
                  messageSender: "p",
                  isProvider: widget.isProvider,
                  messageTime: allMessages[i]['time'],
                  type: 'p',

                ));
          }else if(allMessages[i]['support']=='s'&&allMessages[i]['provider']=='null'&&allMessages[i]['image_url']!='null'){
            messages.add(
                Message(
                  message: allMessages[i]['image_url'],
                  image: true,
                  messageSender: "s",
                  isProvider: widget.isProvider,
                  messageTime: allMessages[i]['time'],
                  type: 's',

                ));
          }else if(allMessages[i]['provider']!='null'){

            messages.add(Message(
              message: allMessages[i]['provider'],
              messageSender: 'p',
              isProvider: widget.isProvider,
              messageTime: allMessages[i]['time'],
              image: false,
              type: 'p',

            ));
          }else if(allMessages[i]['support']!='null'){
            messages.add(Message(
              message: allMessages[i]['support'],
              messageSender: 's',
              isProvider: widget.isProvider,
              messageTime: allMessages[i]['time'],
              image: false,
              type: 's',

            ));
          }
          break;

        }
      }
    }
    // setState((){});

  }
  Future<void> getMassagesC(List<QueryDocumentSnapshot> allMessages ) async{

    List<QueryDocumentSnapshot<Map<String, dynamic>>>  allMassages2 =[] ;
    List<Timestamp>? allTime =[];

    for(int i = 0 ; i< allMessages.length;i++){
      print(allMessages[i]['time']);
      allTime.add(allMessages[i]['time']);
    }
    allTime.sort((a,b){
      return  b.compareTo(a);
    });
    messages.clear();
    for(int j = 0 ; j< allTime.length;j++){
      for(int i = 0 ; i< allMessages.length;i++){
        Timestamp time = allMessages[i]['time'];
        if(time.toDate().day==allTime[j].toDate().day &&
            time.toDate().hour==allTime[j].toDate().hour &&
            time.toDate().minute==allTime[j].toDate().minute &&
            time.toDate().second==allTime[j].toDate().second&&
            time.toDate().microsecond==allTime[j].toDate().microsecond&&
            time.toDate().microsecond==allTime[j].toDate().microsecond){
          // allMassages2.add(allMessages[i]);
          if(allMessages[i]['customer']=='null'&&allMessages[i]['support']=='s'&&allMessages[i]['image_url']!='null'){
            messages.add(
                Message(
                  message: allMessages[i]['image_url'],
                  image: true,
                  messageSender: "s",
                  isProvider: widget.isProvider,
                  messageTime: allMessages[i]['time'],
                  type: 's',

                ));
          }else if(allMessages[i]['customer']=='c'&&allMessages[i]['support']=='null'&&allMessages[i]['image_url']!='null'){
            messages.add(
                Message(
                  message: allMessages[i]['image_url'],
                  image: true,
                  messageSender: "c",
                  isProvider: widget.isProvider,
                  messageTime: allMessages[i]['time'],
                  type: 'c',

                ));
          }else if(allMessages[i]['support']!='null'){

            messages.add(Message(
              message: allMessages[i]['support'],
              messageSender: 's',
              isProvider: widget.isProvider,
              messageTime: allMessages[i]['time'],
              image: false,
              type: 's',

            ));
          }else if(allMessages[i]['customer']!='null'){
            messages.add(Message(
              message: allMessages[i]['customer'],
              messageSender: 'c',
              isProvider: widget.isProvider,
              messageTime: allMessages[i]['time'],
              image: false,
              type: 'c',

            ));
          }
          break;

        }
      }
    }
    // setState((){});
/*    print("----------------------------------------");
    print(allMassages2.length);
    for(int i = 0 ; i< allMassages2.length;i++){

      print("sender : "+allMassages2[i].data()['senber_uid']);
      print("massage : "+allMassages2[i].data()['massage']);

    }*/

    // print(senderMassages.docs[0].data()['massage']);
    // print(reciverMassages.docs[0].data()['massage']);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Image.asset(
          'assets/images/logo app.png',
          width: 75,
          height: 75,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StreamBuilder(
              stream:widget.isProvider?
              FirebaseFirestore.instance.collection('DashBoardChats').doc("p"+widget.PId.toString())
                  .collection("p"+widget.PId.toString()).snapshots()
                  :FirebaseFirestore.instance.collection('DashBoardChats').doc("c"+widget.CId.toString())
                  .collection("c"+widget.CId.toString()).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                print(snapshot.data!);
                if(widget.isProvider) {
                  getMassagesP(snapshot.data!.docs);
                }else{
                  getMassagesC(snapshot.data!.docs);

                }
                return Expanded(
                  child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return messages[index];
                    },
                  ),
                );
              },),
            send!?const SizedBox(width: 0,height: 0,):
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:  [
                Padding(
                  padding: const EdgeInsets.only(right: 16,bottom: 8,top: 8,left: 16),
                  child: Container(
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius:
                          const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                          ),

                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(-4,-4),
                                color: Colors.white.withOpacity(0.11),
                                blurRadius: 6
                            ),
                            BoxShadow(
                                offset: const Offset(4,4),
                                color: Colors.black.withOpacity(0.7),
                                blurRadius: 6
                            ),
                          ]
                      ),

                      padding: const EdgeInsets.all(8),
                      child:const CircularProgressIndicator(color: Colors.white,semanticsLabel: "sending...",)

                  ),
                ),
              ],
            ),
            sheet!?
            Material(
              color: Colors.grey.shade200,
              elevation: 0,
              child: SizedBox(
                height: 250,
                child: ListView.builder(
                    itemCount: images!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Material(
                              elevation: 4,
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Image.file(File(images![index].path)),
                              ),
                            ),
                          ),
                          Positioned(
                            top:0,
                            right:0,
                            child: IconButton(
                                onPressed: (){
                                  setState((){
                                    images!.removeAt(index);
                                    if(images!.isEmpty){
                                      sheet = false;
                                    }
                                  });
                                },
                                icon: const Icon(Icons.clear,color: kPrimaryColor2,)
                            ),
                          ),
                        ],
                      ) ;
                    }),
              ),
            )
                :const SizedBox(width: 0,height: 0,),
            Row(
              children: [
                SpeedDial(
                  backgroundColor: Colors.white,
                  overlayOpacity: 0.1,
                  elevation: 0,
                  // spacing: 6,
                  spaceBetweenChildren: 6,
                  children: [
                    SpeedDialChild(
                      // label: "gallery",
                        onTap: (){
                          pickImageFromGallary();

                        },
                        child:const Icon(
                          Icons.image,
                          color: kPrimaryColor,
                        )
                    ),
                    SpeedDialChild(
                      // label: "camera",
                        onTap: (){
                          pickImageFromCamer();
                          print("------------------------------------");

                        },
                        child:const Icon(
                          Icons.camera_alt,
                          color: kPrimaryColor,
                        )
                    ),

                  ],
                  child: Icon(
                    Icons.attach_file,
                    color: kPrimaryColor,
                  ),
                ),

                SizedBox(
                  width: 10,
                ),
                Container(
                  width: size.width * 0.73,
                  height: 50,
                  color: Colors.white,
                  child: Row(
                    children: [
                      SizedBox(width: size.width * 0.6,
                          child: TextFormField(
                            controller: _textEditingController1,
                          )),
                      IconButton(
                        onPressed: () async{
                          setState((){sheet=false;});

                          if(widget.isProvider) {
                            await sendMassageP();
                          }else{
                            await sendMassageC();

                          }
                          //  _textEditingController1.setText('');
                          _textEditingController1.setText('');
                        },
                        icon: Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
