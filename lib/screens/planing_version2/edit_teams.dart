import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import '../../vm/planing_vm_version2.dart';

class EditTeamsPage extends StatefulWidget {
  final dynamic data;
  final int indexBy;
  final String docId;
  final dynamic filterTeamsForDelete;
  const EditTeamsPage(
      {super.key,
      required this.data,
      required this.indexBy,
      required this.docId,
      this.filterTeamsForDelete});

  @override
  State<EditTeamsPage> createState() => _EditTeamsPageState();
}

class _EditTeamsPageState extends State<EditTeamsPage> {
  String vBy = "Pending";
  int teamWonNo = 0;
  bool isChangedSomeThing = false;

  @override
  void initState() {
    super.initState();
    vBy = widget.data["status"];
    teamWonNo = int.parse(widget.data["winTeamNo"].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Manage Team"), actions: [
          IconButton(
              onPressed: () {
                showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                          title: const Text('Want to Delete!'),
                          // title: Text('Want to Delete ${widget.docId}'),
                          actions: [
                            CupertinoButton(
                                onPressed: () async {
                                  List removeTeams = [];
                                  removeTeams =
                                      widget.filterTeamsForDelete.toList();
                                  removeTeams.removeAt(widget.indexBy);
                                  Provider.of<PlaningProviderVersion2C>(context,
                                          listen: false)
                                      .deletePlaningTeamsOnlyF(context,
                                          docId: widget.docId,
                                          planingListRemovedTeams: removeTeams);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('Yes')),
                            CupertinoButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                          ],
                          insetAnimationCurve: Curves.slowMiddle,
                          insetAnimationDuration: const Duration(seconds: 2));
                    });
              },
              icon: const Icon(Icons.delete_outline))
        ]),
        body: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(children: [
            Container(
              color: MaterialColors.deepOrange.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("   Change Status"),
                  Row(
                    children: [
                      const Text("Pending"),
                      Radio.adaptive(
                        value: "Pending",
                        groupValue: vBy,
                        onChanged: (value) {
                          setState(() {
                            vBy = value!;
                            isChangedSomeThing = true;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      const Text("Done"),
                      Radio.adaptive(
                        value: "Done",
                        groupValue: vBy,
                        onChanged: (value) {
                          setState(() {
                            vBy = value!;
                            isChangedSomeThing = true;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2, child: Divider(color: Colors.black26)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            vBy == "Done"
                ? const Text("Click On The Profile Select To Win",
                    style: TextStyle(color: Colors.deepOrange))
                : const Text(""),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
              decoration: BoxDecoration(color: Colors.blueGrey.shade50),
              child: ListTile(
                onTap: vBy == "Pending"
                    ? null
                    : () {
                        teamWonNo = 0;
                        isChangedSomeThing = true;
                        setState(() {});
                      },
                subtitle: vBy == "Pending"
                    ? null
                    : vBy == "Done" && teamWonNo == 0
                        ? const Text("Win",
                            style: TextStyle(color: Colors.green))
                        : const Text("Loss",
                            style: TextStyle(color: Colors.red)),
                leading: SizedBox(
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
                              top: 27,
                              bottom: 0,
                              child: SizedBox(
                                  width: 30,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: CircleAvatar(
                                              backgroundColor: Colors.black87,
                                              child: vBy == "Pending"
                                                  ? const Icon(Icons.history,
                                                      color: Colors.white,
                                                      size: 15)
                                                  : vBy == "Done" &&
                                                          teamWonNo == 0
                                                      ? Image.asset(Assets.win)
                                                      : Icon(Icons.thumb_down,
                                                          color: Colors
                                                              .red.shade200,
                                                          size: 15))))))
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
                title: Text(
                    "${widget.data['team0']['fname']}${widget.data['team0']['lname']}"),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                    child: CupertinoListTile(
                        title: const Text("Phone"),
                        trailing: IconButton(
                            onPressed: () async {
                              final Uri launchUri = Uri(
                                  scheme: 'tel',
                                  path: "${widget.data['team0']['phone']}");
                              await launchUrl(launchUri);
                            },
                            icon: const Icon(Icons.phone))))),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                    child: CupertinoListTile(
                        title: const Text("Weight"),
                        trailing:
                            Text("${widget.data['team0']['weight']} KG")))),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                    child: CupertinoListTile(
                        title: const Text("Gender"),
                        trailing: Text("${widget.data['team0']['gender']}")))),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                    child: CupertinoListTile(
                        title: const Text("Sport Type"),
                        trailing:
                            Text("${widget.data['team0']['sportType']}")))),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                    child: CupertinoListTile(
                        title: const Text("Birthday"),
                        trailing:
                            Text("${widget.data['team0']['birthday']}")))),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                    child: CupertinoListTile(
                        title: const Text("Address"),
                        trailing: Text("${widget.data['team0']['address']}")))),
            /////////////////////////////////////////////////////////////////////////////////////////////////
            const SizedBox(height: 10),
            Stack(alignment: Alignment.center, children: [
              const Divider(thickness: 4),
              CircleAvatar(child: Image.asset(Assets.vs))
            ]),
            const SizedBox(height: 10),
            Container(
                decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                child: ListTile(
                    onTap: vBy == "Pending"
                        ? null
                        : () {
                            teamWonNo = 1;
                            isChangedSomeThing = true;
                            setState(() {});
                          },
                    subtitle: vBy == "Pending"
                        ? null
                        : vBy == "Done" && teamWonNo == 1
                            ? const Text("Win",
                                style: TextStyle(color: Colors.green))
                            : const Text("Loss",
                                style: TextStyle(color: Colors.red)),
                    leading: SizedBox(
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
                                  top: 27,
                                  bottom: 0,
                                  child: SizedBox(
                                      width: 30,
                                      child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.black87,
                                                  child: vBy == "Pending"
                                                      ? const Icon(
                                                          Icons.history,
                                                          color: Colors.white,
                                                          size: 15)
                                                      : vBy == "Done" &&
                                                              teamWonNo == 1
                                                          ? Image.asset(
                                                              Assets.win)
                                                          : Icon(
                                                              Icons.thumb_down,
                                                              color: Colors
                                                                  .red.shade200,
                                                              size: 15))))))
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
                    title: Text(
                        "${widget.data['team1']['fname']}${widget.data['team1']['lname']}"))),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                    child: CupertinoListTile(
                        title: const Text("Phone"),
                        trailing: IconButton(
                            onPressed: () async {
                              final Uri launchUri = Uri(
                                  scheme: 'tel',
                                  path: "${widget.data['team1']['phone']}");
                              await launchUrl(launchUri);
                            },
                            icon: const Icon(Icons.phone))))),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                    child: CupertinoListTile(
                        title: const Text("Weight"),
                        trailing:
                            Text("${widget.data['team1']['weight']} KG")))),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                    child: CupertinoListTile(
                        title: const Text("Gender"),
                        trailing: Text("${widget.data['team1']['gender']}")))),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                    child: CupertinoListTile(
                        title: const Text("Sport Type"),
                        trailing:
                            Text("${widget.data['team1']['sportType']}")))),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                    child: CupertinoListTile(
                        title: const Text("Birthday"),
                        trailing:
                            Text("${widget.data['team1']['birthday']}")))),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                    child: CupertinoListTile(
                        title: const Text("Address"),
                        trailing: Text("${widget.data['team1']['address']}")))),
          ]),
        ),
        extendBody: true,
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 10),
            child: isChangedSomeThing
                ? ElevatedButton(
                    onPressed: () async {
                      List removeTeams = [];
                      removeTeams = widget.filterTeamsForDelete.toList();
                      removeTeams[widget.indexBy]["status"] = vBy;
                      removeTeams[widget.indexBy]["winTeamNo"] =
                          teamWonNo.toString();
                      Provider.of<PlaningProviderVersion2C>(context,
                              listen: false)
                          .updatePlaningF(context,
                              id: widget.docId, updatedTeams: removeTeams);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(const StadiumBorder()),
                        backgroundColor: MaterialStateProperty.all(
                            MaterialColors.deepOrange.shade400)),
                    child: const Text("Update!",
                        style: TextStyle(color: Colors.white)))
                : const ElevatedButton(
                    onPressed: null,
                    child: Text("Update",
                        style: TextStyle(color: Colors.white)))));
  }
}
