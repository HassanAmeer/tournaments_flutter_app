import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';
import '../vm/tournaments_vm.dart';

class TournamentsPage extends StatefulWidget {
  const TournamentsPage({super.key});

  @override
  State<TournamentsPage> createState() => _TournamentsPageState();
}

class _TournamentsPageState extends State<TournamentsPage> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(title: const Text("Tournaments")),
      floatingActionButton: FloatingActionButton(
          backgroundColor: MaterialColors.deepOrange.shade300,
          onPressed: () {
            showCupertinoDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                      title: const Text('Add Tournament'),
                      content: CupertinoTextField(
                        controller: textController,
                      ),
                      actions: [
                        CupertinoButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        CupertinoButton(
                            onPressed: () {
                              if (textController.text.isNotEmpty) {
                                Provider.of<TournamentsC>(context,
                                        listen: false)
                                    .addTournamentsF(textController.text);
                              }
                              Navigator.pop(context);
                            },
                            child: const Text('Add')),
                      ],
                      insetAnimationCurve: Curves.bounceInOut,
                      insetAnimationDuration: const Duration(seconds: 1));
                });
          },
          child: const Icon(Icons.add)),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Consumer<TournamentsC>(builder: (context, vmValue, child) {
          return Column(
            children: [
              Container(
                  decoration:
                      BoxDecoration(color: MaterialColors.deepOrange.shade100),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Total Tournaments"),
                        Text("${vmValue.getTournamentsList.length}")
                      ])),
              /////////////
              ListView.builder(
                itemCount: vmValue.getTournamentsList.length,
                shrinkWrap: true,
                controller: ScrollController(),
                itemBuilder: (BuildContext context, int index) {
                  var data = vmValue.getTournamentsList[index];
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Container(
                          decoration:
                              BoxDecoration(color: Colors.blueGrey.shade50),
                          child: ListTile(
                              leading:
                                  const CircleAvatar(child: Icon(Icons.tour)),
                              title: Text("${data['title']}"),
                              trailing: IconButton(
                                  onPressed: () {
                                    showCupertinoDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CupertinoAlertDialog(
                                            title: const Text('Want to Delete'),
                                            actions: [
                                              CupertinoButton(
                                                  onPressed: () async {
                                                    await vmValue
                                                        .deleteTournamentsF(
                                                            data.id, context);
                                                  },
                                                  child: const Text('yes')),
                                              CupertinoButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('No')),
                                            ],
                                            insetAnimationCurve:
                                                Curves.slowMiddle,
                                            insetAnimationDuration:
                                                const Duration(seconds: 2),
                                          );
                                        });
                                  },
                                  icon: Icon(Icons.delete_forever,
                                      color: Colors.blueGrey.shade300)))));
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
