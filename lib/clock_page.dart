import 'package:flutter/material.dart';
import 'package:one_clock/one_clock.dart';

class ClockPage extends StatefulWidget {
  ClockPage({Key? key}) : super(key: key);

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: AnalogClock(
              height: 300,
              width: 300,
              minuteHandColor: Colors.white54,
              hourHandColor: Colors.white70,
              numberColor: Colors.white54,
              showDigitalClock: false,
              // showTicks: false,
              showAllNumbers: true,
              tickColor: Colors.white70,
              textScaleFactor: 1.5,
            ),
          ),
        ),
        Center(
          child: DigitalClock.dark(
            decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            padding: EdgeInsets.all(10),
            // digitalClockTextColor: Colors.white60,
            textScaleFactor: 2.5,
            showSeconds: true,
            isLive: true,
          ),
        ),
      ],
    );
  }
}
