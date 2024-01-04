/*
import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
 [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyDuKChmAxVTwpXjq9JfukYUAvvxz4WWwC0")
     */
/*
         if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
         }
     *//*

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
        
 */

import UIKit
import GoogleMaps
import Firebase
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyDuKChmAxVTwpXjq9JfukYUAvvxz4WWwC0")
    GeneratedPluginRegistrant.register(with: self)
   if #available(iOS 10.0, *) {
     UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
   }
    if(!UserDefaults.standard.bool(forKey: "Notification")) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UserDefaults.standard.set(true, forKey: "Notification")
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        super.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
          let firebaseAuth = Auth.auth()
            Messaging.messaging().appDidReceiveMessage(userInfo)
            print(userInfo)
          if (firebaseAuth.canHandleNotification(userInfo)){
              completionHandler(.noData)
              return
          }
      }

}

