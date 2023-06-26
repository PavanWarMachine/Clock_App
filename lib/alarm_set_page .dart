import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

class AlarmSetPage extends StatefulWidget {
  AlarmSetPage({Key? key}) : super(key: key);

  @override
  State<AlarmSetPage> createState() => _AlarmSetPageState();
}

class _AlarmSetPageState extends State<AlarmSetPage> {
  TextStyle titleText = GoogleFonts.monoton(
    textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
  );

  bool isOn = false;
  int alarmId = 1;

  int currentHourValue = 0;
  int currentMinValue = 0;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    AndroidAlarmManager.initialize();
    super.initState();
  }

  addAlarmButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                title: Center(child: Text('Add Alarm')),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      timeSelectorWidget(),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      child: Text("Submit"),
                      onPressed: () {
                        // your code
                      })
                ],
              );
            });
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
            borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Icon(
              Icons.add_alarm_rounded,
              size: 40,
              color: Colors.white70,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text("Add Alarm"),
            )
          ],
        ),
      ),
    );
  }

  // TIME SELECTOR BOX

  line() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Text(
          "|",
          style: TextStyle(fontSize: 35, color: Colors.black),
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
              textStyle: TextStyle(fontSize: 25)),
        ),
        Container(
          child: NumberPicker(
            minValue: timeMinValue,
            maxValue: timeMaxValue,
            itemCount: 3,
            itemHeight: 50,
            selectedTextStyle:
                GoogleFonts.teko(textStyle: TextStyle(fontSize: 40)),
            textStyle: GoogleFonts.teko(
                textStyle: TextStyle(fontSize: 30, color: Colors.white24)),
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

  timeSelectorBox() {
    return IgnorePointer(
      child: Padding(
        padding: const EdgeInsets.only(top: 85),
        child: Container(
          height: 60,
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

  addAlarmForm() {
    AlertDialog(
      title: Text(
        "ADD ALARM",
        style: titleText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Center(
              child: Transform.scale(
                scale: 2,
                child: Switch(
                    value: isOn,
                    onChanged: (value) {
                      setState(() {
                        isOn = value;
                      });
                      if (isOn == true) {
                        AndroidAlarmManager.periodic(
                          Duration(seconds: 10),
                          alarmId,
                          alarmMsg,
                          exact: true,
                        );
                      } else {
                        AndroidAlarmManager.cancel(alarmId);
                      }
                    }),
              ),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  child: Text("data"),
                ),
                Container(
                  padding: EdgeInsets.only(top: 550),
                  alignment: Alignment.bottomCenter,
                  child: addAlarmButton(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void alarmMsg() {
  print("Alarm Fired - ${DateTime.now()}");
}
