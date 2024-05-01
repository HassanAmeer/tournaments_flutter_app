import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager/screens/planing_version2/choose_sport_type_page.dart';
import 'package:manager/vm/tournaments_vm.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';

class ChooseTournamentsPage extends StatefulWidget {
  const ChooseTournamentsPage({super.key});

  @override
  State<ChooseTournamentsPage> createState() => _ChooseTournamentsPageState();
}

class _ChooseTournamentsPageState extends State<ChooseTournamentsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TournamentsC>(builder: (context, vmVal, child) {
      return Scaffold(
        appBar: AppBar(title: const Text("Choose Tournaments")),
        body: Column(
          children: [
            Container(
                decoration:
                    BoxDecoration(color: MaterialColors.deepOrange.shade100),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Total Tournaments"),
                      Text("${vmVal.getTournamentsList.length}")
                    ])),
            /////////////////////////////////
            ListView.builder(
                itemCount: vmVal.getTournamentsList.length,
                shrinkWrap: true,
                controller: ScrollController(),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var tournamentData = vmVal.getTournamentsList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                        decoration:
                            BoxDecoration(color: Colors.blueGrey.shade50),
                        child: CupertinoListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChooseSportTypePage(
                                          tournamentType:
                                              tournamentData["title"])));
                            },
                            title: Text("${tournamentData["title"]}"))),
                  );
                }),
          ],
        ),
        bottomNavigationBar: const BottomAppBar(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              StepCircle(
                  number: 1,
                  name: "Tournaments",
                  color: MaterialColors.deepOrange),
              Dot(color: MaterialColors.deepOrange),
              Dot(color: MaterialColors.deepOrange),
              Dot(color: MaterialColors.deepOrange),
              Dot(color: MaterialColors.deepOrange),
              Dot(color: MaterialColors.deepOrange),
              StepCircle(number: 2, name: "Sport Type"),
              Dot(),
              Dot(),
              Dot(),
              Dot(),
              Dot(),
              StepCircle(number: 1, name: "Make Plan")
            ])),
      );
    });
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
