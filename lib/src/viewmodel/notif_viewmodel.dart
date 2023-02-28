import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan/src/viewmodel/account_viewmodel.dart';
import 'package:provider/provider.dart';

class NotificationViewModel with ChangeNotifier {
  /// get device FCM token
  Future<void> getFCMtokens() async {
    NotificationViewModel().notificationListen();
    FirebaseMessaging.instance.getToken().then((token) {
      debugPrint("Device FCM Token: $token");
    });
  }

  /// stream listen notification
  Future<void> notificationListen() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint(
            'Message also contained a notification: ${message.notification}');
      }
    });
  }

  /// request permission for web and ios
  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }

  String? fcmTokens;

  ///handle 1 account in 2 device to sace FCM token
  Future<void> saveTokenFCMinMultipleDevice({
    required BuildContext context,
  }) async {
    final accountProvider =
        Provider.of<AccountViewModel>(context, listen: false);
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    debugPrint('try save token started...');
    notificationListen();
    try {
      String? tokenFCM = await messaging.getToken();
      fcmTokens = tokenFCM;
      notificationListen();
      if (tokenFCM != null) {
        FirebaseFirestore.instance
            .collection('newUser')
            .doc(accountProvider.usermodel!.uid)
            .set({'token': tokenFCM});
        debugPrint('token tersave');
      }
      debugPrint('success save token !');
      notificationListen();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('save token failed :(');
    }
  }
}
