import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:miapp/model/chat_request_notification.dart';
import 'package:miapp/presentation/profile/profile.dart';
import 'package:miapp/presentation/sonometro/sonometro.dart';
import 'package:miapp/state/provider/PushNotificationService.dart';

class HomeProvider extends ChangeNotifier {
  int pagePresent = 0;
  bool _mounted = true;
  bool get mounted => _mounted;

  List<String> listNamePage = ['Home', 'Historial Búsqueda', 'Perfil'];

  List<Widget> listPage = [SonoMetroPage(), MenuProfile()];
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void _setState() {
    if (!mounted) return;
    notifyListeners();
  }

  void changeSelect(int selectPage) {
    pagePresent = selectPage;
    validPersistenPage();
    _setState();
  }

  void validPersistenPage() {
    // if it hasn't, then it still is a SizedBox
    /* if (listPage[pagePresent] is SizedBox) {
      if (pagePresent == 1) {
        listPage[pagePresent] = const MenuProfile();
      }
    } */

    /*   if (index == 0) {

      setState(() {

        screens.removeAt(0);

        screens.insert(0, new HomePage(key: UniqueKey()));

        tabIndex = index;
      });
    } */
  }

  @override
  void dispose() {
    _mounted = false;
    PushNotificationService.dispose();

    super.dispose();
  }

  void initNotificacion() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = const IOSInitializationSettings();
    var initSetttings = InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    PushNotificationService.initNotifications();
    PushNotificationService.messageStream.listen((event) {
      showNotification(event);
    });
  }

  Future onSelectNotification(String? payload) async {
    print('imprimo la accion');
    final Map<String, dynamic> decodedMap = json.decode(payload!);
    if (decodedMap['chat'] != null) {
      RemoteMessage event = RemoteMessage(data: decodedMap);
      PushNotificationService.mensajesOpenBackgroundStreamController.sink
          .add(event);
    }
  }

  void showNotification(RemoteMessage message) async {
    String chatRequest = '{"key1": 1}';
    ChatRequestNotification? notify;
    /*  if (message.data['chat'] != null) {
      notify = ChatRequestNotification.fromMap(message.data);
      chatRequest = notify.toJson();
    } */
    var android = AndroidNotificationDetails(
        'channel_idPydenos', 'channel_name_pydenos',
        groupKey:
            notify != null ? notify.chat.requestId : UniqueKey().toString(),
        priority: Priority.high,
        importance: Importance.max);

    var iOS = const IOSNotificationDetails();
    var platform = NotificationDetails(
      android: android,
      iOS: iOS,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platform,
      payload: chatRequest,
    );
  }
}
