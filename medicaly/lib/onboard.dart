import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

const onboard = 'onboard';

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
              boxDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 43, 41, 41), Colors.white],
                      begin: Alignment.topCenter)),
              imagePadding: EdgeInsets.all(30),
              bodyPadding: EdgeInsets.all(24),
              imageAlignment: Alignment.topLeft,
              safeArea: 100),
        ),
        PageViewModel(
            title: 'List Your Medicines',
            image: Image.asset('assets/images/medicines-3.png'),
            body: 'You can list your medicines as a PDF file for later use',
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              bodyTextStyle: TextStyle(color: Colors.white, fontSize: 18),
              boxDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 43, 41, 41), Colors.white],
                      begin: Alignment.bottomCenter)),
              bodyFlex: 4,
              imageFlex: 10,
              bodyAlignment: Alignment.center,
              //imagePadding: EdgeInsets.all(24),
              //bodyPadding: EdgeInsets.all(24),
              imageAlignment: Alignment.bottomRight,
            )),
        PageViewModel(
            title: 'Text Recognition',
            body:
                'You can use text recognition tecnology for small Medicine description words',
            image: Image.asset(
              'assets/images/medicines-2.png',
              color: Colors.blueGrey,
            ),
            decoration: PageDecoration(
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                bodyTextStyle: TextStyle(color: Colors.white, fontSize: 18),
                boxDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 43, 41, 41), Colors.white],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                ),
                imagePadding: EdgeInsets.all(24),
                bodyPadding: EdgeInsets.all(24),
                imageAlignment: Alignment.topRight,
                imageFlex: 3))
      ],
      dotsContainerDecorator: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 43, 41, 41), Colors.white])),
      done: Text(
        'Done',
        style: TextStyle(fontSize: 15, color: Colors.black),
      ),
      onDone: () async {
        Navigator.of(context).pushReplacementNamed('/');
      },
      showDoneButton: true,
      next: Icon(
        Icons.arrow_forward,
        color: Colors.black,
      ),
    ));
  }
}
