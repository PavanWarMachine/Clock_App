import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/timer_select_page.dart';
// import '/alarm_set_page .dart';
import '/stop_watch_page.dart';
import '/clock_page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: DigiClock(),
    ),
  );
}

class DigiClock extends StatefulWidget {
  DigiClock({Key? key}) : super(key: key);

  @override
  State<DigiClock> createState() => _DigiClockState();
}

class _DigiClockState extends State<DigiClock> {
  TextStyle titleText = GoogleFonts.monoton(
    textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
  );
  int currentBottomNavigatorIndex = 0;
  PageController controller = PageController();

  List<Widget> bottomNavigatorPages = <Widget>[
    ClockPage(),
    StopWatchPage(),
    TimerSelectPage()
  ];

  clockNavigationBar() {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        width: deviceWidth / 1,
        height: 80,
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              width: 8,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  currentBottomNavigatorIndex = 0;
                  controller.jumpToPage(currentBottomNavigatorIndex);
                });
              },
              child: Container(
                width: deviceWidth / 3.7,
                decoration: BoxDecoration(
                    color: currentBottomNavigatorIndex == 0
                        ? Colors.white24
                        : Colors.black,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 30,
                      color: currentBottomNavigatorIndex == 0
                          ? Colors.white
                          : Colors.white38,
                    ),
                    Text(
                      "Clock",
                      style: TextStyle(
                        color: currentBottomNavigatorIndex == 0
                            ? Colors.white
                            : Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentBottomNavigatorIndex = 1;
                  controller.jumpToPage(currentBottomNavigatorIndex);
                });
              },
              child: Container(
                width: deviceWidth / 3.7,
                decoration: BoxDecoration(
                    color: currentBottomNavigatorIndex == 1
                        ? Colors.white24
                        : Colors.black,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer_sharp,
                      size: 30,
                      color: currentBottomNavigatorIndex == 1
                          ? Colors.white
                          : Colors.white38,
                    ),
                    Text(
                      "Stopwatch",
                      style: TextStyle(
                        color: currentBottomNavigatorIndex == 1
                            ? Colors.white
                            : Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentBottomNavigatorIndex = 2;
                  controller.jumpToPage(currentBottomNavigatorIndex);
                });
              },
              child: Container(
                width: deviceWidth / 3.7,
                decoration: BoxDecoration(
                    color: currentBottomNavigatorIndex == 2
                        ? Colors.white24
                        : Colors.black,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.av_timer_rounded,
                      size: 30,
                      color: currentBottomNavigatorIndex == 2
                          ? Colors.white
                          : Colors.white38,
                    ),
                    Text("Timer",
                        style: TextStyle(
                          color: currentBottomNavigatorIndex == 2
                              ? Colors.white
                              : Colors.white38,
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            setState(() {
              currentBottomNavigatorIndex = 0;
              controller.jumpToPage(currentBottomNavigatorIndex);
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "C L ",
                style: titleText,
              ),
              Icon(
                Icons.access_time,
                size: 33,
              ),
              Text(
                " C K",
                style: titleText,
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: bottomNavigatorPages,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: clockNavigationBar(),
          ),
        ],
      ),
    );
  }
}
