import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/StateManagement/blocs/order_cubit.dart';
import 'package:onroad/manager/cash_manager.dart';
import 'package:onroad/manager/notification_manager.dart';
import 'package:onroad/models/customer.dart';
import 'package:onroad/models/order.dart';
import 'package:onroad/models/provider.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:onroad/screens/customer_screens/customer_islogin_screen.dart';
import 'package:onroad/screens/customer_screens/customer_order_state_screen.dart';
import 'package:onroad/screens/onboarding_screen.dart';
import 'package:onroad/screens/provider_screens/provider_islogin_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key,  this.change = false, this.deviceLanguage =false}) : super(key: key);
  final bool change ;
  final bool deviceLanguage;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation _curvedAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _fadeAnimation;

  String? lang;

  void deviceLanguage()async{
    List? languages = await Devicelocale.preferredLanguages;
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    if(languages!.first.toString().substring(0,2) == 'en'){
      lang = 'EN';
      await  setLanguage('EN');
      lang = await CacheManager.getInstance()!.getLanguage();
      print(lang);
      print(lang);
      print(lang);

    }else{
      lang = 'AR';
      await setLanguage('AR');
      lang = await CacheManager.getInstance()!.getLanguage();
      print(lang);
      print(lang);
      print(lang);
    }
    setState(() {});
    print('----------------');
    print(languages.first.toString().substring(0,2));
    print('----------------');

  }
  Future<void> getLanguage() async {
    await CacheManager.getInstance()!.init();
    lang = await CacheManager.getInstance()!.getLanguage();
    print(lang);
    print(lang);

    if (widget.change) {
      setState(() {
        if (lang == 'EN') {
          print('eeeeeeeeennnnnn');
          lang = 'AR';
          setLanguage(lang!);
        } else {
          print('aaaaaarrrrr');
          print(lang);
          lang = 'EN';
          setLanguage(lang!);
        }
      });
    }

  }

  Future<void> setLanguage(String lan) async {
    await CacheManager.getInstance()!.setLanguage(lan);
  }

void initNotification()async{
  await CacheManager.getInstance()!.init();
  await  NotificationManager.initNotification();
}

  @override
  void initState() {
    initNotification();
   // NotificationManager.initNotification();
    getLanguage();

    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1500),
        lowerBound: 0,
        upperBound: 1);

    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceIn);

    _colorAnimation = ColorTween(begin: Colors.black, end: Colors.white)
        .animate(_animationController);

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();

    _animationController.addListener(() {
      setState(() {});
    });


    Future.delayed(Duration(seconds: 3), () async {
      if (CacheManager.getInstance()!.isLoggedIn()) {
        print('---------------------1');
        print(CacheManager.getInstance()!.getUserData().userType);
        if (CacheManager.getInstance()!.getUserData().userType == 'customer') {
          if (CacheManager.getInstance()!.isAnyOrder()) {
            LoginCubit loginCubit = LoginCubit.instance(context);
            String orderId = CacheManager.getInstance()!.getOrderData();
            OrderCubit orderCubit = OrderCubit.instance(context);
            Order? order = await orderCubit.getOrder(orderId);
            Provider provider = await loginCubit.getProviderById(order!.providerId.toString());

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CustomerOrderStateScreen(order: order,provider: provider,)));
          } else {
            print('---------------------2');
            LoginCubit loginCubit = LoginCubit.instance(context);
            Customer customer = await loginCubit.getCustomerById(
                CacheManager.getInstance()!.getUserData().userId.toString());
            await FirebaseMessaging.instance.subscribeToTopic(
                "c"+CacheManager.getInstance()!.getUserData().userId.toString());
            await FirebaseMessaging.instance.subscribeToTopic('customers');

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerIsLoginScreen()));
          }
        }
        else {
          LoginCubit loginCubit = LoginCubit.instance(context);
          Provider provider = await loginCubit.getProviderById(
              CacheManager.getInstance()!.getUserData().userId.toString());
/*          await FirebaseMessaging.instance.subscribeToTopic(
              "p"+CacheManager.getInstance()!.getUserData().userId.toString());*/
          await FirebaseMessaging.instance.subscribeToTopic('providers');

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ProviderIsloginScreen()));
        }
      } else {
        deviceLanguage();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OnBoardingScreen(),
            ));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    languageCubit.changeLanguage(lang);

    return Scaffold(
      backgroundColor: _colorAnimation.value,
      body: Stack(
        children: [
          /* Opacity(
            opacity: 0.9,
            child: Image.asset(
              "assets/images/map.jpg",
              height: double.infinity,
              width: 650,
              fit: BoxFit.fill,
            ),
          ),*/
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: Image.asset(
                  "assets/images/logo_with_logen.png",
                  // height: 250,
                  width: 1000,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
