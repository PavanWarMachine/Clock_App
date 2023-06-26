import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TimerPage extends StatefulWidget {
  TimerPage({
    Key? key,
    this.hour,
    this.min,
    this.sec,
  }) : super(key: key);
  final int? hour;
  final int? min;
  final int? sec;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  TextStyle titleText = GoogleFonts.zenTokyoZoo(
      textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.w400));

  TextStyle timeText = GoogleFonts.graduate(textStyle: TextStyle(fontSize: 50));
  int currentCounter = 0;
  int? totalSeconds;
  bool isActive = false;
  late final int totalDurationInSeconds;
  int remaingSeconds = 0;
  Timer? timer;

  @override
  void initState() {
    totalDurationInSeconds = totalSecValue();
    remaingSeconds = totalDurationInSeconds;
    toggleState();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  totalSecValue() {
    totalSeconds = (widget.min! * 60);
    totalSeconds = (widget.sec! + totalSeconds!);
    return totalSeconds;
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

  pauseTimer() {
    timer!.cancel();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer _timer) {
      if (remaingSeconds != 0) {
        setState(() {
          remaingSeconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  resetTimer() {
    pauseTimer();
    setState(() {
      remaingSeconds = totalDurationInSeconds;
      isActive = false;
    });
  }

  String parseSecondsText() => (remaingSeconds % 60).toString().padLeft(2, '0');

  String parseMinutesText() =>
      (remaingSeconds ~/ 60).toString().padLeft(2, '0');

//UI related function

  outerProgressValueCircle() {
    return Container(
      height: 400,
      width: 400,
      child: Stack(
        children: [
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 1,
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                axisLineStyle: AxisLineStyle(
                  thickness: 1,
                  color: Colors.transparent,
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: 1,
                    width: 0.05,
                    color: Colors.black,
                    pointerOffset: 0.1,
                    cornerStyle: CornerStyle.bothFlat,
                    sizeUnit: GaugeSizeUnit.factor,
                  )
                ],
              ),
            ],
          ),
          SfRadialGauge(enableLoadingAnimation: true, axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 100,
              showLabels: false,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              axisLineStyle: AxisLineStyle(
                thickness: 1,
                color: Colors.transparent,
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                  enableDragging: true,
                  enableAnimation: true,
                  animationType: AnimationType.linear,
                  value: timerCircelValueIndicator(),
                  width: 0.05,
                  color: Colors.white,
                  pointerOffset: 0.1,
                  cornerStyle: CornerStyle.endCurve,
                  sizeUnit: GaugeSizeUnit.factor,
                )
              ],
            )
          ]),
        ],
      ),
    );
  }

  timerCircelValueIndicator() =>
      (remaingSeconds / totalDurationInSeconds) * 100;

  innerEmptyCircle() {
    return Container(
      height: 270,
      width: 270,
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 1,
          showLabels: false,
          showTicks: false,
          startAngle: 270,
          endAngle: 270,
          axisLineStyle: AxisLineStyle(
            thickness: 1,
            color: Colors.transparent,
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: <GaugePointer>[
            RangePointer(
              value: 1,
              width: 0.02,
              color: Colors.black,
              pointerOffset: 0.1,
              cornerStyle: CornerStyle.bothCurve,
              sizeUnit: GaugeSizeUnit.factor,
            )
          ],
        )
      ]),
    );
  }

  timerDisplayText() {
    return Container(
      width: 180,
      child: AutoSizeText(
        "${parseMinutesText()} : ${parseSecondsText()}",
        style: timeText,
        textAlign: TextAlign.center,
        maxLines: 1,
      ),
    );
  }

  cancelActionButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
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
          Icons.close_rounded,
          size: 40,
        ),
      ),
    );
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                outerProgressValueCircle(),
                innerEmptyCircle(),
                timerDisplayText()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                cancelActionButton(),
                playAndPauseActionButton(),
                resetTimerActionButton()
              ],
            )
          ],
        ),
      ),
    );
  }
}
