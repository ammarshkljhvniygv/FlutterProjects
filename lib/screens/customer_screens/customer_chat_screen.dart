import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/screens/chat_screen.dart';

import '../../manager/cash_manager.dart';
import '../../widget/person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../support_chat_screen.dart';

class CustomerChatScreen extends StatefulWidget {
  const CustomerChatScreen({Key? key}) : super(key: key);

  @override
  State<CustomerChatScreen> createState() => _CustomerChatScreenState();
}

class _CustomerChatScreenState extends State<CustomerChatScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
    // tabController = TabController(length: taps.length, vsync: this);
    super.initState();
  }

  List<Person> persons = [];
  Future<void> getPersons(List<QueryDocumentSnapshot> allPersons ) async{

/*
    List<Timestamp>? allTime =[];

    for(int i = 0 ; i< allPersons.length;i++){
      print(allPersons[i]['time']);
      allTime.add(allPersons[i]['time']);
    }
    allTime.sort((a,b){
      return  b.compareTo(a);
    });*/
    persons.clear();
    for(int i = 0 ; i< allPersons.length;i++){
      // allMassages2.add(allMessages[i]);
      persons.add(Person(customerName: allPersons[i]['p_name'],time:allPersons[i]['time'] ,type: 'p',));
    }


  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: ()async{
              String id = await CacheManager.getInstance()!.getUserData().userId.toString();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SupportChatScreen(isProvider: false,PId:'', CId: id);
              }));
            },
              child: Person(customerName: 'Support', time:Timestamp.now() ,type: 's',)),
/*
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Chats').where('customer_id',isEqualTo: CacheManager.getInstance()!.getUserData().userId.toString()).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              print(snapshot.data!.docs);
              getPersons(snapshot.data!.docs);
              return Expanded(
                child: ListView.builder(
                  itemCount: persons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ChatScreen(isProvider: false,orderId: snapshot.data!.docs[index].id.toString(),CId: snapshot.data!.docs[index]['customer_id'].toString(),PId: snapshot.data!.docs[index]['provider_id'].toString(),);
                        }));
                      },
                      child: persons[index],

                    );
                  },
                ),
              );
            },
          ),
*/
        ],
      ),
    );
  }
}
