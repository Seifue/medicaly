import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';
import 'homePage.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';

class textR_Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _textR_PageState();
}

class _textR_PageState extends State {
  final ImagePicker _picker = ImagePicker();
  String? myText;
  File? pickedImage;
  getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      pickedImage = File(image.path);
    });
  }

  Future<String?> recognizeText(InputImage image) async {
    try {
      TextRecognizer recoginzer = TextRecognizer();
      RecognizedText recognizedText = await recoginzer.processImage(image);
      recoginzer.close();
      return recognizedText.text;
    } catch (error) {
      return null;
    }
    ;
  }

  Future<String?> translateText(String text) async {
    final langident = LanguageIdentifier(confidenceThreshold: 0.5);
    final langCode = await langident.identifyLanguage(text);
    langident.close();
    final translator = OnDeviceTranslator(
        sourceLanguage: TranslateLanguage.values
            .firstWhere((element) => element.bcpCode == langCode),
        targetLanguage: TranslateLanguage.arabic);
    final response = await translator.translateText(text);
    translator.close();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: myText != null
          ? FloatingActionButton(
              backgroundColor: Dark ? Color.fromARGB(255, 77, 73, 73) : null,
              child: Icon(Icons.translate_rounded),
              onPressed: () async {
                final translatedT = await translateText(myText!);
                setState(() {
                  myText = translatedT;
                });
                print(myText);
              })
          : null,
      // appBar: AppBar(
      //   flexibleSpace: Dark == true
      //       ? Container(
      //           decoration: const BoxDecoration(
      //               gradient: LinearGradient(colors: [
      //           Color.fromARGB(255, 70, 68, 68),
      //           Colors.black87
      //         ])))
      //       : null,
      //   elevation: 6,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Text(
      //         'Recognizer',
      //         style: TextStyle(
      //             fontSize: 28,
      //             fontWeight: FontWeight.w900,
      //             color: Colors.white70),
      //       ),
      //     ],
      //   ),
      // ),
      body: Container(
        decoration: Dark == true
            ? BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 70, 68, 68), Colors.black87],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter))
            : null,
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor:
                                Dark ? Color.fromARGB(255, 77, 73, 73) : null,
                            elevation: 4),
                        child: Text('Take Image'),
                        onPressed: () async {
                          getImage();
                        },
                      ),
                      pickedImage != null
                          ? Image.file(
                              pickedImage!,
                              width: 100,
                              height: 100,
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Please Take Image',
                                    style: TextStyle(
                                        color:
                                            Dark ? Colors.white : Colors.black),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor:
                                Dark ? Color.fromARGB(255, 77, 73, 73) : null,
                            elevation: 4),
                        onPressed: () async {
                          String? Text_After_Recog = await recognizeText(
                              InputImage.fromFile(File(pickedImage!.path)));
                          setState(() {
                            myText = Text_After_Recog;
                          });
                        },
                        child: Text('Generate text'))
                  ],
                )
              ],
            ),
            myText != null
                ? Container(
                    width: 400,
                    color: Colors.black12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            myText!,
                            style: TextStyle(
                                fontSize: 30,
                                color: Dark ? Colors.grey : Colors.black),
                          ),
                        )
                      ],
                    ),
                  )
                : Row()
          ],
        ),
      ),
    );
  }
}
