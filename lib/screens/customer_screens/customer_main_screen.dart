
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/StateManagement/blocs/update_profil_state.dart';
import 'package:onroad/StateManagement/blocs/update_profile_cubit.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:onroad/manager/cash_manager.dart';
import 'package:onroad/manager/notification_manager.dart';
import 'package:onroad/models/customer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onroad/constant.dart';
// import 'package:device_info_plus/device_info_plus.dart';

import 'package:onroad/models/user_data.dart';
import 'package:onroad/screens/about_us_screen.dart';
import 'package:onroad/screens/common_quetion_screen.dart';
import 'package:onroad/screens/connect_us_screen.dart';
import 'package:onroad/screens/customer_screens/customer_chat_screen.dart';
import 'package:onroad/screens/customer_screens/customer_home_screen.dart';
import 'package:onroad/screens/customer_screens/customer_offer_screen.dart';
import 'package:onroad/screens/customer_screens/customer_profile_screen.dart';
import 'package:onroad/screens/privicypolicy_screen.dart';
import 'package:onroad/screens/rouls_screen.dart';
import 'package:onroad/screens/splash_screen.dart';
import 'package:onroad/widget/mydirection.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../StateManagement/blocs/aboutas_cubit.dart';
import '../../main.dart';
import '../../manager/audio_player.dart';
import '../../widget/circle_checkbox.dart';

class CustomerMainScreen extends StatefulWidget {
  const CustomerMainScreen({Key? key, required this.customer})
      : super(key: key);
  final Customer customer;

  @override
  State<CustomerMainScreen> createState() => _CustomerMainScreenState();
}

class _CustomerMainScreenState extends State<CustomerMainScreen> {
  final jobRoleCtrl = TextEditingController();
  int? color;
  int? currentIndex = 1;
  bool? active = false;
  bool? open = false;
  int? val = 1;
  int massageCounter = 0;
  List<dynamic> drawerIcons = [
    Icons.info,
    Icons.help,
    Icons.assignment_turned_in_rounded,
    Icons.assignment,
    Icons.chat,
    // Icons.share,
    Icons.bookmark,
  ];
  bool sound = CacheManager.getInstance()!.isLoggedIn()
      ? CacheManager.getInstance()!.getUserData().sound!
      : true;
  String notificationSound =CacheManager.getInstance()!.getNotificationSound();
  late AndroidNotificationChannel channel;
  List<Widget> pages = [];
  String lang = '';
  List<String> links = [];
  bool done = false ;
  bool done2 = false ;
  bool done3 = false ;


  Future<void> getLanguage() async {
    lang = (await CacheManager.getInstance()!.getLanguage())!;
    setState(() {});
  }

  @override
  void initState() {
    getOthers();
    MyAudioPlayer.getInstance()!.init();

    val = notificationSound=="notification"?1:notificationSound=="notification3"?2:3;

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

    active = CacheManager.getInstance()!.getUserData().sound!;
    // TODO: implement initState
    getLanguage();
    pages = [
      const CustomerChatScreen(),
      BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is UpdateProfileStarted) {
              return Stack(
                children: [
                  CustomerHomeScreen(
                    customer:
                    widget.customer /*Customer(id: '', userName: '', phoneNumber: '')*/,
                  ),
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
              return CustomerHomeScreen(
                customer:
                state.customer! /*Customer(id: '', userName: '', phoneNumber: '')*/,
              );
            } else {
              return CustomerHomeScreen(
                customer: widget.customer,
              );
            }
          }),
      BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is UpdateProfileStarted) {
              return Stack(
                children: [
                  CustomerProfileScreen(
                    customer: widget.customer,
                  ),
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
              return CustomerProfileScreen(
                customer: state.customer!,
              );
            } else {
              return CustomerProfileScreen(
                customer: widget.customer,
              );
            }
          }),
    ];
    super.initState();
  }
  Future<void> getOthers()async{
    SettingCubit settingCubit = SettingCubit.instance(context);
    links = await settingCubit.getOthers();
    setState(() {done = true ;});

  }
  Future<void> launchingWhatsApp(String link) async {
   // String url = "whatsapp://send?phone=+$number";
    await launchUrlString(
      link,
      mode: LaunchMode.externalApplication
    );
  }

  // int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    List<String> drawerTabeName = [
      languageCubit.AboutUs!,
      languageCubit.FAQ!,
      languageCubit.TermsConditions!,
      languageCubit.privacyPolicy!,
      languageCubit.Contactus!,
      // languageCubit.share!,
      languageCubit.offers!,
    ];
    return MyDirectionality(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          index: currentIndex!,
          color: kPrimaryColor,
          backgroundColor: Colors.transparent,
          onTap: (index) async {
            setState(() {
              currentIndex = index;
            });
            if (currentIndex == 4) {
              // await Share.share('link', subject: 'my link');
              /* setState(() {
                currentIndex = 2;
              });*/
            }
          },
          items: [
            /* Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.bookmark,
                  color: Colors.white,
                  size: 30,
                ),
                currentIndex == 0
                    ? Container()
                    : Text(
                        languageCubit.offers!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
              ],
            ),*/
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
                        style: TextStyle(
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
                        style: TextStyle(
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
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
              ],
            ),
            /*Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 30,
                ),
                currentIndex == 4
                    ? Container()
                    : Text(
                        languageCubit.share!,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
              ],
            ),*/
          ],
        ),
        endDrawer: Drawer(
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 230,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        stops: [.5, .5],
                        end: Alignment.bottomRight,
                        begin: Alignment.topLeft,
                        colors: [
                          kPrimaryColor,
                          kPrimaryColor.withOpacity(0.8),
                        ]),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Builder(
                            builder: (BuildContext context) {
                              return RotatedBox(
                                  quarterTurns: 2,
                                  child: IconButton(
                                      tooltip: MaterialLocalizations.of(context)
                                          .openAppDrawerTooltip,
                                      onPressed: () {
                                        Scaffold.of(context).closeEndDrawer();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 30,
                                        color: Colors.white,
                                      )));
                            },
                          ),
                          const Spacer(),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      Image.asset(
                        "assets/images/logo app.png",
                        height: 110,
                        width: 140,
                      ),
                      Text(
                        'Warsha Out',
                        style: GoogleFonts.roboto(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: languageCubit.language == 'AR'
                      ? size.height * 0.37
                      : size.height * 0.34,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: drawerTabeName.length,
                      itemBuilder: (context, index) {
                        return OpenContainer(
                          transitionDuration: Duration(milliseconds: 700),
                          transitionType: ContainerTransitionType.fadeThrough,
                          openBuilder: (BuildContext context, _VoidCallback ) {
                            return index == 0
                                ? AboutUsScreen()
                                : index == 1
                                    ? CommonQuetionScreen()
                                    : index == 2
                                        ? ConditionsScreen()
                                        : index == 3
                                            ? PrivicyPolicyScreen()
                                            : index == 4
                                                ? ConnectUsScreen()
                                                : index == 5
                                                    ? CustomerOfferScreen()
                                                    : Container();
                          },
                          closedBuilder: (BuildContext context,
                               openContainer) {
                            return MyDirectionality(
                              child: InkWell(
                                onTap: openContainer,
                                child: Container(
                                  color:
                                      Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12.0,
                                        top: 6,
                                        bottom: 6,
                                        left: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          drawerTabeName[index],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                kPrimaryColor.withOpacity(0.7),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          drawerIcons[index],
                                          color: /* color != index
                                              ?*/
                                              kPrimaryColor.withOpacity(
                                                  0.7) /* : Colors.white*/,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    //final device = DeviceInfoPlugin();
                   if(Platform.isAndroid){
                    Future.delayed(Duration(milliseconds: 400), () async {
                      await Share.share(links[4], subject: 'my link');
                    });
                   }else if(Platform.isIOS){
                     Future.delayed(Duration(milliseconds: 400), () async {
                       await Share.share(links[3], subject: 'my link');
                     });
                   }
                  },
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 12.0, top: 6, bottom: 6, left: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            languageCubit.share!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.share,
                            color: /* color != index
                                              ?*/
                                kPrimaryColor
                                    .withOpacity(0.7) /* : Colors.white*/,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 12, top: 6, left: 12, bottom: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                  Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return  SplashScreen(
                                    change: true, deviceLanguage: false,
                                  );
                                }));
                              },
                              child: Container(
                                width: 64,
                                height: 33,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: kPrimaryColor, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                child: Center(
                                  child: Text(
                                    lang == 'AR' ? 'EN' : 'ع',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ),
                              )),
                          Spacer(),
                          Text(
                            languageCubit.chooseLanguage!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.language,
                            color: /* color != index
                                              ?*/
                                kPrimaryColor
                                    .withOpacity(0.7) /* : Colors.white*/,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(

                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             languageCubit.notificationSetting!,
                             textAlign: TextAlign.center,
                             style: TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.w600,
                               color: kPrimaryColor.withOpacity(0.7),
                             ),
                           )
                         ],
                        ),
                        content: MyDirectionality(
                          child: SizedBox(
                            height: 80,
                            width: size.width*0.75,
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 0, top: 6, left: 0, bottom: 6),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Transform.scale(
                                            scale: 1.2,
                                            child: Switch(
                                                inactiveTrackColor: Colors.grey,
                                                activeColor: kAppBar,
                                                value: active!,
                                                onChanged: (val) async{
                                                  UserData user = CacheManager.getInstance()!
                                                      .getUserData();
                                                  user.sound = val;
                                                  await CacheManager.getInstance()!
                                                      .storeUserData(user);
                                                  await NotificationManager.listen!.cancel();
                                                 // await NotificationManager.listen2!.cancel();
                                                  //NotificationManager.lisner!.cancel();
                                                  RestartWidget.restartApp(context);
                                                  /*Navigator.pushReplacement(context,
                                                      MaterialPageRoute(builder: (context) {
                                                        return const SplashScreen(
                                                          change: false,
                                                        );
                                                      }));*/
                                                  /*setState(() {
                                          active = val;
                                        });*/
                                                }),
                                          ),
                                        ),
                                        // SizedBox(width: 50,),
                                        Spacer(),
                                        Text(
                                          languageCubit.notification!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor.withOpacity(0.7),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.notifications,
                                          color: /* color != index
                                                  ?*/
                                          kPrimaryColor
                                              .withOpacity(0.7) /* : Colors.white*/,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                /*InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    open =true;
                                    setState(() {

                                    });

                                  },
                                  child: Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 0, top: 6, left: 0, bottom: 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [

                                          Text(
                                            languageCubit.notificationSound!,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: kPrimaryColor.withOpacity(0.7),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.notifications_active,
                                            color: */
                                /* color != index
                                                    ?*/
                                /*
                                            kPrimaryColor
                                                .withOpacity(0.7) */
                                /* : Colors.white*//*,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                        ),
                      );
                    }, );
                  },
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 12, top: 6, left: 12, bottom: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Text(
                            languageCubit.notificationSetting!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.settings,
                            color: /* color != index
                                              ?*/
                                kPrimaryColor
                                    .withOpacity(0.7) /* : Colors.white*/,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                 onTap: (){
                   Navigator.pop(context);
                   //final device = DeviceInfoPlugin();
                   if(Platform.isAndroid){
                     Future.delayed(Duration(milliseconds: 400), () async {
                       launchingWhatsApp(links[4]);
                      // await Share.share(links[4], subject: 'my link');
                     });
                   }else if(Platform.isIOS){
                     Future.delayed(Duration(milliseconds: 400), () async {
                       launchingWhatsApp(links[3]);

                       //await Share.share(links[3], subject: 'my link');
                     });
                   }
                 },
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 12, top: 6, left: 12, bottom: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            languageCubit.language=='AR'?'تحديث التطبيق':'Update App',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.system_update_tv_sharp,
                            color: /* color != index
                                              ?*/
                                kPrimaryColor
                                    .withOpacity(0.7) /* : Colors.white*/,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {

                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Theme(
                            data: ThemeData(
                              dialogTheme: DialogTheme(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                            child: AlertDialog(
                              content: SizedBox(
                                width: 350,
                                height: 150,
                                child: Column(
                                  children: [
                                    Text(languageCubit.logOut2!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        )),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: size.width * 0.3,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      const Radius.circular(7)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(top: 0.0),
                                              child: Center(
                                                child: Text(
                                                    languageCubit.cancel!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              done3 = true;
                                            });
                                            //Navigator.pop(context);
                                            await FirebaseMessaging.instance
                                                .unsubscribeFromTopic('customers');
                                            await FirebaseMessaging.instance
                                                .unsubscribeFromTopic("c"+widget
                                                    .customer.id
                                                    .toString());

                                            await CacheManager.getInstance()!
                                                .logout();
                                            LoginCubit loginCubit =
                                                LoginCubit.instance(context);
                                            Navigator.pop(context);
                                            loginCubit.logout();
                                            setState(() {
                                              done3 = false;
                                            });
                                          },
                                          child: Container(
                                            width: size.width * 0.3,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: kPrimaryColor),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      const Radius.circular(7)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(top: 0.0),
                                              child: Center(
                                                child: Text(
                                                    languageCubit.accept!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: kPrimaryColor,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });

                  },
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 12, top: 6, left: 12, bottom: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            languageCubit.Logout!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.power_settings_new,
                            color: /* color != index
                                              ?*/
                                kPrimaryColor
                                    .withOpacity(0.7) /* : Colors.white*/,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('V1.0 ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Stack(
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
          elevation: 4,
          backgroundColor: kPrimaryColor,
          title: Image.asset(
            'assets/images/logo app.png',
            width: 75,
            height: 75,
          ),
          centerTitle: true,
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      size: 34,
                    ));
              },
            )
          ],
        ),
        body:
          done? Stack(children: [
             pages[currentIndex!],

             open!?Container(
               width: double.infinity,
               height: double.infinity,
               color: Colors.grey.withOpacity(0.3),
             ):Container(),
             open!?Center(
               child: SizedBox(
                 height: 320,
                 width: size.width*0.8,
                 child: Card(
                   child: Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               ' ${languageCubit.chooseSound}',
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.w600,
                                 color: kPrimaryColor.withOpacity(0.7),
                               ),
                             )
                           ],
                         ),
                         Row(
                           children: [
                             IconButton(onPressed: ()async{
                               await MyAudioPlayer.getInstance()!.playAudio('notification.mp3');
                               // MyAudioPlayer.getInstance()!.audioPlayer.resume();
                             }, icon: Icon(Icons.play_arrow)),
                             Spacer(),

                             Text(
                               '1 ${languageCubit.sound}',
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 fontSize: 16,
                                 fontWeight: FontWeight.w600,
                                 color: kPrimaryColor.withOpacity(0.7),
                               ),
                             ), CircleCheckBox(
                               value: val==1?true:false, onTap: () async{
                               setState(() {
                                 val=1;
                               });
                               //await CacheManager.getInstance()!.setNotificationSound('notification');

                             },),


                           ],
                         ),
                         Row(
                           children: [
                             IconButton(
                                 onPressed: ()async{
                              await  MyAudioPlayer.getInstance()!.playAudio('notification3.mp3');
                               // MyAudioPlayer.getInstance()!.audioPlayer.resume();
                             }, icon: Icon(Icons.play_arrow)),
                             Spacer(),
                             Text(
                               '2 ${languageCubit.sound}',
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 fontSize: 16,
                                 fontWeight: FontWeight.w600,
                                 color: kPrimaryColor.withOpacity(0.7),
                               ),
                             ),CircleCheckBox(
                               value: val==2?true:false, onTap: () async{
                               setState(() {
                                 val=2;
                               });

                             },),

                           ],
                         ),
                         Row(
                           children: [
                             IconButton(onPressed: ()async{
                               await  MyAudioPlayer.getInstance()!.playAudio('notification4.mp3');
                           //    MyAudioPlayer.getInstance()!.audioPlayer.resume();

                             }, icon: Icon(Icons.play_arrow)),
                             Spacer(),
                             Text(
                               '3 ${languageCubit.sound}',
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 fontSize: 16,
                                 fontWeight: FontWeight.w600,
                                 color: kPrimaryColor.withOpacity(0.7),
                               ),
                             ), CircleCheckBox(
                               value: val==3?true:false, onTap: () async{
                               setState(() {
                                 val=3;
                               });

                             },),


                           ],
                         ),
                         Spacer(),
                         GestureDetector(
                           onTap: ()async{
                            await CacheManager.getInstance()!.setNotificationSound(val==1?"notification":val==2?"notification3":"notification4");
                            await NotificationManager.listen!.cancel();
                            //await NotificationManager.listen2!.cancel();
                            RestartWidget.restartApp(context);
                         /*   Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                  return const SplashScreen(change: false,

                                  );
                                }));*/

                           },
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                               // padding: const EdgeInsets.all(10),
                               height: 45,
                               width: size.width * 0.5,
                               decoration: const BoxDecoration(
                                   color: kPrimaryColor,
                                   borderRadius:
                                   const BorderRadius.all(
                                       Radius.circular(7))),
                               child: Center(
                                 child: Text(
                                   languageCubit.Save!,
                                   style: TextStyle(
                                     fontSize: 23,
                                     fontWeight: FontWeight.w600,
                                     color: Colors.white,
                                   ),
                                   textAlign: TextAlign.center,
                                 ),
                               ),
                             ),
                           ),
                         )

                       ],
                     ),
                   ),
                 ),
               ),
             ):Container(),

           ],):Center(child: CircularProgressIndicator(color: kPrimaryColor,),),

      ),
    );
  }
}
