// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../utils/assets.dart';
// import '../../utils/colors.dart';

// class VAfterPlanCreatedTeamsPage extends StatefulWidget {
//   final dynamic data;
//   const VAfterPlanCreatedTeamsPage({super.key, required this.data});

//   @override
//   State<VAfterPlanCreatedTeamsPage> createState() =>
//       _VAfterPlanCreatedTeamsPageState();
// }

// class _VAfterPlanCreatedTeamsPageState
//     extends State<VAfterPlanCreatedTeamsPage> {
//   String vBy = "Pending";
//   int teamWonNo = 1;
//   bool isChangedSomeThing = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Manage Team")),
//       body: SingleChildScrollView(
//         controller: ScrollController(),
//         child: Column(children: [
//           Container(
//               color: MaterialColors.deepOrange.shade100,
//               child: const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 14.0),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [Text("    Status"), Text("    Pending")]))),
//           const SizedBox(height: 2, child: Divider(color: Colors.black26)),
//           SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//           SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//           Container(
//             decoration: BoxDecoration(color: Colors.blueGrey.shade50),
//             child: ListTile(
//               leading: SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.17,
//                   child: Stack(children: [
//                     ClipRRect(
//                         borderRadius: BorderRadius.circular(30),
//                         child: CircleAvatar(
//                           radius: 30,
//                           child: Padding(
//                             padding: const EdgeInsets.all(4.0),
//                             child: CircleAvatar(
//                                 radius: 30,
//                                 backgroundColor: Colors.white,
//                                 child: Image.asset(Assets.boxer)),
//                           ),
//                         )),
//                     const Positioned(
//                             top: 27,
//                             bottom: 0,
//                             child: SizedBox(
//                                 width: 30,
//                                 child: CircleAvatar(
//                                     backgroundColor: Colors.white,
//                                     child: Padding(
//                                         padding: EdgeInsets.all(2.0),
//                                         child: CircleAvatar(
//                                             backgroundColor: Colors.black87,
//                                             child: Icon(Icons.history,
//                                                 color: Colors.white,
//                                                 size: 15))))))
//                         .animate(
//                             delay: 500.ms,
//                             onPlay: (controller) => controller.repeat())
//                         .saturate()
//                         .shimmer(
//                             duration: const Duration(seconds: 2),
//                             delay: const Duration(milliseconds: 1000))
//                         .shimmer(
//                             duration: const Duration(seconds: 2),
//                             curve: Curves.easeInOut)
//                   ])),
//               title: Text(
//                   "${widget.data['team0']['fname']}${widget.data['team0']['lname']}"),
//             ),
//           ),
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 2.0),
//               child: Container(
//                   decoration: BoxDecoration(color: Colors.blueGrey.shade50),
//                   child: CupertinoListTile(
//                       title: const Text("Phone"),
//                       trailing: IconButton(
//                           onPressed: () async {
//                             final Uri launchUri = Uri(
//                                 scheme: 'tel',
//                                 path: "${widget.data['team0']['phone']}");
//                             await launchUrl(launchUri);
//                           },
//                           icon: const Icon(Icons.phone))))),
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 2.0),
//               child: Container(
//                   decoration: BoxDecoration(color: Colors.blueGrey.shade50),
//                   child: CupertinoListTile(
//                       title: const Text("Weight"),
//                       trailing: Text("${widget.data['team0']['weight']} KG")))),
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 2.0),
//               child: Container(
//                   decoration: BoxDecoration(color: Colors.blueGrey.shade50),
//                   child: CupertinoListTile(
//                       title: const Text("Gender"),
//                       trailing: Text("${widget.data['team0']['gender']}")))),
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 2.0),
//               child: Container(
//                   decoration: BoxDecoration(color: Colors.blueGrey.shade50),
//                   child: CupertinoListTile(
//                       title: const Text("Sport Type"),
//                       trailing: Text("${widget.data['team0']['sportType']}")))),
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 2.0),
//               child: Container(
//                   decoration: BoxDecoration(color: Colors.blueGrey.shade50),
//                   child: CupertinoListTile(
//                       title: const Text("Birthday"),
//                       trailing: Text("${widget.data['team0']['birthday']}")))),
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 2.0),
//               child: Container(
//                   decoration: BoxDecoration(color: Colors.blueGrey.shade50),
//                   child: CupertinoListTile(
//                       title: const Text("Address"),
//                       trailing: Text("${widget.data['team0']['address']}")))),
//           /////////////////////////////////////////////////////////////////////////////////////////////////
//           const SizedBox(height: 10),
//           Stack(alignment: Alignment.center, children: [
//             const Divider(thickness: 4),
//             CircleAvatar(child: Image.asset(Assets.vs))
//           ]),
//           const SizedBox(height: 10),
//           Container(
//               decoration: BoxDecoration(color: Colors.blueGrey.shade50),
//               child: ListTile(
//                   leading: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.17,
//                       child: Stack(children: [
//                         ClipRRect(
//                             borderRadius: BorderRadius.circular(30),
//                             child: CircleAvatar(
//                               radius: 30,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(4.0),
//                                 child: CircleAvatar(
//                                     radius: 30,
//                                     backgroundColor: Colors.white,
//                                     child: Image.asset(Assets.boxer)),
//                               ),
//                             )),
//                         const Positioned(
//                                 top: 27,
//                                 bottom: 0,
//                                 child: SizedBox(
//                                     width: 30,
//                                     child: CircleAvatar(
//                                         backgroundColor: Colors.white,
//                                         child: Padding(
//                                             padding: EdgeInsets.all(2.0),
//                                             child: CircleAvatar(
//                                                 backgroundColor: Colors.black87,
//                                                 child: Icon(Icons.history,
//                                                     color: Colors.white,
//                                                     size: 15))))))
//                             .animate(
//                                 delay: 500.ms,
//                                 onPlay: (controller) => controller.repeat())
//                             .saturate()
//                             .shimmer(
//                                 duration: const Duration(seconds: 2),
//                                 delay: const Duration(milliseconds: 1000))
//                             .shimmer(
//                                 duration: const Duration(seconds: 2),
//                                 curve: Curves.easeInOut)
//                       ])),
//                   title: Text(
//                       "${widget.data['team1']['fname']}${widget.data['team1']['lname']}"))),
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 2.0),
//               child: Container(
//                   decoration: BoxDecoration(color: Colors.blueGrey.shade50),
//                   child: CupertinoListTile(
//                       title: const Text("Phone"),
//                       trailing: IconButton(
//                           onPressed: () async {
//                             final Uri launchUri = Uri(
//                                 scheme: 'tel',
//                                 path: "${widget.data['team1']['phone']}");
//                             await launchUrl(launchUri);
//                           },
//                           icon: const Icon(Icons.phone))))),
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 2.0),
//               child: Container(
//                   decoration: BoxDecoration(color: Colors.blueGrey.shade50),
//                   child: CupertinoListTile(
//                       title: const Text("Weight"),
//                       trailing: Text("${widget.data['team1']['weight']} KG")))),
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 2.0),
//               child: Container(
//                   decoration: BoxDecoration(color: Colors.blueGrey.shade50),
//                   child: CupertinoListTile(
//                       title: const Text("Gender"),
//                       trailing: Text("${widget.data['team1']['gender']}")))),
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 2.0),
//               child: Container(
//                   decoration: BoxDecoration(color: Colors.blueGrey.shade50),
//                   child: CupertinoListTile(
//                       title: const Text("Sport Type"),
//                       trailing: Text("${widget.data['team1']['sportType']}")))),
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 2.0),
//               child: Container(
//                   decoration: BoxDecoration(color: Colors.blueGrey.shade50),
//                   child: CupertinoListTile(
//                       title: const Text("Birthday"),
//                       trailing: Text("${widget.data['team1']['birthday']}")))),
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 2.0),
//               child: Container(
//                   decoration: BoxDecoration(color: Colors.blueGrey.shade50),
//                   child: CupertinoListTile(
//                       title: const Text("Address"),
//                       trailing: Text("${widget.data['team1']['address']}")))),
//         ]),
//       ),
//     );
//   }
// }
