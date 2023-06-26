import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:vibration/vibration.dart';
import '/timer_page_preview.dart';

class TimerSelectPage extends StatefulWidget {
  TimerSelectPage({Key? key}) : super(key: key);

  @override
  State<TimerSelectPage> createState() => _TimerSelectPageState();
}

class _TimerSelectPageState extends State<TimerSelectPage> {
  int currentHourValue = 0;
  int currentMinValue = 0;
  int currentSecValue = 0;

  bool isActive = false;

  line() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 55),
        child: Text(
          "|",
          style: TextStyle(fontSize: 45, color: Colors.black),
        ),
      ),
    );
  }

  timeSelectorWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: timeFeildBuilder(
                  "hours",
                  0,
                  23,
                  updateHourValue,
                  currentHourValue,
                ),
              ),
              line(),
              Expanded(
                child: timeFeildBuilder(
                  "min",
                  0,
                  59,
                  updateMinValue,
                  currentMinValue,
                ),
              ),
              line(),
              Expanded(
                  child: timeFeildBuilder(
                "sec",
                0,
                59,
                UpdateSecValue,
                currentSecValue,
              )),
            ],
          ),
          timeSelectorBox(),
        ],
      ),
    );
  }

  timeFeildBuilder(String titleName, int timeMinValue, int timeMaxValue,
      void Function(int) updateCallBack, int value) {
    return Column(
      children: [
        Text(
          titleName,
          style: GoogleFonts.sairaSemiCondensed(
              textStyle: TextStyle(fontSize: 35)),
        ),
        Container(
          child: NumberPicker(
            minValue: timeMinValue,
            maxValue: timeMaxValue,
            itemCount: 5,
            itemHeight: 65,
            selectedTextStyle:
                GoogleFonts.teko(textStyle: TextStyle(fontSize: 50)),
            textStyle: GoogleFonts.teko(
                textStyle: TextStyle(fontSize: 40, color: Colors.white24)),
            value: value,
            onChanged: updateCallBack,
          ),
        ),
      ],
    );
  }

  updateHourValue(value) {
    return (setState(() => currentHourValue = value));
  }

  updateMinValue(value) {
    return (setState(() => currentMinValue = value));
  }

  UpdateSecValue(value) {
    return (setState(() => currentSecValue = value));
  }

  timeSelectorBox() {
    return IgnorePointer(
      child: Padding(
        padding: const EdgeInsets.only(top: 180),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              border: Border.all(
                width: 8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 50,
                  offset: Offset(0, 50), // Shadow position
                ),
              ],
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  playButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (currentMinValue == 0 && currentSecValue == 0) {
            Vibration.vibrate(duration: 1000);
          } else {
            isActive = true;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TimerPage(
                  hour: currentHourValue,
                  min: currentMinValue,
                  sec: currentSecValue,
                ),
              ),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(
                width: 8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 30,
                  offset: Offset(0, 30), // Shadow position
                ),
              ],
              borderRadius: BorderRadius.circular(80)),
          child: Icon(
            Icons.play_arrow_rounded,
            size: 70,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              timeSelectorWidget(),
              playButton(),
            ],
          ),
        ),
      ),
    );
  }
}
