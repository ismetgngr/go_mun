import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:simple_timer/simple_timer.dart';
import 'package:go_mun/country_list.dart';

var country = "ru";
var gslStatus = TimerStatus.pause;

class GeneralSpeakersList extends StatefulWidget {
  const GeneralSpeakersList({Key? key}) : super(key: key);

  @override
  State<GeneralSpeakersList> createState() => _GeneralSpeakersListState();
}

class _GeneralSpeakersListState extends State<GeneralSpeakersList> {
  var gslStatus = TimerStatus.pause;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset(
                  "country_dataset/128x128/$country.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                width: 200,
                child: SimpleTimer(
                  timerStyle: TimerStyle.expanding_sector,
                  progressIndicatorColor: Colors.indigo.shade300,
                  backgroundColor: Colors.grey.shade200,
                  status: gslStatus,
                  duration: const Duration(seconds: 50),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        gslStatus = TimerStatus.start;
                      });
                    },
                    child: const Text("Start"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        gslStatus = TimerStatus.pause;
                      });
                    },
                    child: const Text("Pause"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        gslStatus = TimerStatus.reset;
                      });
                    },
                    child: const Text("Reset"),
                  ),
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Countries Present"))
                ],
              ),
            ],
          ),
          Column()
        ],
      ),
    );
  }
}
