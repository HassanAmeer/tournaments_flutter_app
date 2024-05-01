import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:manager/screens/planing_version2/edit_teams.dart';
import 'package:manager/utils/assets.dart';
import 'package:manager/vm/planing_vm.dart';
import 'package:manager/vm/planing_vm_version2.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';

class VCreatedTeamsListPage extends StatefulWidget {
  final String tournamentType;
  final String sportType;
  final String genderIs;
  const VCreatedTeamsListPage(
      {super.key,
      required this.tournamentType,
      this.sportType = " ",
      this.genderIs = ""});

  @override
  State<VCreatedTeamsListPage> createState() => _VCreatedTeamsListPageState();
}

class _VCreatedTeamsListPageState extends State<VCreatedTeamsListPage> {
  String vBy = "Pending";

  @override
  void initState() {
    super.initState();
    Provider.of<PlaningProviderC>(context, listen: false).getPlaningF(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        appBar: AppBar(title: const Text("Tournament Details")),
        body: Consumer<PlaningProviderVersion2C>(
            builder: (context, vmVal, child) {
          List filterByTournamentTeams = [];
          filterByTournamentTeams = vmVal.planingList
              .where((element) =>
                  element['tournamentType'].toString().toLowerCase() ==
                      widget.tournamentType.toString().toLowerCase() &&
                  element['sportType'].toString().toLowerCase() ==
                      widget.sportType.toString().toLowerCase() &&
                  element['genderIs'].toString().toLowerCase() ==
                      widget.genderIs.toString().toLowerCase())
              .toList();
          return SingleChildScrollView(
              controller: ScrollController(),
              child: Column(children: [
                Container(
                    decoration: BoxDecoration(
                        color: MaterialColors.deepOrange.shade300
                            .withOpacity(0.5)),
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Total Matches"),
                              Text(
                                  "${filterByTournamentTeams[0]['teams'].length}")
                            ]))),
                Container(
                    decoration: BoxDecoration(
                        color: MaterialColors.deepOrange.shade100),
                    child: Column(children: [
                      CupertinoListTile(
                          title: const Text("Tournament"),
                          trailing: Text(widget.tournamentType)),
                      CupertinoListTile(
                          title: const Text("Gender"),
                          trailing: Text(widget.genderIs)),
                      CupertinoListTile(
                          title: const Text("Sport Type"),
                          trailing: Text(widget.sportType))
                    ])),
                const SizedBox(height: 20),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("    Select"),
                      Row(children: [
                        const Text("Pending"),
                        Radio.adaptive(
                            value: "Pending",
                            groupValue: vBy,
                            onChanged: (value) {
                              setState(() {
                                vBy = value!;
                              });
                            }),
                        const SizedBox(width: 10),
                        const Text("Done"),
                        Radio.adaptive(
                            value: "Done",
                            groupValue: vBy,
                            onChanged: (value) {
                              setState(() {
                                vBy = value!;
                              });
                            })
                      ])
                    ]),

                /////////////
                vmVal.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : filterByTournamentTeams.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.2),
                            child: Center(
                                child: Text("No Teams",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade300,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24))))
                        : ListView.builder(
                            itemCount: filterByTournamentTeams[0]['teams']
                                .where((e) =>
                                    e["status"].toString().toLowerCase() ==
                                    vBy.toString().toLowerCase())
                                .length,
                            shrinkWrap: true,
                            controller: ScrollController(),
                            itemBuilder: (BuildContext context, int index) {
                              var data = filterByTournamentTeams[0]['teams']
                                  .where((e) =>
                                      e["status"].toString().toLowerCase() ==
                                      vBy.toString().toLowerCase())
                                  .toList()[index];
                              return VsTile(
                                  data: data,
                                  indexBy: index,
                                  docId: filterByTournamentTeams[0].id,
                                  filterTeamsForDelete:
                                      filterByTournamentTeams[0]['teams']
                                          .toList());
                            })
              ]));
        }));
  }
}

class VsTile extends StatefulWidget {
  final dynamic data;
  final int indexBy;
  final String docId;
  final dynamic filterTeamsForDelete;
  const VsTile(
      {super.key,
      this.data,
      required this.indexBy,
      this.docId = " ",
      this.filterTeamsForDelete});

  @override
  State<VsTile> createState() => _VsTileState();
}

class _VsTileState extends State<VsTile> {
  bool isShowMore = false;

  String choosedWon = "1";

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditTeamsPage(
                        docId: widget.docId,
                        data: widget.data,
                        indexBy: widget.indexBy,
                        filterTeamsForDelete: widget.filterTeamsForDelete,
                      )));
        },
        child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.16,
                      child: Stack(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CircleAvatar(
                                radius: 30,
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.white,
                                        child: Image.asset(Assets.boxer))))),
                        Positioned(
                                // right: -4,
                                top: 34,
                                bottom: 0,
                                // offset: Offset(-10, 0),

                                child: SizedBox(
                                    width: 30,
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: CircleAvatar(
                                                backgroundColor: Colors.black87,
                                                child: widget.data['status'] ==
                                                            "Done" &&
                                                        widget.data['winTeamNo'] ==
                                                            "0"
                                                    ? Image.asset(Assets.win)
                                                    : widget.data['status'] ==
                                                                "Done" &&
                                                            widget.data[
                                                                    'winTeamNo'] ==
                                                                "1"
                                                        ? Icon(Icons.thumb_down,
                                                            color: Colors
                                                                .redAccent
                                                                .shade100,
                                                            size: 12)
                                                        : const Icon(
                                                            Icons.history,
                                                            color: Colors.white,
                                                            size: 12))))))
                            .animate(
                                delay: 500.ms,
                                onPlay: (controller) => controller.repeat())
                            .saturate()
                            .shimmer(
                                duration: const Duration(seconds: 2),
                                delay: const Duration(milliseconds: 1000))
                            .shimmer(
                                duration: const Duration(seconds: 2),
                                curve: Curves.easeInOut)
                      ])),
                  Text(" ${widget.data['team0']['weight']} ",
                      style: const TextStyle(fontSize: 14)),
                  SizedBox(width: 20, child: Image.asset(Assets.weight)),
                ]),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Image.asset(Assets.vs)),
                Row(children: [
                  Text(" ${widget.data['team1']['weight']} ",
                      style: const TextStyle(fontSize: 14)),
                  SizedBox(width: 20, child: Image.asset(Assets.weight)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.17,
                      child: Stack(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CircleAvatar(
                              radius: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(Assets.boxer)),
                              ),
                            )),
                        Positioned(
                                top: 34,
                                bottom: 0,
                                child: SizedBox(
                                    width: 30,
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: CircleAvatar(
                                                backgroundColor: Colors.black87,
                                                child: widget.data['status'] ==
                                                            "Done" &&
                                                        widget.data['winTeamNo'] ==
                                                            "1"
                                                    ? Image.asset(Assets.win)
                                                    : widget.data['status'] ==
                                                                "Done" &&
                                                            widget.data[
                                                                    'winTeamNo'] ==
                                                                "0"
                                                        ? Icon(Icons.thumb_down,
                                                            color: Colors
                                                                .redAccent
                                                                .shade100,
                                                            size: 12)
                                                        : const Icon(
                                                            Icons.history,
                                                            color: Colors.white,
                                                            size: 12))))))
                            .animate(
                                delay: 500.ms,
                                onPlay: (controller) => controller.repeat())
                            .saturate()
                            .shimmer(
                                duration: const Duration(seconds: 2),
                                delay: const Duration(milliseconds: 1000))
                            .shimmer(
                                duration: const Duration(seconds: 2),
                                curve: Curves.easeInOut)
                      ]))
                ])
              ]),
              const Divider(),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(" ${widget.data['team0']['fname']} ",
                            style: TextStyle(color: Colors.blueGrey.shade300)),
                        // widget.data['status'] == "Pending"
                        //     ? Icon(Icons.history, color: Colors.grey, size: 20)
                        //     : Icon(Icons.check, color: Colors.green, size: 20),
                        Text(" ${widget.data['team1']['fname']} ",
                            style: TextStyle(color: Colors.blueGrey.shade300))
                      ]))
            ])));
  }

///////////////////////////////
}
