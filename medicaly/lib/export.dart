import 'package:flutter/material.dart';
import 'pdf.dart';
import 'sql.dart';
import 'homePage.dart';

class Export extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExportState();
}

class _ExportState extends State<Export> {
  List<Map> response = [];
  readData() async {
    SqlDb sql = SqlDb();
    response = await sql.read('SELECT name FROM medicine');
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        decoration: Dark
            ? BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 70, 68, 68), Colors.black87],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter))
            : null,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You Can Save A PDF File With Your Current Medicines ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Dark ? Colors.white : Colors.black),
              ),
              SizedBox(height: 100),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor:
                          Dark ? Color.fromARGB(255, 77, 73, 73) : null,
                      elevation: 4),
                  onPressed: () async {
                    final pdf1 = await pdf.generateText(response);
                    print(response);
                    pdf.openFile(pdf1);
                  },
                  child: Text('Save PDF')),
            ],
          ),
        ),
      ),
    );
  }
}
