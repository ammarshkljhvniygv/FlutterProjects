import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/screens/splash_screen.dart';
import 'package:onroad/widget/mydirection.dart';

import '../manager/cash_manager.dart';

class BusyProviderScreen extends StatefulWidget {
  const BusyProviderScreen({Key? key}) : super(key: key);

  @override
  State<BusyProviderScreen> createState() => _BusyProviderScreenState();
}

class _BusyProviderScreenState extends State<BusyProviderScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return MyDirectionality(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            title: Image.asset(
              'assets/images/logo app.png',
              width: 75,
              height: 75,
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.05,
              ),
              Image.asset(
                  'assets/images/2205_w039_n003_244b_p1_244 [Converted].png'),
              SizedBox(
                width: double.infinity,
                height: size.height * 0.05,
              ),
              Material(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  elevation: 6,
                  child: Container(
                      width: size.width * 0.8,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                            languageCubit.busyT1!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ))),
              SizedBox(
                width: double.infinity,
                height: size.height * 0.1,
              ),
              GestureDetector(
                onTap: () async{
                  await CacheManager.getInstance()!.orderDone();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return SplashScreen(change: false,
                      deviceLanguage: false,
                    );
                  }));

                },
                child: Container(
                  width: size.width * 0.8,
                  height: 45,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(7)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Center(
                      child: Text(languageCubit.busyT2!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              GestureDetector(
                onTap: () async{
                 await CacheManager.getInstance()!.orderDone();
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                   return SplashScreen(change: false,
                     deviceLanguage: false,);
                 }));
                // Navigator.pop(context);

                },
                child: Container(
                  width: size.width * 0.8,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: kPrimaryColor),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(7)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Center(
                      child: Text(languageCubit.busyT3!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
