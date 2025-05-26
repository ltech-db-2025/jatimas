part of '../main.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
// late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.

// final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
final Connectivity connectivity = Connectivity();
StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;
// final scaffoldState = GlobalKey<ScaffoldState>();
bool isFlutterLocalNotificationsInitialized = false;

// FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
final BehaviorSubject<String?> selectNotificationSubject = BehaviorSubject<String?>();
const MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;
// bool _notificationsEnabled = false;

Map<NotificationPermission, bool> scheduleChannelPermissions = {};
Map<NotificationPermission, bool> dangerousPermissionsStatus = {};

List<NotificationPermission> channelPermissions = [NotificationPermission.Alert, NotificationPermission.Sound, NotificationPermission.Badge, NotificationPermission.Light, NotificationPermission.Vibration, NotificationPermission.CriticalAlert, NotificationPermission.FullScreenIntent];

List<NotificationPermission> dangerousPermissions = [
  NotificationPermission.CriticalAlert,
  NotificationPermission.OverrideDnD,
  NotificationPermission.PreciseAlarms,
];

String packageName = 'com.luckyjayamotorindo.sparepart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class MiddleWare {
  static observer(Routing routing) {
    /// You can listen in addition to the routes, the snackbars, dialogs and bottomsheets on each screen.
    ///If you need to enter any of these 3 events directly here,
    ///you must specify that the event is != Than you are trying to do.
/*     if (routing.current == '/second' && !routing.isSnackbar) {
      Get.snackbar("Hi", "You are on second route");
    } else if (routing.current =='/third'){
      dp('last route called');
    } */
  }
}
