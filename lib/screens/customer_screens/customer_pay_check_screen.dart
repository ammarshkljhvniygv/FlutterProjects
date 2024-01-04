

import 'package:flutter/material.dart';

import '../../StateManagement/blocs/language_cubit.dart';
import '../../constant.dart';
import '../../manager/background_container.dart';

class CustomerPayCheckScreen extends StatefulWidget {
  const CustomerPayCheckScreen({Key? key}) : super(key: key);

  @override
  State<CustomerPayCheckScreen> createState() => _CustomerPayCheckScreenState();
}

class _CustomerPayCheckScreenState extends State<CustomerPayCheckScreen> {

  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Image.asset('assets/images/logo app.png',
            width: 75,
            height: 75,),
        ),
        body: Stack(
          children: [
            RotatedBox(
              quarterTurns: 2,
              child: ClipPath(
                  clipper: BackgroundClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 320,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter,
                            colors: [kAppBar, kPrimaryColor])),
                  )),
            ),
            Center(
                child: Material(
                  elevation: 6,
                  child: Container(
                      height: 250,
                      width: size.width * 0.75,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [

                            Text(
                              languageCubit.payCheck!,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Text(
                              languageCubit.payCheck3!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF44455B),
                              ),
                            ),



                          ],
                        ),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
