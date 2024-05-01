import 'package:flutter/material.dart';
import 'package:manager/auth/login.dart';
import 'package:manager/utils/colors.dart';
import 'package:manager/utils/logout.dart';
import 'package:manager/vm/planing_vm_version2.dart';
import 'package:manager/vm/sporttype_vm.dart';
import 'package:manager/vm/tournaments_vm.dart';
import 'package:provider/provider.dart';
import '../vm/home_vm.dart';
import 'allcoaches.dart';
import 'coachdetails.dart';
import 'planing_version2/created_tournaments.dart';
import 'profile.dart';
import 'sporttype.dart';
import 'tournaments.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TournamentsC>(context, listen: false).getTournamentsF();
    Provider.of<SportTypesC>(context, listen: false).getSportTypesF();
    Provider.of<PlaningProviderVersion2C>(context, listen: false)
        .getPlaningF(context);
    Provider.of<HomeProviderC>(context, listen: false).getCoachesF(context);
  }

  // military_tech_outlined
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Services.logoutF(context);
        },
        child: Scaffold(
            appBar: AppBar(title: const Text("Admin"), actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.grey.shade700,
                    size: 20,
                  )),
              IconButton(
                  onPressed: () async {
                    await Provider.of<TournamentsC>(context, listen: false)
                        .getTournamentsF();
                    await Provider.of<SportTypesC>(context, listen: false)
                        .getSportTypesF();
                    await Provider.of<PlaningProviderVersion2C>(context,
                            listen: false)
                        .getPlaningF(context);
                    await Provider.of<HomeProviderC>(context, listen: false)
                        .getCoachesF(context);
                  },
                  icon: Icon(Icons.refresh,
                      color: MaterialColors.deepOrange.shade400, size: 40)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
                  },
                  icon: const CircleAvatar(child: Icon(Icons.person_4)))
            ]),
            body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: ScrollController(),
                child:
                    Consumer<HomeProviderC>(builder: (context, vmValue, child) {
                  return Column(children: [
                    // Container(
                    //   decoration:
                    //       BoxDecoration(color: MaterialColors.deepOrange.shade100),
                    //   child: const Row(
                    //     children: [Text("")],
                    //   ),
                    // ),

                    ///////////////
                    GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        shrinkWrap: true,
                        children: [
                          IconBox(
                              icon: Icons.person_4,
                              title: 'Coaches',
                              total: vmValue.coachesList.length.toString(),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AllCoachesPage()));
                              }),
                          IconBox(
                              icon: Icons.supervised_user_circle_sharp,
                              title: 'Tournament Matches',
                              total: context
                                  .watch<PlaningProviderVersion2C>()
                                  .planingList
                                  .length
                                  .toString(),
                              notch: Notch.rightTop,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ListAllTournamnetMatchesPage()));
                              }),
                          IconBox(
                              icon: Icons.tour,
                              title: 'Tournament Type',
                              total: context
                                  .watch<TournamentsC>()
                                  .getTournamentsList
                                  .length
                                  .toString(),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TournamentsPage()));
                              }),
                          IconBox(
                              icon: Icons.account_tree_sharp,
                              title: 'Sport Types',
                              total: context
                                  .watch<SportTypesC>()
                                  .getSportTypesList
                                  .length
                                  .toString(),
                              notch: Notch.rightTop,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SportTypePage()));
                              })
                        ]),

                    /////////////////
                    Row(children: [
                      Text("    New Accounts",
                          style: TextStyle(color: Colors.blueGrey.shade300))
                    ]),
                    Card(
                        color: MaterialColors.deepOrange.shade100,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                            leading:
                                const CircleAvatar(child: Icon(Icons.person_4)),
                            title: const Text("Latest Coaches"),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more)))),
                    vmValue.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: vmValue.coachesList.length,
                            shrinkWrap: true,
                            controller: ScrollController(),
                            itemBuilder: (BuildContext context, int index) {
                              var data = vmValue.coachesList[index];
                              return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
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
                                                    child: Image.network(
                                                        data['profile']
                                                            ['imgPath']))),
                                          ),
                                          title: Text(
                                              "${data['profile']['name']}"),
                                          subtitle: Column(children: [
                                            // Row(
                                            //   children: [
                                            //     Text('Plan Status: ',
                                            //         style: Theme.of(context)
                                            //             .textTheme
                                            //             .labelSmall!
                                            //             .copyWith(
                                            //                 color: Colors
                                            //                     .green.shade800,
                                            //                 fontWeight:
                                            //                     FontWeight
                                            //                         .w400)),
                                            //     Icon(Icons.history, size: 13),
                                            //   ],
                                            // ),
                                            RichText(
                                                text: TextSpan(
                                                    text: 'Available: ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color: Colors
                                                                .green.shade800,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
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
                                                                  .blueGrey
                                                                  .shade700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300))
                                                ]))
                                          ]),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CoachDetailsPage(
                                                            profile:
                                                                data['profile'],
                                                            teams:
                                                                data['teams'],
                                                            heroTag: index
                                                                .toString())));
                                          },
                                          trailing: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CoachDetailsPage(
                                                                profile: data[
                                                                    'profile'],
                                                                teams: data[
                                                                    'teams'],
                                                                heroTag: index
                                                                    .toString())));
                                              },
                                              icon: Icon(
                                                  Icons.double_arrow_sharp,
                                                  color: Colors
                                                      .blueGrey.shade300)))));
                            })
                  ]);
                }))));
  }
}

enum Notch { leftTop, rightTop }

class IconBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String total;
  final Function() onTap;
  final Notch notch;
  const IconBox({
    super.key,
    required this.icon,
    required this.title,
    required this.total,
    required this.onTap,
    this.notch = Notch.leftTop,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
              color: MaterialColors.deepOrange.shade100,
              borderRadius: notch == Notch.rightTop
                  ? const BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      topLeft: Radius.circular(25))
                  : const BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
              border: Border.all(width: 1, color: MaterialColors.deepOrange)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.deepOrange.shade300,
                size: 70,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.deepOrange),
              ),
              const SizedBox(
                  height: 2,
                  child: Divider(thickness: 1, color: Colors.deepOrange)),
              Text(
                "$total",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.deepOrange, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
