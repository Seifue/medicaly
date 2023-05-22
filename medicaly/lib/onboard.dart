import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class onboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Medicaly',
          body:
              'Use Medicaly to Track your Medicines,Dose and Re-Purchase when you need, Write notes for each medicine to remember what you want at medicines time ',
          image: Image.asset('assets/images/medicines.png'),
          decoration: PageDecoration(
            imagePadding: EdgeInsets.all(24),
            bodyPadding: EdgeInsets.all(24),
            imageAlignment: Alignment.topLeft,
          ),
        ),
        PageViewModel(
            title: 'List Your Medicines',
            image: Image.asset('assets/images/medicines-3.png'),
            body: 'You can list your medicines as a PDF file for later use',
            decoration: PageDecoration(
                bodyFlex: 4,
                bodyAlignment: Alignment.topLeft,
                //imagePadding: EdgeInsets.all(24),
                //bodyPadding: EdgeInsets.all(24),
                imageAlignment: Alignment.bottomRight,
                fullScreen: true)),
        PageViewModel(
            title: 'Text Recognition',
            body:
                'You can use text recognition tecnology for small Medicine description words',
            image: Image.asset('assets/images/medicines-2.png'),
            decoration: PageDecoration(
                imagePadding: EdgeInsets.all(24),
                bodyPadding: EdgeInsets.all(24),
                imageAlignment: Alignment.topRight,
                imageFlex: 3))
      ],
      done: Text(
        'Done!',
        style: TextStyle(fontSize: 15, color: Colors.black),
      ),
      onDone: () => Navigator.of(context).pushReplacementNamed('/'),
      showDoneButton: true,
      next: Icon(
        Icons.arrow_forward,
        color: Colors.black,
      ),
    ));
  }
}
