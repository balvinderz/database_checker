import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;
  BuildContext context;
  FirebaseNotifications(this.context);

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners();

  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {

      _firebaseMessaging.subscribeToTopic("new_posts");


    });
    _firebaseMessaging.subscribeToTopic("new_posts");

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print(message);
        print('on message $message');
        showDialog(context: context,builder: (_)=> AlertDialog(title: Text("Season-Life Admin",),
          content: Text("Check New Posts"),

        ));



      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}