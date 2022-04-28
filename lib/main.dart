import 'package:flutter/material.dart';
import 'package:go_mun/general_speakers_list.dart';
import 'package:go_mun/moderated_caucus.dart';
import 'package:go_mun/single_speaker.dart';
import 'package:go_mun/unmoderated_caucus.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable, use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  var committeeName = "World Health Organization";
  var committeeTopic = "Preventing Future Pandemics and Epidemics";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            actions: [Image.asset("assets/images/go_logo.png")],
            centerTitle: false,
            title: Text(
              "Committee:     \t$committeeName\nCurrent Topic: \t$committeeTopic",
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 15),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: "General Speakers List"),
                Tab(text: "Single Speaker"),
                Tab(text: "Moderated Caucus"),
                Tab(text: "Unmoderated Caucus"),
              ],
            ),
          ),
          body: const TabBarView(children: [
            GeneralSpeakersList(),
            SingleSpeaker(),
            ModeratedCaucus(),
            UnmoderatedCaucus(),
          ]),
        ),
      ),
    );
  }
}
