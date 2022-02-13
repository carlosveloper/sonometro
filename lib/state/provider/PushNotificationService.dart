import 'dart:async';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationService {
  static FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<RemoteMessage> mensajesStreamController =
      StreamController<RemoteMessage>.broadcast();

  static Stream<RemoteMessage> get messageStream =>
      mensajesStreamController.stream;

  static StreamController<RemoteMessage>
      mensajesOpenBackgroundStreamController =
      StreamController<RemoteMessage>.broadcast();
  static Stream<RemoteMessage> get mensajesBackgroundStream =>
      mensajesOpenBackgroundStreamController.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    print('onBackground Handler ${message.messageId}');

    /* if (!StringUtils.isNullOrEmpty(message.notification?.title,
            considerWhiteSpaceAsEmpty: true) ||
        !StringUtils.isNullOrEmpty(message.notification?.body,
            considerWhiteSpaceAsEmpty: true)) {
      print('message also contained a notification: ${message.notification}');

      String? imageUrl;
      imageUrl ??= message.notification!.android?.imageUrl;
      imageUrl ??= message.notification!.apple?.imageUrl;

      ChatRequestNotification? notify;
      if (message.data['chat'] != null) {
        notify = ChatRequestNotification.fromMap(message.data);
      }

      Map<String, dynamic> notificationAdapter = {
        NOTIFICATION_CHANNEL_KEY: 'basic_channel',
        NOTIFICATION_ID: notify != null
            ? notify.chat.requestId
            : message.messageId ?? Random().nextInt(2147483647),
        /*  NOTIFICATION_ID: message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_ID] ??
            message.messageId ??
            Random().nextInt(2147483647), */
        NOTIFICATION_TITLE: message.data[NOTIFICATION_CONTENT]
                ?[NOTIFICATION_TITLE] ??
            message.notification?.title,
        NOTIFICATION_BODY: message.data[NOTIFICATION_CONTENT]
                ?[NOTIFICATION_BODY] ??
            message.notification?.body,
        NOTIFICATION_LAYOUT:
            StringUtils.isNullOrEmpty(imageUrl) ? 'Default' : 'BigPicture',
        NOTIFICATION_BIG_PICTURE: imageUrl,
        NOTIFICATION_GROUP_KEY:
            notify != null ? notify.chat.requestId : UniqueKey().toString(),
        NOTIFICATION_GROUP_CONVERSATION:
            notify != null ? notify.chat.requestId : UniqueKey().toString(),
      };

      print('esto se envia');
      print(notificationAdapter);
      AwesomeNotifications()
          .createNotificationFromJsonData(notificationAdapter);
    } else {
      AwesomeNotifications().createNotificationFromJsonData(message.data);
    } */
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('Listen Message');
    mensajesStreamController.sink.add(message);
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print('A new onMessageOpenedApp event was published!');
    print(message.data);
    mensajesOpenBackgroundStreamController.sink.add(message);
  }

  static Future initNotifications() async {
    await requestPermission(); /* 
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().initialize(
        'resource://drawable/res_app_icon',
        [
          NotificationChannel(
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: AppColors.mainColor,
              ledColor: Colors.white),
          NotificationChannel(
              channelKey: 'badge_channel',
              channelName: 'Badge indicator notifications',
              channelDescription:
                  'Notification channel to activate badge indicator',
              channelShowBadge: true,
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.yellow),
          NotificationChannel(
              channelKey: 'ringtone_channel',
              channelName: 'Ringtone Channel',
              channelDescription: 'Channel with default ringtone',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white,
              defaultRingtoneType: DefaultRingtoneType.Ringtone),
          NotificationChannel(
              channelKey: 'updated_channel',
              channelName: 'Channel to update',
              channelDescription: 'Notifications with not updated channel',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white),
          NotificationChannel(
              channelKey: 'low_intensity',
              channelName: 'Low intensity notifications',
              channelDescription:
                  'Notification channel for notifications with low intensity',
              defaultColor: Colors.green,
              ledColor: Colors.green,
              vibrationPattern: lowVibrationPattern),
          NotificationChannel(
              channelKey: 'medium_intensity',
              channelName: 'Medium intensity notifications',
              channelDescription:
                  'Notification channel for notifications with medium intensity',
              defaultColor: Colors.yellow,
              ledColor: Colors.yellow,
              vibrationPattern: mediumVibrationPattern),
          NotificationChannel(
              channelKey: 'high_intensity',
              channelName: 'High intensity notifications',
              channelDescription:
                  'Notification channel for notifications with high intensity',
              defaultColor: Colors.red,
              ledColor: Colors.red,
              vibrationPattern: highVibrationPattern),
          NotificationChannel(
              channelKey: "private_channel",
              channelName: "Privates notification channel",
              channelDescription: "Privates notification from lock screen",
              playSound: true,
              defaultColor: Colors.red,
              ledColor: Colors.red,
              vibrationPattern: lowVibrationPattern,
              defaultPrivacy: NotificationPrivacy.Private),
          NotificationChannel(
              icon: 'resource://drawable/res_power_ranger_thunder',
              channelKey: "custom_sound",
              channelName: "Custom sound notifications",
              channelDescription: "Notifications with custom sound",
              playSound: true,
              soundSource: 'resource://raw/res_morph_power_rangers',
              defaultColor: Colors.red,
              ledColor: Colors.red,
              vibrationPattern: lowVibrationPattern),
          NotificationChannel(
              channelKey: "silenced",
              channelName: "Silenced notifications",
              channelDescription: "The most quiet notifications",
              playSound: false,
              enableVibration: false,
              enableLights: false),
          NotificationChannel(
              icon: 'resource://drawable/res_media_icon',
              channelKey: 'media_player',
              channelName: 'Media player controller',
              channelDescription: 'Media player controller',
              defaultPrivacy: NotificationPrivacy.Public,
              enableVibration: false,
              enableLights: false,
              playSound: false,
              locked: true),
          NotificationChannel(
              channelKey: 'big_picture',
              channelName: 'Big pictures',
              channelDescription: 'Notifications with big and beautiful images',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Color(0xFF9D50DD),
              vibrationPattern: lowVibrationPattern),
          NotificationChannel(
              channelKey: 'big_text',
              channelName: 'Big text notifications',
              channelDescription: 'Notifications with a expandable body text',
              defaultColor: Colors.blueGrey,
              ledColor: Colors.blueGrey,
              vibrationPattern: lowVibrationPattern),
          NotificationChannel(
              channelKey: 'inbox',
              channelName: 'Inbox notifications',
              channelDescription: 'Notifications with inbox layout',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Color(0xFF9D50DD),
              vibrationPattern: mediumVibrationPattern),
          NotificationChannel(
              channelKey: 'scheduled',
              channelName: 'Scheduled notifications',
              channelDescription: 'Notifications with schedule functionality',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Color(0xFF9D50DD),
              vibrationPattern: lowVibrationPattern,
              importance: NotificationImportance.High,
              defaultRingtoneType: DefaultRingtoneType.Alarm),
          NotificationChannel(
              icon: 'resource://drawable/res_download_icon',
              channelKey: 'progress_bar',
              channelName: 'Progress bar notifications',
              channelDescription: 'Notifications with a progress bar layout',
              defaultColor: Colors.deepPurple,
              ledColor: Colors.deepPurple,
              vibrationPattern: lowVibrationPattern,
              onlyAlertOnce: true),
          NotificationChannel(
              channelKey: 'grouped',
              channelName: 'Grouped notifications',
              channelDescription: 'Notifications with group functionality',
              groupKey: 'grouped',
              groupSort: GroupSort.Desc,
              groupAlertBehavior: GroupAlertBehavior.Children,
              defaultColor: Colors.lightGreen,
              ledColor: Colors.lightGreen,
              vibrationPattern: lowVibrationPattern,
              importance: NotificationImportance.High)
        ],
        debug: true); */

    // Push Notifications

    /*  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel   channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,

      groupId: ''
    );
     

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel); */

    await _firebaseMessaging.getToken().then((tokenFcm) {
      if (tokenFcm != null) {
        print('===== FCM Token =====');
        print(tokenFcm);
      }
    });

    _firebaseMessaging.subscribeToTopic("sonometro");

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print('getInitialMessage');
        print(message.notification.toString());
        mensajesOpenBackgroundStreamController.sink.add(message);
      }
    });
  }

  // Apple / Web
  static requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    print('User push notification status ${settings.authorizationStatus}');
  }

  static void subscribeToTopic(String topic) {
    _firebaseMessaging.subscribeToTopic(topic);
  }

  static void unsubscribeFromTopic(String topic) {
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  static void dispose() {
    mensajesStreamController.close();
    mensajesOpenBackgroundStreamController.close();
  }
}
