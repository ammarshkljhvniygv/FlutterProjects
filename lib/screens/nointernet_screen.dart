

import 'package:flutter/material.dart';
import 'package:onroad/constant.dart';

import '../main.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo app.png',
          width: 75,
          height: 75,
        ),
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/nointernet.png',

          ),
          Text('No Internet Connection ',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(

                onPressed: (){
            //  RestartWidget.restartApp(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return MyApp();}));
            },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Reload',style: TextStyle(fontSize: 20,),),
              ),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kPrimaryColor)) ,
            ),
          )
        ],
      ),
    );
  }
}
