
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart'as fs;
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/StateManagement/blocs/provider_cubit.dart';
import 'package:onroad/StateManagement/blocs/provider_state.dart';
import 'package:onroad/StateManagement/blocs/update_profil_state.dart';
import 'package:onroad/StateManagement/blocs/update_profile_cubit.dart';
import 'package:onroad/manager/cash_manager.dart';
import 'package:onroad/manager/location_maneger.dart';
import 'package:onroad/models/location_position.dart';
import 'package:onroad/models/provider.dart';
import 'package:onroad/screens/provider_screens/provider_chat_screen.dart';
import 'package:onroad/screens/provider_screens/provider_ordertap_screen.dart';
import 'package:onroad/screens/provider_screens/provider_profil_screen.dart';
import 'package:onroad/widget/mydirection.dart';
import 'package:workmanager/workmanager.dart';
import '../../StateManagement/blocs/order_cubit.dart';
import '../../StateManagement/blocs/order_states.dart';
import '../../constant.dart';
import '../../manager/audio_player.dart';

class ProviderScreen extends StatefulWidget {
  const ProviderScreen({Key? key, required this.provider}) : super(key: key);
  final Provider provider;

  @override
  State<ProviderScreen> createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> with WidgetsBindingObserver{
  List<Widget> pages = [];
  int currentIndex = 1;
  bool? active = false;
  bool? permission = false;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{


    print('--------------------');
    print(state);
    print(state);
    print(state);
    print('--------------------');

    if(state == AppLifecycleState.resumed){
     await Workmanager().cancelByUniqueName('sound');
      print(state);

     // MyAudioPlayer.getInstance()!.init();
 /*   await  MyAudioPlayer.getInstance2()!.stop();
    await  MyAudioPlayer.getInstance2()!.dispose();
    await  MyAudioPlayer.getInstance2()!.pause();*/
    }
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    // TODO: implement initState
    getStateUser();
    pages = [
      const ProviderChatScreen(),
      BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is UpdateProfileStarted) {
              return Stack(
                children: [
                  ProviderOrderTapScreen(provider: widget.provider),
                  Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black12,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      ))
                ],
              );
            } else if (state is UpdateProfileSuccessfully) {
              return ProviderOrderTapScreen(
                provider: state.provider!,
              );
            } else {
              return ProviderOrderTapScreen(provider: widget.provider);
            }
          }),
      BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is UpdateProfileStarted) {
              return Stack(
                children: [
                  ProviderProfileScreen(provider: widget.provider),
                  Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black12,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      ))
                ],
              );
            } else if (state is UpdateProfileSuccessfully) {
              LanguageCubit languageCubit = LanguageCubit.instance(context);
              print(state.result);
              if (state.result != null) {
                print(state.result);
                Future.delayed(Duration(milliseconds: 400), () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      padding: EdgeInsets.all(10),
                      content: Text(
                        languageCubit.language == 'EN'
                            ? state.result!
                            : state.result == 'this user name used'
                                ? 'اسم المستخدم هذا مستخدم بحساب اخر'
                                : state.result == 'this email used'
                                    ? 'الإيميل هذا مستخدم بحساب اخر'
                                    : 'رقم السيارة هذا مستخدم بحساب اخر',
                        textAlign: TextAlign.center,
                      )));
                });
                UpdateProfileCubit updateProfileCubit =
                    UpdateProfileCubit.instance(context);
                updateProfileCubit.emit(UpdateProfileSuccessfully(
                    customer: state.customer,
                    provider: state.provider,
                    result: null));
              }
              return ProviderProfileScreen(
                provider: state.provider!,
              );
            } else {
              return ProviderProfileScreen(provider: widget.provider);
            }
          }),
    ];

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      massageCounter=massageCounter
          +1;
      setState(() {

      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //massageCounter = 0 ;
      massageCounter=massageCounter+1;
      print('hiiiiiiiiiii');
      print('hiiiiiiiiiii');
      print('hiiiiiiiiiii');
      setState(() {

      });
    });
    super.initState();
  }
  int massageCounter = 0;

  Future<void> getLocation() async {}
  Future<void> setStateUser(String state) async {

    LocationManager locationManager = LocationManager();
    LocationPosition locationPosition = await locationManager.getLocation();
    LoginCubit loginCubit = LoginCubit.instance(context);
    loginCubit.setProviderLocation(widget.provider.id.toString(), locationPosition.latitude.toString(), locationPosition.longitude.toString());
    await fs.FirebaseFirestore.instance
        .collection('ActiveProvider')
        .doc(widget.provider.id.toString())
        .update({
      'active': state,
      'lat': locationPosition.latitude,
      'lng': locationPosition.longitude
    });

    print("-------------------------------------------------------------");
  }

  Future<void> getStateUser() async {
    dynamic data = await fs.FirebaseFirestore.instance
        .collection("ActiveProvider")
        .doc(widget.provider.id.toString())
        .get();
    print(data['active']);
    active = data['active'] == 'active' ? true : false;
    if(active!)
      updateLocation();
    setState(() {});

    print("-------------------------------------------------------------");
    print("-------------------------------------------------------------");
    print("-------------------------------------------------------------");
  }
  Future<void> updateProviderLocation(double lat,double lng) async {


    LoginCubit loginCubit = LoginCubit.instance(context);
    loginCubit.setProviderLocation(widget.provider.id.toString(), lat.toString(), lng.toString());

  }
  void updateLocation()async{
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    Location location = new Location();

    bool _serviceEnabled;
    bool _enableBackgroundMode;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text(languageCubit.chooseLanguage=='AR'?"استخدام موقعك":'Use your location',textAlign: TextAlign.center,),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 500,
              child: MyDirectionality(
                child: Column(
                  children: [
                    SizedBox(
                        width: 350,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(languageCubit.chooseLanguage=='AR'?
                          'يجمع ورشة اوت بيانات الموقع الجغرافي لتفعيل ميزة تتبع المزود حتى اذا كان التطبيق مغلقا او لم يكن قيد الاستخدام':
                          "Warshaout collects geolocation data to activate the provider tracking feature even if the application is closed or not in use.",
                            textAlign:TextAlign.center,
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        )),
                    Image.asset('assets/images/permission2.png'),
                    Spacer(),
                 Padding(

                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            onPressed: ()async{




                                  _permissionGranted =
                                  await location.requestPermission();

                                  _enableBackgroundMode =
                                  await location.isBackgroundModeEnabled();
                                  if (!_enableBackgroundMode) {
                                    _enableBackgroundMode =
                                    await location.enableBackgroundMode(
                                        enable: true);
                                    // Navigator.pop(context);
                                    if(Platform.isIOS) {
                                      if (await AppTrackingTransparency
                                              .trackingAuthorizationStatus ==
                                          TrackingStatus.notDetermined) {
                                        final status =
                                            await AppTrackingTransparency
                                                .requestTrackingAuthorization();

                                        if (status !=
                                            TrackingStatus.authorized) {
                                          //  Navigator.pop(context);
                                          return;
                                        }
                                      }
                                    }
                                    if (!_enableBackgroundMode) {
                                      //  Navigator.pop(context);
                                      return;
                                    }
                                  }


                          },child: Text(languageCubit.chooseLanguage=='AR'?"تشغيل":'Turn on'),),
           /*               MaterialButton(onPressed: (){
                            Navigator.pop(context);
                          },child: Text(languageCubit.chooseLanguage=='AR'?"لا شكرا":'No thanks'),),*/
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

        );
      });


      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }



    location.onLocationChanged.listen((event) {

      print(event.longitude.toString());
      updateProviderLocation(event.latitude!,event.longitude!);
    });}

  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);


    return WillPopScope(
      onWillPop: () async{
        return false ;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: currentIndex == 1
              ? BlocConsumer<ProviderHomeCubit, ProviderHomeStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is HomeScreenStates) {
                      return Stack(
                        children: [
                          Center(
                            child:  IconButton(
                              icon: Icon(Icons.notifications,
                                size: 30,),
                              onPressed: (){
                                massageCounter = 0 ;
                                setState(() {

                                });
                              },
                            ),
                          ),
                          massageCounter==0?Container():Positioned(
                            top: 27,
                            left: 27,
                            child: Container(
                              width: 17,
                              height: 17,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.red
                              ),

                            ),
                          ),
                          massageCounter==0?Container():Positioned(
                              top: languageCubit.language=='AR'?25 : 28,
                              left: 32,
                              child: Text(massageCounter.toString(),selectionColor: Colors.white,style: TextStyle(fontSize: 12),))
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  })
              : Stack(
            children: [
              Center(
                child:  IconButton(
                  icon: Icon(Icons.notifications,
                    size: 30,),
                  onPressed: (){
                    massageCounter = 0 ;
                    setState(() {

                    });
                  },
                ),
              ),
              massageCounter==0?Container():Positioned(
                top: 27,
                left: 27,
                child: Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.red
                  ),

                ),
              ),
              massageCounter==0?Container():Positioned(
                  top: languageCubit.language=='EN'?28 : 23,
                  left: 32,
                  child: Text(massageCounter.toString(),selectionColor: Colors.white,style: TextStyle(fontSize: 12),))
            ],
          ),
          centerTitle: true,
          title: Image.asset(
            'assets/images/logo app.png',
            width: 75,
            height: 75,
          ),
          actions: [

            BlocConsumer<ProviderHomeCubit, ProviderHomeStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is HomeScreenStates) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Transform.scale(
                        scale: 1.2,
                        child: Switch(
                            inactiveTrackColor: Colors.grey,
                            activeColor: kAppBar,
                            value: active!,
                            onChanged: (val) {
                              if (active!) {
                                setStateUser('inactive');
                              } else {

                                setStateUser('active');
                              }
                              setState(() {
                                active = val;
                              });
                            }),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                }),

            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                icon: Icon(Icons.power_settings_new),
                onPressed: () async {
                  await FirebaseMessaging.instance.unsubscribeFromTopic('providers');
                  await FirebaseMessaging.instance.unsubscribeFromTopic("p"+
                      CacheManager.getInstance()!
                          .getUserData()
                          .userId
                          .toString());
                  LoginCubit loginCubit = LoginCubit.instance(context);
                  await CacheManager.getInstance()!.logout();
                  loginCubit.logoutProvider();

                  /*  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return ChooseScreen();
                  }));*/
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          index: currentIndex,
          color: kPrimaryColor.withOpacity(01),
          backgroundColor: Colors.transparent,
          onTap: (index) {
            setState(() {
              // _animationController!.reset();
              // _animationController!.forward();
              currentIndex = index;
            });
          },
          items: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.chat,
                  color: Colors.white,
                  size: 30,
                ),
                currentIndex == 0
                    ? Container()
                    : Text(
                        languageCubit.chatUs!,
                        style: GoogleFonts.cairo(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 30,
                ),
                currentIndex == 1
                    ? Container()
                    : Text(
                        languageCubit.home!,
                        style: GoogleFonts.cairo(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
                currentIndex == 2
                    ? Container()
                    : Text(
                        languageCubit.profile!,
                        style: GoogleFonts.cairo(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
              ],
            ),
            /*  const Icon(
              Icons.share,
              color: Colors.white,
              size: 30,
            ),*/
          ],
        ),
        body: pages[currentIndex],
      ),
    );
  }
}
