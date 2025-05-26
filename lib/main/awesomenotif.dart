// ignore_for_file: unused_element

part of '../main.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
/*   @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    actionHandling(receivedAction);
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // App.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page', (route) => (route.settings.name != '/notification-page') || route.isFirst, arguments: receivedAction);
  } */
}

initAwsApp() {
  AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(channelGroupKey: 'Mutasi', channelKey: 'basic_channel', channelName: 'Basic notifications', channelDescription: 'Notification channel for basic tests', defaultColor: const Color(0xFF9D50DD), ledColor: Colors.white, importance: NotificationImportance.High),
        NotificationChannel(channelGroupKey: 'basic_tests', channelKey: 'basic_channel', channelName: 'Basic notifications', channelDescription: 'Notification channel for basic tests', defaultColor: const Color(0xFF9D50DD), ledColor: Colors.white, importance: NotificationImportance.High),
        NotificationChannel(channelGroupKey: 'basic_tests', channelKey: 'badge_channel', channelName: 'Badge indicator notifications', channelDescription: 'Notification channel to activate badge indicator', channelShowBadge: true, defaultColor: const Color(0xFF9D50DD), ledColor: Colors.yellow),
        NotificationChannel(channelGroupKey: 'category_tests', channelKey: 'call_channel', channelName: 'Calls Channel', channelDescription: 'Channel with call ringtone', defaultColor: const Color(0xFF9D50DD), importance: NotificationImportance.Max, ledColor: Colors.white, channelShowBadge: true, locked: true, defaultRingtoneType: DefaultRingtoneType.Ringtone),
        NotificationChannel(channelGroupKey: 'category_tests', channelKey: 'alarm_channel', channelName: 'Alarms Channel', channelDescription: 'Channel with alarm ringtone', defaultColor: const Color(0xFF9D50DD), importance: NotificationImportance.Max, ledColor: Colors.white, channelShowBadge: true, locked: true, defaultRingtoneType: DefaultRingtoneType.Alarm),
        NotificationChannel(channelGroupKey: 'channel_tests', channelKey: 'updated_channel', channelName: 'Channel to update', channelDescription: 'Notifications with not updated channel', defaultColor: const Color(0xFF9D50DD), ledColor: Colors.white),
        NotificationChannel(
          channelGroupKey: 'chat_tests',
          channelKey: 'chats',
          channelName: 'Chat groups',
          channelDescription: 'This is a simple example channel of a chat group',
          channelShowBadge: true,
          importance: NotificationImportance.Max,
          ledColor: Colors.white,
          defaultColor: const Color(0xFF9D50DD),
        ),
        NotificationChannel(channelGroupKey: 'vibration_tests', channelKey: 'low_intensity', channelName: 'Low intensity notifications', channelDescription: 'Notification channel for notifications with low intensity', defaultColor: Colors.green, ledColor: Colors.green, vibrationPattern: lowVibrationPattern),
        NotificationChannel(channelGroupKey: 'vibration_tests', channelKey: 'medium_intensity', channelName: 'Medium intensity notifications', channelDescription: 'Notification channel for notifications with medium intensity', defaultColor: Colors.yellow, ledColor: Colors.yellow, vibrationPattern: mediumVibrationPattern),
        NotificationChannel(channelGroupKey: 'vibration_tests', channelKey: 'high_intensity', channelName: 'High intensity notifications', channelDescription: 'Notification channel for notifications with high intensity', defaultColor: Colors.red, ledColor: Colors.red, vibrationPattern: highVibrationPattern),
        NotificationChannel(channelGroupKey: 'privacy_tests', channelKey: "private_channel", channelName: "Privates notification channel", channelDescription: "Privates notification from lock screen", playSound: true, defaultColor: Colors.red, ledColor: Colors.red, vibrationPattern: lowVibrationPattern, defaultPrivacy: NotificationPrivacy.Private),
        NotificationChannel(channelGroupKey: 'sound_tests', icon: 'resource://drawable/res_power_ranger_thunder', channelKey: "custom_sound", channelName: "Custom sound notifications", channelDescription: "Notifications with custom sound", playSound: true, soundSource: 'resource://raw/res_morph_power_rangers', defaultColor: Colors.red, ledColor: Colors.red, vibrationPattern: lowVibrationPattern),
        NotificationChannel(channelGroupKey: 'sound_tests', channelKey: "silenced", channelName: "Silenced notifications", channelDescription: "The most quiet notifications", playSound: false, enableVibration: false, enableLights: false),
        NotificationChannel(channelGroupKey: 'media_player_tests', icon: 'resource://drawable/res_media_icon', channelKey: 'media_player', channelName: 'Media player controller', channelDescription: 'Media player controller', defaultPrivacy: NotificationPrivacy.Public, enableVibration: false, enableLights: false, playSound: false, locked: true),
        NotificationChannel(channelGroupKey: 'image_tests', channelKey: 'big_picture', channelName: 'Big pictures', channelDescription: 'Notifications with big and beautiful images', defaultColor: const Color(0xFF9D50DD), ledColor: const Color(0xFF9D50DD), vibrationPattern: lowVibrationPattern, importance: NotificationImportance.High),
        NotificationChannel(channelGroupKey: 'layout_tests', channelKey: 'big_text', channelName: 'Big text notifications', channelDescription: 'Notifications with a expandable body text', defaultColor: Colors.blueGrey, ledColor: Colors.blueGrey, vibrationPattern: lowVibrationPattern),
        NotificationChannel(channelGroupKey: 'layout_tests', channelKey: 'inbox', channelName: 'Inbox notifications', channelDescription: 'Notifications with inbox layout', defaultColor: const Color(0xFF9D50DD), ledColor: const Color(0xFF9D50DD), vibrationPattern: mediumVibrationPattern),
        NotificationChannel(
          channelGroupKey: 'schedule_tests',
          channelKey: 'scheduled',
          channelName: 'Scheduled notifications',
          channelDescription: 'Notifications with schedule functionality',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: const Color(0xFF9D50DD),
          vibrationPattern: lowVibrationPattern,
          importance: NotificationImportance.High,
          defaultRingtoneType: DefaultRingtoneType.Alarm,
          criticalAlerts: true,
        ),
        NotificationChannel(channelGroupKey: 'layout_tests', icon: 'resource://drawable/res_download_icon', channelKey: 'progress_bar', channelName: 'Progress bar notifications', channelDescription: 'Notifications with a progress bar layout', defaultColor: Colors.deepPurple, ledColor: Colors.deepPurple, vibrationPattern: lowVibrationPattern, onlyAlertOnce: true),
        NotificationChannel(channelGroupKey: 'grouping_tests', channelKey: 'grouped', channelName: 'Grouped notifications', channelDescription: 'Notifications with group functionality', groupKey: 'grouped', groupSort: GroupSort.Desc, groupAlertBehavior: GroupAlertBehavior.Children, defaultColor: Colors.lightGreen, ledColor: Colors.lightGreen, vibrationPattern: lowVibrationPattern, importance: NotificationImportance.High)
      ],
      channelGroups: [
        NotificationChannelGroup(channelGroupKey: 'Mutasi', channelGroupName: 'Basic tests'),
        NotificationChannelGroup(channelGroupKey: 'category_tests', channelGroupName: 'Category tests'),
        NotificationChannelGroup(channelGroupKey: 'image_tests', channelGroupName: 'Images tests'),
        NotificationChannelGroup(channelGroupKey: 'schedule_tests', channelGroupName: 'Schedule tests'),
        NotificationChannelGroup(channelGroupKey: 'chat_tests', channelGroupName: 'Chat tests'),
        NotificationChannelGroup(channelGroupKey: 'channel_tests', channelGroupName: 'Channel tests'),
        NotificationChannelGroup(channelGroupKey: 'sound_tests', channelGroupName: 'Sound tests'),
        NotificationChannelGroup(channelGroupKey: 'vibration_tests', channelGroupName: 'Vibration tests'),
        NotificationChannelGroup(channelGroupKey: 'privacy_tests', channelGroupName: 'Privacy tests'),
        NotificationChannelGroup(channelGroupKey: 'layout_tests', channelGroupName: 'Layout tests'),
        NotificationChannelGroup(channelGroupKey: 'grouping_tests', channelGroupName: 'Grouping tests'),
        NotificationChannelGroup(channelGroupKey: 'media_player_tests', channelGroupName: 'Media Player tests')
      ],
      debug: false);

  /*  AwesomeNotifications().actionStream.listen((receivedAction) {
    dp("actionStream.listen");
    _actionHandling(receivedAction);
  }); */
  /*
 AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );
    */
  /*  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
  ); */
}

/* 
_initAws() {
  MediaPlayerCentral.addAll([
    MediaModel(diskImagePath: 'asset://assets/images/rock-disc.jpg', colorCaptureSize: const Size(788, 800), bandName: 'Bright Sharp', trackName: 'Champagne Supernova', trackSize: const Duration(minutes: 4, seconds: 21)),
    MediaModel(diskImagePath: 'asset://assets/images/classic-disc.jpg', colorCaptureSize: const Size(500, 500), bandName: 'Best of Mozart', trackName: 'Allegro', trackSize: const Duration(minutes: 7, seconds: 41)),
    MediaModel(diskImagePath: 'asset://assets/images/remix-disc.jpg', colorCaptureSize: const Size(500, 500), bandName: 'Dj Allucard', trackName: '21st Century', trackSize: const Duration(minutes: 4, seconds: 59)),
    MediaModel(diskImagePath: 'asset://assets/images/dj-disc.jpg', colorCaptureSize: const Size(500, 500), bandName: 'Dj Brainiak', trackName: 'Speed of light', trackSize: const Duration(minutes: 4, seconds: 59)),
    MediaModel(diskImagePath: 'asset://assets/images/80s-disc.jpg', colorCaptureSize: const Size(500, 500), bandName: 'Back to the 80\'s', trackName: 'Disco revenge', trackSize: const Duration(minutes: 4, seconds: 59)),
    MediaModel(diskImagePath: 'asset://assets/images/old-disc.jpg', colorCaptureSize: const Size(500, 500), bandName: 'PeacefulMind', trackName: 'Never look at back', trackSize: const Duration(minutes: 4, seconds: 59)),
  ]);
}
 */
void loadSingletonPage({required String targetPage, required ReceivedAction receivedAction}) {
  // Avoid to open the notification details page over another details page already opened
  Get.toNamed(targetPage, arguments: receivedAction);
  /* Navigator.pushNamedAndRemoveUntil(
    App.navigatorKey.currentContext!,
    targetPage,
    (route) => (route.settings.name != targetPage) || route.isFirst,
    arguments: receivedAction,
  ); */
}

void processInputTextReceived(ReceivedAction receivedAction) {
  if (receivedAction.channelKey == 'chats') {
    NotificationUtils.simulateSendResponseChatConversation(msg: receivedAction.buttonKeyInput, groupKey: 'jhonny_group');
  }

  sleep(const Duration(seconds: 2)); // To give time to show
  Get.snackbar('Pemberitahuan', 'Msg: ${receivedAction.buttonKeyInput}', colorText: Colors.white);
}

void processMediaControls(actionReceived) {
  switch (actionReceived.buttonKeyPressed) {
    case 'MEDIA_CLOSE':
      MediaPlayerCentral.stop();
      break;

    case 'MEDIA_PLAY':
    case 'MEDIA_PAUSE':
      MediaPlayerCentral.playPause();
      break;

    case 'MEDIA_PREV':
      MediaPlayerCentral.previousMedia();
      break;

    case 'MEDIA_NEXT':
      MediaPlayerCentral.nextMedia();
      break;

    default:
      break;
  }

  Get.snackbar('Pemberitahuan', "Media: ${actionReceived.buttonKeyPressed.replaceFirst('MEDIA_', '')}", colorText: Colors.white);
}
