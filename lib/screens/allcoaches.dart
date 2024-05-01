import 'package:flutter/material.dart';
import 'package:manager/vm/home_vm.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';
import 'coachdetails.dart';

class AllCoachesPage extends StatefulWidget {
  const AllCoachesPage({super.key});

  @override
  State<AllCoachesPage> createState() => _AllCoachesPageState();
}

class _AllCoachesPageState extends State<AllCoachesPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProviderC>(builder: (context, vmValue, child) {
      return Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        appBar: AppBar(title: const Text("All Coaches")),
        body: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Container(
                  decoration:
                      BoxDecoration(color: MaterialColors.deepOrange.shade100),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Total Coaches"),
                        Text("${vmValue.coachesList.length}")
                      ])),
              /////////////
              ListView.builder(
                itemCount: vmValue.coachesList.length,
                shrinkWrap: true,
                controller: ScrollController(),
                itemBuilder: (BuildContext context, int index) {
                  var data = vmValue.coachesList[index];
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Container(
                          decoration:
                              BoxDecoration(color: Colors.blueGrey.shade50),
                          child: ListTile(
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Hero(
                                      tag: index.toString(),
                                      child: CircleAvatar(
                                          child: Image.network(
                                              data['profile']['imgPath'])))),
                              title: Text("${data['profile']['name']}"),
                              subtitle: Column(
                                children: [
                                  // Row(children: [
                                  //   Text('Plan Status: ',
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .labelSmall!
                                  //           .copyWith(
                                  //               color: Colors.green.shade800,
                                  //               fontWeight: FontWeight.w400)),
                                  //   const Icon(Icons.history, size: 13)
                                  // ]),
                                  RichText(
                                      text: TextSpan(
                                          text: 'Available: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color: Colors.green.shade800,
                                                  fontWeight: FontWeight.w400),
                                          children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                '${data['profile']['availableTimeRange']} ',
                                            // text: '${formatDate(DateTime.now())} ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                    color: Colors
                                                        .blueGrey.shade700,
                                                    fontWeight:
                                                        FontWeight.w300))
                                      ])),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CoachDetailsPage(
                                            profile: data['profile'],
                                            teams: data['teams'],
                                            heroTag: index.toString())));
                              },
                              trailing: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CoachDetailsPage(
                                                    profile: data['profile'],
                                                    teams: data['teams'],
                                                    heroTag:
                                                        index.toString())));
                                  },
                                  icon: Icon(Icons.double_arrow_sharp,
                                      color: Colors.blueGrey.shade300)))));
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
