import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';
import 'sql.dart';
import 'addMedicinPage.dart';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';

TextEditingController Quantity = TextEditingController();
Widget Card1(
    String MedicineName,
    String Time,
    String Timet,
    int frequancy,
    int type,
    int quantity,
    BuildContext ctx,
    SqlDb sql,
    int rowId,
    Function read,
    String note,
    String dose,
    String refill) {
  return Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
    height: 170,
    child: Card(
      child: Container(
        decoration: Dark
            ? BoxDecoration(
                boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 82, 80, 80),
                        blurRadius: 7,
                        offset: Offset(4, 5))
                  ],
                color: Colors.grey,
                gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 70, 68, 68), Colors.black87],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight))
            : BoxDecoration(
                gradient: LinearGradient(colors: [
                Color.fromARGB(255, 87, 135, 238),
                Color.fromARGB(221, 89, 133, 194)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent)),
                          onPressed: () {
                            Flushbar(
                              backgroundGradient: Dark
                                  ? LinearGradient(colors: [
                                      Color.fromARGB(255, 70, 68, 68),
                                      Colors.black87
                                    ])
                                  : LinearGradient(
                                      colors: [
                                          Color.fromARGB(255, 87, 135, 238),
                                          Color.fromARGB(221, 89, 133, 194)
                                        ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                              flushbarPosition: FlushbarPosition.TOP,
                              duration: Duration(seconds: 4),
                              title: MedicineName,
                              titleSize: 25,
                              message: "Remember To Take it on Time",
                            )..show(ctx);
                          },
                          child: Text(
                            MedicineName.length > 10
                                ? MedicineName.substring(0, 7) + '...'
                                : MedicineName,
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Container(
                        child: type == 1
                            ? Image.asset(
                                'assets/images/pill.png',
                                height: 30,
                                width: 20,
                                color: Dark ? Colors.white : Colors.black,
                              )
                            : type == 2
                                ? Image.asset(
                                    'assets/images/syrup.png',
                                    height: 20,
                                    width: 20,
                                    color: Dark ? Colors.white : Colors.black,
                                  )
                                : type == 3
                                    ? Image.asset(
                                        'assets/images/injection.png',
                                        height: 20,
                                        width: 20,
                                        color:
                                            Dark ? Colors.white : Colors.black,
                                      )
                                    : Image.asset(
                                        'assets/images/drop.png',
                                        height: 20,
                                        width: 20,
                                        color:
                                            Dark ? Colors.white : Colors.black,
                                      ),
                      )
                    ],
                  ),
                  SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          int.parse(Time.split(':')[0]) > 12
                              ? (int.parse(Time.split(':')[0]) - 12)
                                      .toString() +
                                  ':' +
                                  Time.split(':')[1]
                              : Time,
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 3),
                  frequancy == 2
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(
                                int.parse(Timet.split(':')[0]) > 12
                                    ? (int.parse(Timet.split(':')[0]) - 12)
                                            .toString() +
                                        ':' +
                                        Timet.split(':')[1]
                                    : Timet,
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            )
                          ],
                        )
                      : Row(),
                ],
              ),
              SizedBox(width: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          frequancy.toString(),
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                      Text('frequancy', style: TextStyle(color: Colors.white))
                    ],
                  ),
                  SizedBox(height: 45),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 38,
                        margin: EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: 40,
                          child: TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent)),
                            onPressed: () {
                              showDialog(
                                context: ctx,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: Text(
                                        'Update The Quantity of The Medicine'),
                                    content: TextField(
                                      controller: Quantity,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                    actions: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            TextButton(
                                                onPressed: () async {
                                                  await sql.update(
                                                      'UPDATE medicine SET quantity=${Quantity.text} WHERE id = ${rowId}');

                                                  Navigator.pop(ctx);
                                                  read();
                                                },
                                                child: Text('Update')),
                                          ])
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              quantity.toString(),
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Text(type == 1 ? 'quantity' : 'ml',
                          style: TextStyle(color: Colors.white)),
                    ],
                  )
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: ctx,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text('Are You Sure?'),
                                      ]),
                                  content: Container(
                                      child: Text(
                                          'Are You Sure You Want To Delete Medicine?')),
                                  actions: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                await AwesomeNotifications()
                                                    .cancel(rowId);
                                                for (int i = 0;
                                                    i < medList.length;
                                                    i++) {
                                                  if (medList[i]['frequancy'] ==
                                                      2) {
                                                    await AwesomeNotifications()
                                                        .cancel(rowId + 100);
                                                  }
                                                }
                                                await sql.delete(
                                                    'DELETE FROM medicine WHERE id = $rowId');
                                                for (int i = 0;
                                                    i < medList.length;
                                                    i++) {
                                                  medList.removeWhere(
                                                      (element) =>
                                                          element['id'] ==
                                                          medList[i]
                                                              ['${rowId}']);
                                                }
                                                Navigator.pop(ctx);
                                                read();
                                              },
                                              child: Text('Yes')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Text('No'))
                                        ])
                                  ],
                                );
                              });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.transparent)),
                        onPressed: () {
                          Flushbar(
                            backgroundGradient: Dark
                                ? LinearGradient(colors: [
                                    Color.fromARGB(255, 70, 68, 68),
                                    Colors.black87
                                  ])
                                : LinearGradient(
                                    colors: [
                                        Color.fromARGB(255, 87, 135, 238),
                                        Color.fromARGB(221, 89, 133, 194)
                                      ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                            flushbarPosition: FlushbarPosition.TOP,
                            title: "Other Info",
                            titleSize: 15,
                            messageSize: 25,
                            message:
                                "Note : $note\n\nDose : $dose\n\nWhen To Refill : $refill",
                          )..show(ctx);
                        },
                        child: Text(
                          'more..',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
