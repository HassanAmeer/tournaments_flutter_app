import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager/utils/assets.dart';
import 'package:manager/utils/colors.dart';
import 'package:manager/vm/home_vm.dart';
import 'package:manager/vm/planing_vm_version2.dart';
import 'package:provider/provider.dart';
import 'planingloading.dart';

class AllTeamsBySportTypePage extends StatefulWidget {
  final String gender;
  final String sportType;
  final String tournamentType;
  const AllTeamsBySportTypePage(
      {super.key,
      required this.gender,
      required this.sportType,
      required this.tournamentType});

  @override
  State<AllTeamsBySportTypePage> createState() =>
      _AllTeamsBySportTypePageState();
}

class _AllTeamsBySportTypePageState extends State<AllTeamsBySportTypePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProviderC>(builder: (context, vmValue, child) {
      List filterTeams = [];
      for (var element in vmValue.coachesList) {
        if (element['tournamentType'].toString().toLowerCase() ==
            widget.tournamentType.toString().toLowerCase()) {
          for (var e2 in element['teams']) {
            if (e2['gender'].toString().toLowerCase() ==
                    widget.gender.toString().toLowerCase() &&
                e2['sportType'].toString().toLowerCase() ==
                    widget.sportType.toString().toLowerCase()) {
              filterTeams.add(e2);
            }
          }
        }
      }

      debugPrint("👉 filterTeams:" + filterTeams.toString());
      return Scaffold(
          appBar: AppBar(
            title: const Text("All Teams"),
          ),
          body: SingleChildScrollView(
            controller: ScrollController(),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                decoration:
                    BoxDecoration(color: MaterialColors.deepOrange.shade100),
                child: Column(
                  children: [
                    CupertinoListTile(
                        title: const Text("Tournament"),
                        trailing: Text(widget.tournamentType)),
                    CupertinoListTile(
                        title: const Text("Gender"),
                        trailing: Text(widget.gender)),
                    CupertinoListTile(
                        title: const Text("Sport Type"),
                        trailing: Text(widget.sportType)),
                  ],
                ),
              ),
              filterTeams.isEmpty
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
                      itemCount: filterTeams.length,
                      shrinkWrap: true,
                      controller: ScrollController(),
                      itemBuilder: (BuildContext context, int index) {
                        var data = filterTeams[index];

                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade50),
                                child: ListTile(
                                    leading: Hero(
                                        tag: index.toString(),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: CircleAvatar(
                                                child: Image.asset(
                                                    Assets.boxer)))),
                                    title: Text("${data['fname']}"),
                                    subtitle: RichText(
                                        text: TextSpan(
                                            text: 'Weight: ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                    color:
                                                        Colors.green.shade800,
                                                    fontWeight:
                                                        FontWeight.w400),
                                            children: <TextSpan>[
                                          TextSpan(
                                              text: '${data['weight']} ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: Colors
                                                          .blueGrey.shade700,
                                                      fontWeight:
                                                          FontWeight.w300))
                                        ])),
                                    onTap: () {},
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.double_arrow_sharp,
                                            color:
                                                Colors.blueGrey.shade300)))));
                      })
            ]),
          ),
          extendBody: true,
          bottomNavigationBar: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 80.0, vertical: 10),
              child: filterTeams.isEmpty || filterTeams.length <= 1
                  ? ElevatedButton(
                      onPressed: null,
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const StadiumBorder()),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.blueGrey.shade100)),
                      child: const Text("Make Plan",
                          style: TextStyle(color: Colors.white)))
                  : ElevatedButton(
                      onPressed: () async {
                        await Provider.of<PlaningProviderVersion2C>(context,
                                listen: false)
                            .filterTeamVsTeamF(context,
                                tournamentType: widget.tournamentType,
                                genderIs: widget.gender,
                                sportType: widget.sportType,
                                teams: filterTeams);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PlaningLoading()));
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const StadiumBorder()),
                          backgroundColor: MaterialStateProperty.all(
                              MaterialColors.deepOrange.shade400)),
                      child: const Text("Make Plan",
                          style: TextStyle(color: Colors.white)))));
    });
  }
}
