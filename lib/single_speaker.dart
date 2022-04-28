import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_mun/country_list.dart';
import 'package:simple_timer/simple_timer.dart';

final formKey = GlobalKey<FormState>();
final TextEditingController minuteController = TextEditingController();
final TextEditingController secondController = TextEditingController();

var country = "go";
var timeLimit = 60;

class SingleSpeaker extends StatefulWidget {
  const SingleSpeaker({Key? key}) : super(key: key);
  @override
  State<SingleSpeaker> createState() => _SingleSpeakerState();
}

class _SingleSpeakerState extends State<SingleSpeaker> {
  var singleSpeakerStatus = TimerStatus.pause;
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
                  status: singleSpeakerStatus,
                  duration: Duration(seconds: timeLimit),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        singleSpeakerStatus = TimerStatus.start;
                      });
                    },
                    child: const Text("Start"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          singleSpeakerStatus = TimerStatus.pause;
                        });
                      },
                      child: const Text("Pause"),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        singleSpeakerStatus = TimerStatus.reset;
                      });
                    },
                    child: const Text("Reset"),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                  OutlinedButton(
                      onPressed: () {
                        setState(() {
                          timeLimit = int.parse(secondController.text);
                          timeLimit += int.parse(minuteController.text) * 60;
                          print(timeLimit);
                        });
                      },
                      child: const Text("Ok"))
                ],
              ),
              SizedBox(
                width: 400,
                height: 400,
                child: DecoratedBox(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.indigo)),
                  child: ListView.builder(
                    itemCount: Countries.countryList.length,
                    itemBuilder: (context, index) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            timeLimit = timeLimit;
                            singleSpeakerStatus = TimerStatus.reset;
                            country = Countries.countryList[index]["alpha2"];
                            //singleSpeakerStatus = TimerStatus.start;
                          });
                        },
                        child: Text(Countries.countryList[index]["name"]),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
