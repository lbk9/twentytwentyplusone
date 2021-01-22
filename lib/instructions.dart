import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:ttplusone/memories.dart';

class Instructions extends StatefulWidget {
  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Hive.box('intro').add('viewedInstructions');
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Memories()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
            title: "Welcome",
            body: "Welcome to TwentyTwenty+1",
            image: Image.asset('assets/welcomepage.png'),
            decoration: pageDecoration),
        PageViewModel(
            title: "Last year was a rough one",
            body:
                "Lets make an effort to make this year better and remember the good things.",
            image: Image.asset('assets/page2.png'),
            decoration: pageDecoration),
        PageViewModel(
            title: "Remember the good times.",
            body:
                "Anytime something positive happens, make a note of it and come back to it later when you need a pick me up.",
            image: Image.asset('assets/page1.png'),
            decoration: pageDecoration)
      ],
      onDone: () => _onIntroEnd(context),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      showSkipButton: true,
      skip: const Text('Skip'),
      onSkip: () => _onIntroEnd(context),
      next: Icon(Icons.arrow_right),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
