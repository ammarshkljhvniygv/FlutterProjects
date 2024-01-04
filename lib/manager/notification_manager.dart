import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onroad/manager/audio_player.dart';
import 'package:onroad/manager/cash_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workmanager/workmanager.dart';
import 'package:path_provider/path_provider.dart';


class NotificationManager  extends State with WidgetsBindingObserver {


  NotificationManager._();

  static NotificationManager? _instance ;

  static NotificationManager? getInstance() {
    _instance ??= NotificationManager._();
    return _instance!;
  }
   MethodChannel platform =
  MethodChannel('dexterx.dev/flutter_local_notifications_example');

  static StreamController<String?> selectNotificationStream =
  StreamController<String?>.broadcast();

  static StreamSubscription<RemoteMessage>? listen ;
  static StreamSubscription<RemoteMessage>? listen2 ;
  static bool sound = CacheManager.getInstance()!.isLoggedIn()
      ? CacheManager.getInstance()!.getUserData().sound!
      : true;
  static String notificationSound =CacheManager.getInstance()!.getNotificationSound();
  static late AndroidNotificationChannel channel;
  String? lang;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static NotificationDetails notificationDetails = NotificationDetails();
  static const String _mainToken =
      'AAAAK0kTc2s:APA91bFCpEDatHjWpZNsUr6swzNftKM2AjFqN-zK8WgZRjtvvl8iAOenm-lbuOULR5kIPOEDUGYTrA3PZ6QueYcXGcvvRpzCcbXShcQBaBoAj_nu_VLB4jxkCgFpyHlTYRg36LBQisa3';

  static Future<void> sendNotification(
      String? topicName, String? title, String? body,bool order,bool chat) async {
    try {
      http.Response response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $_mainToken'
              },
              body: jsonEncode(
                {
                  'to': '/topics/$topicName',
                  'notification': {
                    'title': title,
                    'body': body,
                    "title_loc_key":order?"orde$topicName":chat?'chat':"not"
                  },
                },
              ));
      print('FCM request for device sent!${response.body}');
    } catch (e) {
      print(e);
    }
  }

 static Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
        critical: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
        critical: true,
      );

    } else if (Platform.isAndroid) {
      FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()?.requestPermission(
      );
    }

  }
@pragma('vm:entry-point')
static  Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message) async {
    await CacheManager.getInstance()!.init();
    await Firebase.initializeApp();

    print('------------------------------backnoti');

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? apple = message.notification?.apple;
    var initialzationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    print('------------------------------backnoti');

    if (notification != null && (android != null || apple != null) && !notification.titleLocKey!.contains('orde'))
    {
      dynamic random = Random().nextInt(10000000);
      channel = AndroidNotificationChannel(
        '$random', // id
        '$random', // title
        importance: Importance.high,
        playSound: sound,
        //  sound:RawResourceAndroidNotificationSound(notificationSound)
      );

      dynamic chId = await CacheManager.getInstance()!.getChannelId().toString();
      if(chId != null) {
        print('------------------------------channelid');
        print(chId.toString());
        print('------------------------------channelid');
        //listen!.cancel();
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
            .deleteNotificationChannel(chId.toString());
      }

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();
      await CacheManager.getInstance()!.setChannelId(random.toString());
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: sound,
        badge: sound,
        sound: sound,
      );
      print(notification.titleLocKey);

      print('------------------------------backnoti');
  flutterLocalNotificationsPlugin.show(
  notification.hashCode,
  notification.title,
  notification.body,
  NotificationDetails(
  android: AndroidNotificationDetails(
  channel.id,
  channel.name,
  color: Colors.blue,
  playSound: sound,
  //sound: RawResourceAndroidNotificationSound(notificationSound),
  // TODO add a proper drawable resource to android, for now using
  //      one that already exists in example app.
  icon: "@mipmap/ic_launcher",
  ),
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,

    ),
    macOS:  DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  ));
  }
    else if(notification != null && (android != null || apple != null) && notification.titleLocKey!.contains('ordep')){
     print('-------------------------------------${notification.titleLocKey!.substring(5).toString()}');
     Map<String, dynamic>? map ={'type':"2"};
     Workmanager().registerOneOffTask('sound', UniqueKey().toString(),inputData: map,initialDelay: Duration(seconds: 0));
    }

  print('------------------------------backnoti');
  print('Handling a background message ${message.messageId}');
    await Firebase.initializeApp();
  }

@pragma('vm:entry-point')
 static void notificationTapBackground(NotificationResponse notificationResponse) {
    // handle action
    print('------------');
    print('------------');
    print('------------');
    print('------------');
    print('------------');
  }

  static Future<void> initNotification() async {
   // late AndroidNotificationChannel channel;
    await CacheManager.getInstance()!.init();

    if(listen != null){
  listen!.cancel();
}
    bool  sound = CacheManager.getInstance()!.isLoggedIn()
      ? CacheManager.getInstance()!.getUserData().sound!
      : true;

   String notificationSound =CacheManager.getInstance()!.getNotificationSound();
   print(notificationSound);
   /////////ios
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        print('----------------------');
        print('----------------------');
        print('----------------------');

        flutterLocalNotificationsPlugin.show(
                id,
                title,
                body,
                NotificationDetails(
                    iOS: DarwinNotificationDetails(
                      presentAlert: true,
                      presentBadge: true,
                      presentSound: true,
                    )
                )
            );
     /*   didReceiveLocalNotificationStream.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );*/
      },
    );
    ////////////////////////////////////////////////////////////////
  var initialzationSettingsAndroid =
  const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings =
  InitializationSettings(
    android: initialzationSettingsAndroid,
    iOS: initializationSettingsDarwin
  );
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse:
      (NotificationResponse notificationResponse) {
    print('-----------');
    print('-----------');
    print('-----------');
    print('-------'+notificationResponse.payload.toString());
    print('-------'+notificationResponse.payload.toString());


  },
  onDidReceiveBackgroundNotificationResponse: notificationTapBackground,

  );

    dynamic random = Random().nextInt(10000000);
  channel = AndroidNotificationChannel(
      '$random', // id
      '$random', // title
      importance: Importance.high,
      playSound: sound,
     // sound:RawResourceAndroidNotificationSound(notificationSound)
      );
  dynamic chId = await CacheManager.getInstance()!.getChannelId().toString();
  if(chId != null) {
    print('------------------------------channelid');
    print(chId.toString());
    print('------------------------------channelid');
    //listen!.cancel();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannel(chId.toString());
  }
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

    _requestPermissions();

  await CacheManager.getInstance()!.setChannelId(random.toString());
  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
    alert: sound,
    badge: sound,
    sound: sound,
  );
    String lastMessageId = "0";

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  listen = FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
    var messageId = message.messageId!;
    // int messageId = int.parse(data['id']);
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = appDocDir.path + '/images';
    final http.Response response = await http.get(Uri.parse('https://firebasestorage.googleapis.com/v0/b/warshaout.appspot.com/o/images%2Fimage_picker9185166493575781713.jpg?alt=media&token=f539a71f-34c4-4b88-9113-294d2560138c'));
    print(response.bodyBytes);
    print('-------------------------------------image');

    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    if (notification != null && android != null && lastMessageId != messageId /*&&  notification.titleLocKey!='chat'*/) {
      lastMessageId = messageId;
      print('-------------------------------------1$sound');
      print('-------------------------------------1$notificationSound');
      print('-------------------------------------10000');
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.blue,
              playSound: sound,
              enableLights: true,
              enableVibration: true,

             /* styleInformation: BigPictureStyleInformation(
                FilePathAndroidBitmap(filePath),
                largeIcon:FilePathAndroidBitmap(filePath)
              ),*/

              //sound: RawResourceAndroidNotificationSound(notificationSound),
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: "@mipmap/ic_launcher",

            ),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,

            ),
            macOS:  DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
      );
    }
  });

}


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}


