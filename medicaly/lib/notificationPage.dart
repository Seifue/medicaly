import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'sql.dart';

class notificationPage extends StatelessWidget {
  SqlDb sql = SqlDb();
  int notificationMedicineid = 0;
  notificationPage(this.notificationMedicineid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: ElevatedButton(
                onPressed: () async {
                  await sql.update(
                      'UPDATE medicine SET quantity = quantity-dose WHERE id = "${notificationMedicineid}"');
                  List<Map> row = await sql.read(
                      'SELECT * FROM medicine WHERE id = "${notificationMedicineid}"');
                  if (row[0]['quantity'] <= row[0]['refill']) {
                    AwesomeNotifications().createNotification(
                        content: NotificationContent(
                            id: 1,
                            channelKey: "basic key",
                            title: "Quantity Getting low",
                            body:
                                "Your Medicine ${row[0]['name']} has Low Quantity Please Refill",
                            notificationLayout: NotificationLayout.BigText,
                            category: NotificationCategory.Message,
                            fullScreenIntent: true));
                  }
                  Navigator.pop(context);
                },
                child: Text('Taken'))),
      ),
    );
  }
}
