import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createSchedualedNotification(
    int hour, int minute, String title, int id) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: 'schedual_key',
          title: title,
          body: 'its $title Time',
          notificationLayout: NotificationLayout.BigText,
          wakeUpScreen: true,
          category: NotificationCategory.Alarm),
      actionButtons: [NotificationActionButton(key: 'Done', label: 'Taken')],
      schedule: NotificationCalendar(
          hour: hour,
          minute: minute,
          second: 0,
          millisecond: 0,
          repeats: true,
          preciseAlarm: true,
          allowWhileIdle: true));
}
