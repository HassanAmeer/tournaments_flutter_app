import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';

class CoachDetailsPage extends StatefulWidget {
  final dynamic profile;
  final dynamic teams;
  final String? heroTag;
  const CoachDetailsPage(
      {super.key, required this.profile, this.teams, this.heroTag = '0'});

  @override
  State<CoachDetailsPage> createState() => _CoachDetailsPageState();
}

class _CoachDetailsPageState extends State<CoachDetailsPage> {
  List<String> catgForTeam = [
    "Pain Full Fight",
    "Full Knockout",
    "Classic Kick",
  ];
  String selectedCategory = "Pain Full Fight";
  String selectedGender = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Coach Details"),
          backgroundColor: MaterialColors.deepOrange.shade50,
          surfaceTintColor: MaterialColors.deepOrange.shade50,
          elevation: 0),
      // extendBody: true,
      // bottomNavigationBar: Padding(
      //     padding: EdgeInsets.symmetric(
      //         horizontal: MediaQuery.of(context).size.width * 0.2, vertical: 5),
      //     child: ElevatedButton(
      //         style: ButtonStyle(
      //             backgroundColor: MaterialStateProperty.all(
      //                 MaterialColors.deepOrange.shade300)),
      //         onPressed: () {},
      //         child:
      //             const Text("Plan", style: TextStyle(color: Colors.white)))),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.12,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                        color: MaterialColors.deepOrange.shade50,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(70))),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //////////
                            Row(children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 17.0),
                                  child: Hero(
                                      tag: "${widget.heroTag}",
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: CircleAvatar(
                                            radius: 40,
                                            child: Image.network(
                                                widget.profile['imgPath'])),
                                      ))),
                              Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${widget.profile['name']}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: MaterialColors
                                                        .deepOrange.shade300,
                                                    fontWeight:
                                                        FontWeight.bold))
                                            .animate(
                                                delay: 500.ms,
                                                onPlay: (controller) =>
                                                    controller.repeat())
                                            .shimmer(
                                                duration:
                                                    const Duration(seconds: 2),
                                                delay: const Duration(
                                                    milliseconds: 1000))
                                            .shimmer(
                                                duration:
                                                    const Duration(seconds: 2),
                                                curve: Curves.easeInOut),
                                        RichText(
                                            text: TextSpan(
                                                text: 'Available: ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: Colors
                                                            .green.shade700,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      '"${widget.profile['availableTimeRange']} ',
                                                  // '${formatDate(DateTime.now())} ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: Colors.blueGrey
                                                              .shade400,
                                                          fontWeight:
                                                              FontWeight.w300))
                                            ]))
                                      ]))
                            ])
                          ]),
                    ))),
            Stack(children: [
              Container(
                  color: MaterialColors.deepOrange.shade50,
                  height: MediaQuery.of(context).size.height * 0.5),
              Container(
                  // height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(100))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: CupertinoListTile(
                                  backgroundColor:
                                      Colors.grey.shade200.withOpacity(0.4),
                                  title: Text('${widget.profile['phone']}'),
                                  trailing: Transform.translate(
                                    offset: const Offset(-10, 0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: CircleAvatar(
                                          radius: 25,
                                          child: IconButton(
                                              onPressed: () async {
                                                final Uri launchUri = Uri(
                                                  scheme: 'tel',
                                                  path:
                                                      "${widget.profile['phone']}",
                                                );
                                                await launchUrl(launchUri);
                                              },
                                              icon: const Icon(Icons.call))),
                                    ),
                                  ),
                                  // trailing: Transform.translate(
                                  //   offset: const Offset(-20, 0),
                                  //   child: Transform.rotate(
                                  //     angle: -0.0,
                                  //     child: Container(
                                  //         decoration: BoxDecoration(
                                  //           color: MaterialColors
                                  //               .deepOrange.shade100,
                                  //           borderRadius: BorderRadius.only(
                                  //             topRight: Radius.circular(50),
                                  //             // bottomLeft: Radius.circular(15),
                                  //             // bottomRight: Radius.circular(15),
                                  //           ),
                                  //         ),
                                  //         child: Padding(
                                  //           padding:
                                  //               const EdgeInsets.all(8.0),
                                  //           child: Icon(Icons.call),
                                  //         )),
                                  //   ),
                                  // ),
                                ))),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: CupertinoListTile(
                                    backgroundColor:
                                        Colors.grey.shade200.withOpacity(0.4),
                                    title: const Text('Education Certificate:'),
                                    subtitle: Text(
                                        '${widget.profile['educationCertificate']}')))),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: CupertinoListTile(
                                    backgroundColor:
                                        Colors.grey.shade200.withOpacity(0.4),
                                    title: const Text('Preferences:'),
                                    subtitle: Text(
                                        '${widget.profile['preferences']}')))),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: CupertinoListTile(
                                    backgroundColor:
                                        Colors.grey.shade200.withOpacity(0.4),
                                    title: const Text('Skills Experties:'),
                                    subtitle: Text(
                                        '${widget.profile['skillsExperties']}')))),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: CupertinoListTile(
                                    backgroundColor:
                                        Colors.grey.shade200.withOpacity(0.4),
                                    title: const Text('Teams Currently Coach:'),
                                    subtitle: Text(
                                        '${widget.profile['teamsCurrentlyCoach']}')))),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: CupertinoListTile(
                                    backgroundColor:
                                        Colors.grey.shade200.withOpacity(0.4),
                                    title: const Text('Available:'),
                                    subtitle: Text(
                                        '${widget.profile['availableTimeRange']}')))),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: CupertinoListTile(
                                    backgroundColor:
                                        Colors.grey.shade200.withOpacity(0.4),
                                    title: const Text('Tournament:'),
                                    subtitle: Text(
                                        '${widget.profile['tournamentType']}')))),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: CupertinoListTile(
                                    backgroundColor:
                                        Colors.grey.shade200.withOpacity(0.4),
                                    title: const Text('Sport Type:'),
                                    subtitle: Text(
                                        '${widget.profile['tournamentType']}')))),
                      ],
                    ),
                  ))
            ]),
            //   Container(
            //  ),
            Stack(children: [
              const Divider(color: Colors.black, thickness: 1),
              Center(
                  child: Container(
                      color: Colors.grey.shade50,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(' ${widget.profile['name']} Teams',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  letterSpacing: 2)))))
            ]),
            // Text("${widget.data}"),
            ListView.builder(
                itemCount: widget.teams.length,
                shrinkWrap: true,
                controller: ScrollController(),
                itemBuilder: (context, index) {
                  var team = widget.teams[index];
                  return ExpansionTile(
                    leading: const CircleAvatar(
                        child: Icon(Icons.person_4_outlined)),
                    title: Text("${team['fname']}"),
                    subtitle: Text("${team['sportType']}"),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Container(
                          color: Colors.blueGrey.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Text("Birthday:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color:
                                                    Colors.blueGrey.shade400))),
                                Text("${team['birthday']}"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Container(
                          color: Colors.blueGrey.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Text("Gender:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color:
                                                    Colors.blueGrey.shade400))),
                                Text("${team['gender']}"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Container(
                              color: Colors.blueGrey.shade50,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Text("Sport Type:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                    color: Colors
                                                        .blueGrey.shade400))),
                                    Text("${team['sportType']}")
                                  ])))),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Container(
                              color: Colors.blueGrey.shade50,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Text("Phone:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                    color: Colors
                                                        .blueGrey.shade400))),
                                    Text("${team['phone']}")
                                  ])))),
                      ////
                      Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Container(
                              color: Colors.blueGrey.shade50,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Text("Weight:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                    color: Colors
                                                        .blueGrey.shade400))),
                                    Text("${team['weight']}")
                                  ])))),
                      ////
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
