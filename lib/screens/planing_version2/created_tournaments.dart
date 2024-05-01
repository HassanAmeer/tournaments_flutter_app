import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager/screens/planing_version2/choosetournament.dart';
import 'package:manager/vm/planing_vm_version2.dart';
import 'package:manager/vm/tournaments_vm.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import 'tournaments_details.dart';

class ListAllTournamnetMatchesPage extends StatefulWidget {
  const ListAllTournamnetMatchesPage({super.key});

  @override
  State<ListAllTournamnetMatchesPage> createState() =>
      _ListAllTournamnetMatchesPageState();
}

class _ListAllTournamnetMatchesPageState
    extends State<ListAllTournamnetMatchesPage> {
  @override
  void initState() {
    super.initState();
    syncFirstF();
  }

  syncFirstF() async {
    await Provider.of<PlaningProviderVersion2C>(context, listen: false)
        .getPlaningF(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaningProviderVersion2C>(builder: (context, vmVal, child) {
      return Scaffold(
          appBar: AppBar(title: const Text("Created Tournaments"), actions: [
            IconButton(
                onPressed: () async {
                  await Provider.of<PlaningProviderVersion2C>(context,
                          listen: false)
                      .getPlaningF(context);
                },
                icon: const Icon(Icons.refresh))
          ]),
          body: Column(
            children: [
              Container(
                  decoration:
                      BoxDecoration(color: MaterialColors.deepOrange.shade100),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Created Tournaments"),
                        Text("${vmVal.planingList.length}")
                      ])),
              /////////////////////////////////
              ListView.builder(
                  itemCount: vmVal.planingList.length,
                  shrinkWrap: true,
                  controller: ScrollController(),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var tournamentData = vmVal.planingList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Container(
                          decoration:
                              BoxDecoration(color: Colors.blueGrey.shade50),
                          child: CupertinoListTile(
                              leading: const Icon(Icons.tour),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VCreatedTeamsListPage(
                                              tournamentType: tournamentData[
                                                  "tournamentType"],
                                              sportType:
                                                  tournamentData["sportType"],
                                              genderIs:
                                                  tournamentData["genderIs"],
                                            )));
                              },
                              title:
                                  Text("${tournamentData["tournamentType"]}"),
                              subtitle: Row(
                                children: [
                                  tournamentData["genderIs"] == "Male"
                                      ? Icon(
                                          Icons.male,
                                          size: 18,
                                          color: Colors.blueGrey.shade800,
                                        )
                                      : Icon(
                                          Icons.female,
                                          size: 18,
                                          color: Colors.blueGrey.shade800,
                                        ),
                                  Text(": ${tournamentData["sportType"]}"),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showCupertinoDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CupertinoAlertDialog(
                                                title: const Text(
                                                    'Want To Delete!'),
                                                actions: [
                                                  CupertinoButton(
                                                      onPressed: () async {
                                                        await vmVal
                                                            .deletePlaningF(
                                                                context,
                                                                docId:
                                                                    tournamentData
                                                                        .id);
                                                      },
                                                      child: const Text('yes')),
                                                  CupertinoButton(
                                                      child: const Text("No"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      })
                                                ],
                                                insetAnimationCurve:
                                                    Curves.slowMiddle,
                                                insetAnimationDuration:
                                                    const Duration(seconds: 2),
                                              );
                                            });
                                      },
                                      icon: Icon(Icons.delete_sweep,
                                          color: Colors.red.shade200)),
                                  const Icon(Icons.arrow_forward_ios),
                                ],
                              ))),
                    );
                  }),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChooseTournamentsPage()));
              }));
    });
  }
}
