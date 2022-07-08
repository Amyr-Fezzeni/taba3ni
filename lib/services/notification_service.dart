import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  // static late AndroidNotificationChannel channel;
  // static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // static String? token = " ";

  // static Future<bool> sendPushNotifications(
  //     {required String title,
  //     required String body,
  //     required String token}) async {
  //   const postUrl = 'https://fcm.googleapis.com/fcm/send';
  //   final data = {
  //     "to": token,
  //     "notification": {
  //       "title": title,
  //       "body": body,
  //     },
  //     "data": {
  //       "type": '0rder',
  //       "id": '28',
  //       "click_action": 'FLUTTER_NOTIFICATION_CLICK',
  //     }
  //   };

  //   final headers = {
  //     'content-type': 'application/json',
  //     'Authorization':
  //         'key=AAAA0_8EulU:APA91bFLWm2-MvB19o_vPRzYIRinXCa0QAmJKIo0ofGOsTInvckFMsJXR9gAFy8HA3ytn-0VcDGIMQHCwNFijSW49OdwMVYoFhbC1LuzCkSibawMIq0SUPrUDNHHV1U3hrf6gPA7_m07' // 'key=YOUR_SERVER_KEY'
  //   };

  //   final response = await http.post(Uri.parse(postUrl),
  //       body: json.encode(data),
  //       encoding: Encoding.getByName('utf-8'),
  //       headers: headers);

  //   if (response.statusCode == 200) {
  //     // on success do sth
  //     log('test ok push CFM');
  //     return true;
  //   } else {
  //     log(' CFM error');
  //     // on failure do sth
  //     return false;
  //   }
  // }

  static Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

//   static void requestPermission() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;

//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       log('User granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       log('User granted provisional permission');
//     } else {
//       log('User declined or has not accepted permission');
//     }
//   }

//   static void listenFCM() async {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       log("fcm here");
//       log(message.toMap().toString());
//       Notif notif = Notif(
//           createdAt: message.sentTime,
//           content: message.data,
//           id: message.messageId,
//           notificationType: null,
//           seen: false,
//           to: message.data['user'].toString());
//       saveNotification(notif);
//       log(notif.toString());
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null && !kIsWeb) {
//         flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               icon: 'launch_background',
//             ),
//           ),
//         );
//       }
//     });
//   }

//   static void loadFCM() async {
//     if (!kIsWeb) {
//       channel = const AndroidNotificationChannel(
//         'high_importance_channel', // id
//         'High Importance Notifications', // title
//         importance: Importance.high,
//         enableVibration: true,
//       );

//       flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(channel);
//       await FirebaseMessaging.instance
//           .setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//     }
//   }

//   static Future<void> createNotification(
//       {required String title, required String body, String? img}) async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: createUniqueId(),
//         channelKey: 'basic_channel',
//         title: title,
//         body: body,
//         bigPicture: img, //'asset://assets/notification_map.png',
//         notificationLayout: NotificationLayout.BigPicture,
//       ),
//     );
//   }

//   static Future<void> firebaseMessagingBackgroundHandler(
//       RemoteMessage remoteMessage) async {
//     debugPrint('Background message fel main ${remoteMessage.messageId}');
//     createNotification(
//         title: remoteMessage.notification!.title ?? "Sounsoun",
//         body: remoteMessage.notification!.body ?? "",
//         img: remoteMessage.notification?.android?.imageUrl);

//     //pushNotif(remoteMessage);
//   }

//   static Future<Uint8List> _getByteArrayFromUrl(String url) async {
//     final http.Response response = await http.get(Uri.parse(url));
//     return response.bodyBytes;
//   }

//   static StreamSubscription<RemoteMessage>? notifSub;
//   static StreamSubscription<RemoteMessage>? notifSubOnOpenApp;

//   static cancelNotifSub() {
//     if (notifSub != null) {
//       notifSub!.cancel();
//     }
//     if (notifSubOnOpenApp != null) notifSubOnOpenApp!.cancel();
//   }

//   static void initialize() async {
//     // for ios and web
//     FirebaseMessaging.instance.requestPermission();

//     FirebaseMessaging.onBackgroundMessage((remoteMessage) {
//       return Future.value();
//     });
//     sub();
//   }

//   static void sub() {
//     notifSub =
//         FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
//       createNotification(
//           title: remoteMessage.notification!.title ?? "Sounsoun",
//           body: remoteMessage.notification!.body ?? "",
//           img: remoteMessage.notification?.android?.imageUrl);
//     });

//     FirebaseMessaging.instance.getInitialMessage().then((remoteMessage) async {
//       return null;
//     });

//     notifSubOnOpenApp = FirebaseMessaging.onMessageOpenedApp
//         .listen((RemoteMessage remoteMessage) async {
//       onclikNotifications(remoteMessage);
//     });
//   }

//   static void onclikNotifications(remoteMessage) async {
//     log("clicked ${remoteMessage.toMap().toString()}");
//   }

//   static Future<String> saveNotification(Notif notif) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('notifications')
//           .doc(notif.id)
//           .set(notif.toMap())
//           .whenComplete(() => log(notif.toString()));
//     } on Exception catch (e) {
//       return "Un erreur est survenue $e";
//     }
//     return "true";
//   }

//   static Future<String> deleteNotification(Notif notif) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('notifications')
//           .doc(notif.id)
//           .delete();
//     } on Exception catch (e) {
//       return "Un erreur est survenue $e";
//     }
//     return "true";
//   }

//   static Stream<QuerySnapshot<Map<String, dynamic>>> getAllNotification(
//       String id) {
//     return FirebaseFirestore.instance
//         .collection("notifications")
//         .where("to", isEqualTo: id)
//         .snapshots();
//   }
 }
