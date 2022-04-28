import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_timer/simple_timer.dart';
import 'country_list.dart';

var country = "go";

var modStatus = TimerStatus.pause;
var delegateStatus = TimerStatus.pause;
var modTimeLimit = 600;
var delegateTimeLimit = 60;

final TextEditingController minuteTotalController = TextEditingController();
final TextEditingController secondTotalController = TextEditingController();
final TextEditingController minutePerDelegateController =
    TextEditingController();
final TextEditingController secondPerDelegateController =
    TextEditingController();
final TextEditingController topicController = TextEditingController();
var topic = "";

class ModeratedCaucus extends StatefulWidget {
  const ModeratedCaucus({Key? key}) : super(key: key);
  @override
  State<ModeratedCaucus> createState() => ModeratedCaucusState();
}

class ModeratedCaucusState extends State<ModeratedCaucus> {
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
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: SimpleTimer(
                      timerStyle: TimerStyle.expanding_sector,
                      progressIndicatorColor: Colors.indigo.shade300,
                      backgroundColor: Colors.grey.shade200,
                      status: delegateStatus,
                      duration: Duration(seconds: delegateTimeLimit),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: SimpleTimer(
                      timerStyle: TimerStyle.expanding_sector,
                      progressIndicatorColor: Colors.indigo.shade300,
                      backgroundColor: Colors.grey.shade200,
                      status: modStatus,
                      duration: Duration(seconds: modTimeLimit),
                    ),
                  ),
                ],
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
                        modStatus = TimerStatus.start;
                        delegateStatus = TimerStatus.start;
                      });
                    },
                    child: const Text("Start"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          modStatus = TimerStatus.pause;
                          delegateStatus = TimerStatus.pause;
                        });
                      },
                      child: const Text("Pause"),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        modStatus = TimerStatus.reset;
                        delegateStatus = TimerStatus.reset;
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
                  const Text("Total Time: "),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: minuteTotalController,
                      onSaved: (value) {
                        setState(() {
                          minuteTotalController.text = value!;
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
                      controller: secondTotalController,
                      onSaved: (value) {
                        setState(() {
                          secondTotalController.text = value!;
                        });
                      },
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Per Delegate: "),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: minutePerDelegateController,
                      onSaved: (value) {
                        setState(() {
                          minutePerDelegateController.text = value!;
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
                      controller: secondPerDelegateController,
                      onSaved: (value) {
                        setState(() {
                          secondPerDelegateController.text = value!;
                        });
                      },
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      topic = topicController.text;
                      modTimeLimit = int.parse(secondTotalController.text);
                      modTimeLimit +=
                          int.parse(minuteTotalController.text) * 60;
                      delegateTimeLimit =
                          int.parse(secondPerDelegateController.text);
                      delegateTimeLimit +=
                          int.parse(minutePerDelegateController.text) * 60;
                      print(modTimeLimit);
                    });
                  },
                  child: const Text("Ok"),
                ),
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
                            country = Countries.countryList[index]["alpha2"];
                            delegateStatus = TimerStatus.reset;
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
