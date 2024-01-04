import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:onroad/StateManagement/blocs/aboutas_cubit.dart';
import 'package:onroad/StateManagement/blocs/services_cubit.dart';
import 'package:onroad/screens/nointernet_screen.dart';
import 'firebase_options.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:onroad/manager/audio_player.dart';
import 'package:onroad/manager/cash_manager.dart';
import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/language_state.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/StateManagement/blocs/order_cubit.dart';
import 'package:onroad/StateManagement/blocs/provider_cubit.dart';
import 'package:onroad/StateManagement/blocs/provider_order_cubit.dart';
import 'package:onroad/StateManagement/blocs/update_profile_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'StateManagement/blocs/car_cubit.dart';
import 'package:workmanager/workmanager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// GeneratedPluginRegistrant.registerWith(flutterEngine);

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task,inputData) async {
    print("Native echoed: ------------------------------------------$task");

    if(inputData!['type'].toString()=="1")
    {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
     //  options: DefaultFirebaseOptions.currentPlatform,
      );
     // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

      DocumentSnapshot<Map<String, dynamic>> order = await FirebaseFirestore
          .instance
          .collection("Orders")
          .doc(inputData['id'].toString())
          .get();
      if (order.data()!['order_state'] == 'open') {
        await FirebaseFirestore.instance
            .collection("Orders")
            .doc(inputData['id'].toString())
            .update({'order_state': 'timeout'});
      }

      print("Native echoed: ------------------------------------------$task");
      return Future.value(true);
    }else if(inputData['type'].toString()=="2") {
      print("Native echoed: ------------------------------------------play");
    // await MyAudioPlayer.getInstance()!.init();
      MyAudioPlayer.getInstance()!.playAudio("notification30.mp3");
    }
   await Future.delayed(Duration(seconds: 29),(){
    });
    return Future.value(true);

  });
}
Future<void> updateOrderStateToCancel(String id) async {
 // await Firebase.initializeApp();
  await FirebaseFirestore.instance
      .collection("Orders")
      .doc(id)
      .update({'order_state': 'canceled'});
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(RestartWidget(child: const MyApp()));
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

}


class _MyAppState extends State<MyApp> {

  late StreamSubscription subscription;
  var isDeviceConnection = false ;

  @override
  void initState() {
    getConnection(context);
    // WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();
  }



  getConnection(BuildContext context) async{

 //   subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async{
      isDeviceConnection = await InternetConnectionChecker().hasConnection;
      print(isDeviceConnection);
      print(isDeviceConnection);
      print(isDeviceConnection);
      setState(() {

      });
      if(!isDeviceConnection){

      }else{
     //   WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(
          //options: DefaultFirebaseOptions.currentPlatform,
        );

        await CacheManager.getInstance()!.init();
        await Workmanager().initialize(
          callbackDispatcher, //the top level function.
          isInDebugMode: false,//If enabled it will post a notification whenever the job is running. Handy for debugging jobs
        );

        await FirebaseMessaging.instance.subscribeToTopic('all');
        print('----------------');
      }
/*    });*/
  }


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<UpdateProfileCubit>(
          create: (BuildContext context) {
            // return LoginCubit()..sessionValidate(context);
            return UpdateProfileCubit();
            // return sl<LoginCubit>();
          },
        ),
        BlocProvider<LoginCubit>(
          create: (BuildContext context) {
            // return LoginCubit()..sessionValidate(context);
            return LoginCubit();
            // return sl<LoginCubit>();
          },
        ),
        BlocProvider<CarDataCubit>(
          create: (BuildContext context) {
            // return LoginCubit()..sessionValidate(context);
            return CarDataCubit();
            // return sl<LoginCubit>();
          },
        ),
        BlocProvider<OrderCubit>(
          create: (BuildContext context) {
            // return LoginCubit()..sessionValidate(context);
            return OrderCubit();
            // return sl<LoginCubit>();
          },
        ),
        BlocProvider<SettingCubit>(
          create: (BuildContext context) {
            // return LoginCubit()..sessionValidate(context);
            return SettingCubit();
            // return sl<LoginCubit>();
          },
        ),
        BlocProvider<LanguageCubit>(
          create: (BuildContext context) {
            // return LoginCubit()..sessionValidate(context);
            return LanguageCubit();
            // return sl<LoginCubit>();
          },
        ),
        BlocProvider<ProviderHomeCubit>(
          create: (BuildContext context) {
            // return LoginCubit()..sessionValidate(context);
            return ProviderHomeCubit();
            // return sl<LoginCubit>();
          },
        ),
        BlocProvider<ServiceCubit>(
          create: (BuildContext context) {
            // return LoginCubit()..sessionValidate(context);
            return ServiceCubit();
            // return sl<LoginCubit>();
          },
        ),
        BlocProvider<ProviderOrderCubit>(
          create: (BuildContext context) {
            // return LoginCubit()..sessionValidate(context);
            return ProviderOrderCubit();
            // return sl<LoginCubit>();
          },
        ),
      ],
      child: Builder(builder: (context) {
        LanguageCubit languageCubit = LanguageCubit.instance(context);

        return BlocConsumer<LanguageCubit, LanguageStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetLanguageState) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    appBarTheme: AppBarTheme(
                      backgroundColor: kPrimaryColor,
                      centerTitle: true,
                    ),
                    textTheme: TextTheme(
                      bodyText1: state.lang == 'AR'
                          ? GoogleFonts.cairo()
                          : GoogleFonts.roboto(),
                      bodyText2: state.lang == 'AR'
                          ? GoogleFonts.cairo()
                          : GoogleFonts.roboto(),
                    ),
                    pageTransitionsTheme: PageTransitionsTheme(
                      builders: {
                        TargetPlatform.android:
                            FadeThroughPageTransitionsBuilder(),
                        TargetPlatform.iOS: FadeThroughPageTransitionsBuilder(),
                      },
                    ),
                  ),
                  home:!isDeviceConnection?NoInternetScreen(): SplashScreen(
                    change: false,
                    deviceLanguage: true,

                  ),
                );
              } else {
                return Container();
              }
            });
      }),
    );
  }
}
/**/


class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}