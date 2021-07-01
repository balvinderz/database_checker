import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;
  BuildContext context;
  FirebaseNotifications(this.context);

  Future<void> setUpFirebase() async {
    await Firebase.initializeApp();

    _firebaseMessaging = FirebaseMessaging.instance;
    firebaseCloudMessaging_Listeners();

  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {

      _firebaseMessaging.subscribeToTopic("new_posts");


    });
    _firebaseMessaging.subscribeToTopic("new_posts");
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      showDialog(context: context,builder: (_)=> AlertDialog(title: Text("Season-Life Admin",),
        content: Text("Check New Posts"),

      ));
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {

    });

  }

  void iOS_Permission() {
    _firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);

  }
}