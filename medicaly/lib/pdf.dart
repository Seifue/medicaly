import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';

class pdf {
  static Future<File> generateText(List<Map> response) async {
    Document pdf = Document();
    pdf.addPage(Page(build: (context) {
      return Container(
          child: Column(children: [
        Header(
            child: Text('Medicaly', style: TextStyle(fontSize: 15)),
            outlineStyle: PdfOutlineStyle.italicBold),
        for (int i = 0; i < response.length; i++)
          Bullet(
              text: response[i]['name'],
              padding: EdgeInsets.all(3),
              margin: EdgeInsets.all(6))
      ]));
    }));

    return save(name: 'medicines.pdf', pdf: pdf);
  }

  static Future<File> save(
      {required String name, required Document pdf}) async {
    final byte = await pdf.save();

    Directory dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$name');
    print(dir.path);
    await file.writeAsBytes(byte);
    return file;
  }

  static Future openFile(File file) async {
    String path = file.path;
    await OpenFilex.open(path);
  }
}
