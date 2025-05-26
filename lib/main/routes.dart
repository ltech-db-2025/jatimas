// ignore_for_file: constant_identifier_names

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:ljm/main/notification/notification_details_page.dart';

const String PAGE_HOME = '/';
const String PAGE_LOGIN = '/login';
const String PAGE_MEDIA_DETAILS = '/media-details';
const String PAGE_NOTIFICATION_DETAILS = '/notification-details';
const String PAGE_FIREBASE_TESTS = '/firebase-tests';
const String PAGE_PHONE_CALL = '/phone-call';
const String PAGE_MUTASI = '/mutasi';

Map<String, WidgetBuilder> materialRoutes = {
  // PAGE_MUTASI: (context) => VerifikasiMutasiPage(receivedNotification: ModalRoute.of(context)!.settings.arguments as ReceivedNotification),
  PAGE_NOTIFICATION_DETAILS: (context) => NotificationDetailsPage(
        ModalRoute.of(context)!.settings.arguments as ReceivedNotification,
      ),
};
