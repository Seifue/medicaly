import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicaly/widgets.dart';
import 'homePage.dart';
import 'notification.dart';
import 'sql.dart';

class addMedicinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _addMedicinePageState();
}

int freqNumber = 0;

class _addMedicinePageState extends State<addMedicinePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController freqController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController doseController = TextEditingController();
  TextEditingController refillController = TextEditingController();
  TextEditingController timesController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  String timeString = '';
  String timeString2 = '';
  List<String> freqList = ['1', '2'];
  List<String> type = ['pill', 'syrup', 'injection', 'drop'];
  SqlDb sqldb = SqlDb();
  bool pill = false;
  int Pill = 0;
  String typeVal = 'select';
  List<Map>? notes;
  List<String> matchingMedicine = [];

  _selectTime(BuildContext context, String t) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        timeString =
            selectedTime.hour.toString() + ':' + selectedTime.minute.toString();
      });
    }
  }

  _selectTime2(BuildContext context, String t) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        timeString2 =
            selectedTime.hour.toString() + ':' + selectedTime.minute.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // initState() async {
    //   List<Map> response = await sqldb.read('SELECT * FROM notes');

    //   notes = response;

    //   print("notes");
    //   super.initState();
    // }
    read() async {
      List<Map> response = await sqldb.read('SELECT * FROM notes');

      notes = response;
      print(notes);
    }

    SqlDb sql = SqlDb();
    Future<List<Map>> readData() async {
      List<Map> response = await sql.read('SELECT * FROM medicine');
      setState(() {
        medList = response;
      });
      return response;
    }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Dark == true
            ? Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                Color.fromARGB(255, 70, 68, 68),
                Colors.black87
              ])))
            : null,
        elevation: 6,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Add Your Medicine',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white70),
            ),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: Dark == true
            ? BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 70, 68, 68), Colors.black87],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter))
            : null,
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      label: Text('Medicine Name',
                          style: TextStyle(color: Colors.grey, fontSize: 24)),
                      hintText: 'Enter Medicine Name',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                    onChanged: (value) {
                      setState(() {
                        matchingMedicine = [];
                      });
                      read();
                      if (notes != null) {
                        for (int note = 0; note < notes!.length; note++) {
                          if (notes![note]['medicine'] == value) {
                            setState(() {
                              matchingMedicine.add(notes![note]['note']);
                            });
                          } else if (notes![note]['medicine'] != value) {
                            continue;
                          }
                        }
                      }

                      print(matchingMedicine);
                    },
                  ),
                ),
                matchingMedicine != []
                    ? Center(
                        child: Column(
                        children: [
                          Text(
                            'Your Previous notes form the same Medicine (If Had):',
                            style: TextStyle(color: Colors.grey),
                          ),
                          for (var i in matchingMedicine)
                            Text(
                              i,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                              textAlign: TextAlign.start,
                            ),
                        ],
                      ))
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Text(
                        'Frequancy',
                        style: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: DropdownButton(
                          dropdownColor: Dark
                              ? Color.fromARGB(255, 77, 73, 73)
                              : Colors.white,
                          style: TextStyle(
                              color: Dark ? Colors.white : Colors.black),
                          iconSize: 15,
                          value: freqNumber >= 1 ? freqNumber.toString() : null,
                          items: freqList.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              freqNumber = int.parse(value!);
                              freqController.text = value;
                            });
                          }),
                      // child: TextField(
                      //   controller: freqController,
                      //   keyboardType: TextInputType.number,
                      //   decoration: const InputDecoration(
                      //     enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(width: 2, color: Colors.grey),
                      //         borderRadius: BorderRadius.all(Radius.circular(20))),
                      //     label: Text('Frequancy',
                      //         style: TextStyle(color: Colors.grey, fontSize: 24)),
                      //     hintText: 'Enter Medicine Frequancy',
                      //     hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                      //   ),
                      //   style: const TextStyle(color: Colors.grey, fontSize: 15),
                      //   onChanged: (value) {
                      //     if (value.isNotEmpty) {
                      //       if (int.parse(value) == 2) {
                      //         setState(() {
                      //           freqNumber = 2;
                      //         });
                      //       }
                      //     }
                      //     if (value.isEmpty) {
                      //       setState(() {
                      //         freqNumber = 0;
                      //       });
                      //     }
                      //   },
                      // ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: TextField(
                    controller: doseController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      label: Text('Dose',
                          style: TextStyle(color: Colors.grey, fontSize: 24)),
                      hintText: 'Enter Medicine Dose you will take',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: TextField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      label: Text('Quantity',
                          style: TextStyle(color: Colors.grey, fontSize: 24)),
                      hintText: 'Enter Medicine Quantity You Have',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: TextField(
                    controller: refillController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      label: Text('When To Refill ?',
                          style: TextStyle(color: Colors.grey, fontSize: 24)),
                      hintText: 'Remind To Refill When Quantity Becoms',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: TextField(
                    controller: noteController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      label: Text('Note',
                          style: TextStyle(color: Colors.grey, fontSize: 24)),
                      hintText: 'Enter MEdicine Notes',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Pick Your Medicine Type',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    DropdownButton(
                        style: TextStyle(
                            color: Dark ? Colors.white : Colors.black),
                        dropdownColor:
                            Dark ? Color.fromARGB(255, 77, 73, 73) : null,
                        items: type.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value == null) {}
                          print(value);
                          switch (value) {
                            case 'pill':
                              {
                                setState(() {
                                  Pill = 1;
                                });
                              }
                              break;

                            case 'syrup':
                              {
                                setState(() {
                                  Pill = 2;
                                });
                              }
                              break;

                            case 'injection':
                              {
                                setState(() {
                                  Pill = 3;
                                });
                              }
                              break;
                            case 'drop':
                              {
                                setState(() {
                                  Pill = 4;
                                });
                              }
                              break;
                          }
                          print(Pill);
                        })
                    // Text('Pill',
                    //     style: TextStyle(
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.grey)),
                    // Switch(
                    //     value: pill,
                    //     onChanged: (value) {
                    //       setState(() {
                    //         pill = value;
                    //         Pill = pill ? 1 : 0;
                    //       });
                    //     }),
                    // Text('Syrup',
                    //     style: TextStyle(
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.grey))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Pick Midecine Time',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _selectTime(context, timeString);
                        },
                        child: const Icon(Icons.punch_clock_rounded))
                  ],
                ),
                (freqNumber == 2)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'The Second One',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                _selectTime2(context, timeString2);
                              },
                              child: const Icon(Icons.punch_clock_rounded))
                        ],
                      )
                    : Row(),

                //Text(timeString),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    child: Text('Add Medicine'),
                    onPressed: () async {
                      if (nameController.text.isNotEmpty &&
                          freqController.text.isNotEmpty &&
                          quantityController.text.isNotEmpty &&
                          noteController.text.isNotEmpty &&
                          timeString != '' &&
                          timeString2 != '' &&
                          doseController.text.isNotEmpty &&
                          refillController.text.isNotEmpty &&
                          freqNumber == 2) {
                        int r = await sqldb.insert(
                            'INSERT INTO medicine (name,frequancy,time,timet,note,quantity,type,dose,refill) VALUES ("${nameController.text}","${int.parse(freqController.text)}","$timeString","$timeString2","${noteController.text}","${quantityController.text}","$Pill","${doseController.text}","${refillController.text}")');
                        await sqldb.insert(
                            'INSERT INTO notes (medicine,note) VALUES ("${nameController.text}","${noteController.text}")');

                        print('=============================');
                        print(r);

                        createSchedualedNotification(
                            int.parse(timeString.split(':')[0]),
                            int.parse(timeString.split(':')[1]),
                            nameController.text,
                            r);

                        createSchedualedNotification(
                            int.parse(timeString2.split(':')[0]),
                            int.parse(timeString2.split(':')[1]),
                            nameController.text,
                            r + 100);

                        Navigator.of(context).pushReplacementNamed('/home');
                      } else if (nameController.text.isNotEmpty &&
                          freqController.text.isNotEmpty &&
                          quantityController.text.isNotEmpty &&
                          noteController.text.isNotEmpty &&
                          timeString != '' &&
                          doseController.text.isNotEmpty &&
                          refillController.text.isNotEmpty &&
                          freqNumber != 2) {
                        int r = await sqldb.insert(
                            'INSERT INTO medicine (name,frequancy,time,timet,note,quantity,type,dose,refill) VALUES ("${nameController.text}","${int.parse(freqController.text)}","$timeString","0","${noteController.text}","${quantityController.text}","$Pill","${doseController.text}","${refillController.text}")');
                        await sqldb.insert(
                            'INSERT INTO notes (medicine,note) VALUES ("${nameController.text}","${noteController.text}")');

                        print('=============================');
                        print(r);

                        createSchedualedNotification(
                            int.parse(timeString.split(':')[0]),
                            int.parse(timeString.split(':')[1]),
                            nameController.text,
                            r);
                        Navigator.of(context).pushReplacementNamed('/home');
                      } else {
                        final snackbar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text('Please Fill all Fields'),
                          margin: EdgeInsets.all(10),
                          duration: Duration(seconds: 3),
                          backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
