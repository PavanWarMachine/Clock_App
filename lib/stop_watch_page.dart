import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

class StopWatchPage extends StatefulWidget {
  StopWatchPage({Key? key}) : super(key: key);

  @override
  State<StopWatchPage> createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  ScrollController _controller = ScrollController();
  int seconds = 0, minutes = 0, hours = 0;
  bool isActive = false;
  Timer? timer;
  List laps = [];

  String lapSec = "", lapMin = "", lapHour = "";

  timeSelectorWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: timeFeildBuilder("hours", 0, 23, hours),
              ),
              line(),
              Expanded(
                child: timeFeildBuilder("min", 0, 59, minutes),
              ),
              line(),
              Expanded(
                child: timeFeildBuilder("sec", 0, 59, seconds),
              ),
            ],
          ),
          timeSelectorBox(),
        ],
      ),
    );
  }

  UpdateSecValue(value) {}

  timeFeildBuilder(
      String titleName, int timeMinValue, int timeMaxValue, int value) {
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
            itemCount: 3,
            itemHeight: 65,
            selectedTextStyle:
                GoogleFonts.teko(textStyle: TextStyle(fontSize: 50)),
            textStyle: GoogleFonts.teko(
                textStyle: TextStyle(fontSize: 40, color: Colors.white24)),
            value: value,
            onChanged: UpdateSecValue,
          ),
        ),
      ],
    );
  }

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

  pauseTimer() {
    timer!.cancel();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer _timer) {
      int localSec = seconds + 1;
      int localMin = minutes;
      int localHrs = hours;
      if (localSec >= 59) {
        if (localMin >= 59) {
          localHrs++;
          localMin = 0;
        } else {
          localMin++;
          localSec = 0;
        }
      }
      setState(() {
        seconds = localSec;
        minutes = localMin;
        hours = localHrs;

        lapSec = (seconds >= 10) ? "$seconds" : "0$seconds";
        lapMin = (minutes >= 10) ? "$minutes" : "0$minutes";
        lapHour = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  resetTimer() {
    pauseTimer();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      isActive = false;
      laps = [];
    });
  }

  toggleState() {
    if (isActive) {
      pauseTimer();
    } else {
      startTimer();
    }
    setState(() {
      isActive = !isActive;
    });
  }

  addLaps() {
    String lap = "$lapHour : $lapMin  : $lapSec";
    setState(() {
      laps.add(lap);
      print(laps);
    });
  }

  timeSelectorBox() {
    return IgnorePointer(
      child: Padding(
        padding: const EdgeInsets.only(top: 115),
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

  flagActionButton() {
    return GestureDetector(
      onTap: (() {
        addLaps();
        _scrollDown();
      }),
      child: Container(
        padding: EdgeInsets.all(15),
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
        child: const Icon(
          Icons.flag_outlined,
          size: 40,
        ),
      ),
    );
  }

  void _scrollDown() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  playAndPauseActionButton() {
    return GestureDetector(
      onTap: toggleState,
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
          isActive ? Icons.pause_rounded : Icons.play_arrow_rounded,
          size: 70,
        ),
      ),
    );
  }

  resetTimerActionButton() {
    return GestureDetector(
      onTap: resetTimer,
      child: Container(
        padding: EdgeInsets.all(15),
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
          Icons.restore_rounded,
          size: 40,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          timeSelectorWidget(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            height: 185,
            child: ListView.builder(
              controller: _controller,
              itemCount: laps.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Lap ${index + 1}",
                        style: GoogleFonts.sairaSemiCondensed(
                            textStyle: TextStyle(fontSize: 20)),
                      ),
                      Text(
                        "${laps[index]}",
                        style: GoogleFonts.sairaSemiCondensed(
                            textStyle: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 125),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                flagActionButton(),
                playAndPauseActionButton(),
                resetTimerActionButton()
              ],
            ),
          )
        ],
      ),
    );
  }
}
