import 'package:flutter/material.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onroad/widget/person.dart';

import '../../manager/cash_manager.dart';
import '../support_chat_screen.dart';

class ProviderChatScreen extends StatefulWidget {
  const ProviderChatScreen({Key? key}) : super(key: key);

  @override
  State<ProviderChatScreen> createState() => _ProviderChatScreenState();
}

class _ProviderChatScreenState extends State<ProviderChatScreen> {
  List<Person> persons = [];
  QuerySnapshot<Map<String, dynamic>>? allPersons ;
  Future<void> getPersons( ) async{

/*
    List<Timestamp>? allTime =[];

    for(int i = 0 ; i< allPersons.length;i++){
      print(allPersons[i]['time']);
      allTime.add(allPersons[i]['time']);
    }
    allTime.sort((a,b){
      return  b.compareTo(a);
    });*/
     allPersons = await FirebaseFirestore.instance.collection('Chats').where('provider_id',isEqualTo: CacheManager.getInstance()!.getUserData().userId.toString()).get();
    persons.clear();
      for(int i = 0 ; i< allPersons!.size;i++){
          // allMassages2.add(allMessages[i]);
        DocumentSnapshot<Map<String, dynamic>> order = await FirebaseFirestore.instance.collection('Orders').doc(allPersons!.docs[i].id.toString()).get();
      print(allPersons!.docs[i].id.toString());
      print(order.get('order_state'));
      print('----------');
      if(order.get('order_state') == 'accepted') {
        persons.add(Person(
          customerName: allPersons!.docs[i]['c_name'],
          time: allPersons!.docs[i]['time'],
          type: 'c',
        ));
      }
    }
      setState(() {

      });

  }

  @override
  void initState() {
    getPersons();

    // TODO: implement initState
    super.initState();
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
                  return SupportChatScreen(isProvider: true,PId:id, CId: '',);
                }));
              },
              child: Person(customerName: 'Support', time:Timestamp.now() ,type: 's',)),

          persons.isNotEmpty?Expanded(
            child: ListView.builder(
              itemCount: persons.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return ChatScreen(isProvider: true,orderId: allPersons!.docs[index].id.toString(),CId: allPersons!.docs[index]['customer_id'].toString(),PId: allPersons!.docs[index]['provider_id'].toString(),);
                    }));
                  },
                  child: persons[index],

                );
              },
            ),
          ):SizedBox(
            height: 500,
         /*   child: Center(
              child: Text('No Chats Now ...',
                style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
            ),*/
          )
        ],
      ),
    );
  }
}
