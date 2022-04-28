import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_timer/simple_timer.dart';
import 'country_list.dart';

var unmodStatus = TimerStatus.pause;
var timeLimit = 0;
final TextEditingController minuteController = TextEditingController();
final TextEditingController secondController = TextEditingController();
final TextEditingController topicController = TextEditingController();
var topic = "";

class UnmoderatedCaucus extends StatefulWidget {
  const UnmoderatedCaucus({Key? key}) : super(key: key);
  @override
  State<UnmoderatedCaucus> createState() => _UnmoderatedCaucusState();
}

class _UnmoderatedCaucusState extends State<UnmoderatedCaucus> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 300,
                child: SimpleTimer(
                  timerStyle: TimerStyle.expanding_sector,
                  progressIndicatorColor: Colors.indigo.shade300,
                  backgroundColor: Colors.grey.shade200,
                  status: unmodStatus,
                  duration: Duration(seconds: timeLimit),
                ),
              ),
              Text(
                topic,
                style: const TextStyle(fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        unmodStatus = TimerStatus.start;
                      });
                    },
                    child: const Text("Start"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          unmodStatus = TimerStatus.pause;
                        });
                      },
                      child: const Text("Pause"),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        unmodStatus = TimerStatus.reset;
                      });
                    },
                    child: const Text("Reset"),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350,
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Topic"),
                  ),
                  style: const TextStyle(fontSize: 15),
                  controller: topicController,
                  onSaved: (value) {
                    setState(() {
                      topicController.text = value!;
                    });
                  },
                  textAlign: TextAlign.justify,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Set Timer: "),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: minuteController,
                      onSaved: (value) {
                        setState(() {
                          minuteController.text = value!;
                        });
                      },
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const VerticalDivider(),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: secondController,
                      onSaved: (value) {
                        setState(() {
                          secondController.text = value!;
                        });
                      },
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      topic = topicController.text;
                      timeLimit = int.parse(secondController.text);
                      timeLimit += int.parse(minuteController.text) * 60;
                      print(timeLimit);
                    });
                  },
                  child: const Text("Ok"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
