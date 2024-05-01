import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager/vm/sporttype_vm.dart';
import 'package:provider/provider.dart';

import '../../utils/assets.dart';
import '../../utils/colors.dart';
import 'allteamsbysporttype.dart';

class ChooseSportTypePage extends StatefulWidget {
  final String tournamentType;
  const ChooseSportTypePage({super.key, required this.tournamentType});

  @override
  State<ChooseSportTypePage> createState() => _ChooseSportTypePageState();
}

class _ChooseSportTypePageState extends State<ChooseSportTypePage> {
  int selectedBox = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(" Gender/SportType"), centerTitle: true),
      body: Column(children: [
        const SizedBox(height: 10),
        Text("1. Choose Gender",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: MaterialColors.deepOrange.shade200)),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          GestureDetector(
              onTap: () {
                selectedBox = 1;
                setState(() {});
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: MaterialColors.deepOrange.shade50,
                      border: Border.all(
                          width: 4,
                          color: selectedBox == 1
                              ? MaterialColors.deepOrange
                              : Colors.blueGrey.shade100)),
                  height: MediaQuery.of(context).size.width * 0.41,
                  width: MediaQuery.of(context).size.width * 0.41,
                  child: Image.asset(Assets.male))),
          GestureDetector(
              onTap: () {
                selectedBox = 2;
                setState(() {});
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: MaterialColors.deepOrange.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 4,
                          color: selectedBox == 2
                              ? MaterialColors.deepOrange
                              : Colors.blueGrey.shade100)),
                  height: MediaQuery.of(context).size.width * 0.41,
                  width: MediaQuery.of(context).size.width * 0.41,
                  child: Image.asset(Assets.female)))
        ]),
        const SizedBox(height: 10),
        const SizedBox(height: 20),
        Text("2. Choose Sport Type",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: MaterialColors.deepOrange.shade200)),
        Consumer<SportTypesC>(builder: (context, vmVal, child) {
          return ListView.builder(
              itemCount: vmVal.getSportTypesList.length,
              shrinkWrap: true,
              controller: ScrollController(),
              itemBuilder: (BuildContext context, int index) {
                var sportType = vmVal.getSportTypesList[index];
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Container(
                        decoration:
                            BoxDecoration(color: Colors.blueGrey.shade50),
                        child: CupertinoListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllTeamsBySportTypePage(
                                              tournamentType:
                                                  widget.tournamentType,
                                              sportType: sportType["title"],
                                              gender: selectedBox == 1
                                                  ? "Male"
                                                  : "Female")));
                            },
                            title: Text("${sportType["title"]}"))));
              });
        })
      ]),
      bottomNavigationBar: BottomAppBar(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const StepCircle(
                    number: 1,
                    name: "Tournaments",
                    color: MaterialColors.deepOrange)),
            const Dot(color: MaterialColors.deepOrange),
            const Dot(color: MaterialColors.deepOrange),
            const Dot(color: MaterialColors.deepOrange),
            const Dot(color: MaterialColors.deepOrange),
            const Dot(color: MaterialColors.deepOrange),
            const StepCircle(
                number: 2,
                name: "Sport Type",
                color: MaterialColors.deepOrange),
            const Dot(color: MaterialColors.deepOrange),
            const Dot(color: MaterialColors.deepOrange),
            const Dot(color: MaterialColors.deepOrange),
            const Dot(color: MaterialColors.deepOrange),
            const Dot(color: MaterialColors.deepOrange),
            const StepCircle(number: 1, name: "Make Plan")
          ])),
    );
  }
}

class StepCircle extends StatelessWidget {
  final dynamic number;
  final String name;
  final Color? color;
  const StepCircle({
    super.key,
    required this.number,
    required this.name,
    this.color = Colors.blueGrey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
          radius: 17,
          backgroundColor: color!.withOpacity(0.2),
          child: Text(number.toString(), style: TextStyle(color: color))),
      Text(name,
          style: TextStyle(
              color: color, fontSize: 11, fontWeight: FontWeight.bold))
    ]);
  }
}

class Dot extends StatelessWidget {
  final Color color;
  const Dot({super.key, this.color = Colors.blueGrey});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: const Offset(0, -10),
        child: CircleAvatar(radius: 3, backgroundColor: color));
  }
}
