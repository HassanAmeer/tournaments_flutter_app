import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager/utils/assets.dart';

import '../helpers/dateformat.dart';
import 'colors.dart';

longSheetF(context) {
  int selectedBox = 1;
  String vBy = "Pending";

  TextEditingController dateController = TextEditingController();
  showFlexibleBottomSheet(
    minHeight: 0,
    initHeight: 0.5,
    maxHeight: 1,
    context: context,
    // barrierColor: ThemeHolder.primaryColor
    //     .withOpacity(0.3),
    builder: (BuildContext context, ScrollController scrollController,
        double bottomSheetOffset) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: StatefulBuilder(builder: (context, setState) {
            return ListView(
              controller: scrollController,
              children: [
                const SizedBox(height: 5),
                Center(
                    child: Container(
                        height: 5, width: 50, color: Colors.grey[400])),
                const SizedBox(height: 4),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: CupertinoListTile(
                            backgroundColor: Colors.grey.shade200,
                            leading: Image.asset(
                              Assets.coachProfile,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(Assets.boxer);
                              },
                            ),
                            title: const Text('Name'),
                            trailing: Text('abc'.toString())))),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: CupertinoListTile(
                            backgroundColor:
                                Colors.grey.shade200.withOpacity(0.4),
                            title: const Text('Tornament type'),
                            trailing: Text('abc'.toString())))),
                // Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 4.0),
                //     child: ClipRRect(
                //         borderRadius: BorderRadius.circular(7),
                //         child: CupertinoListTile(
                //             backgroundColor:
                //                 Colors.grey.shade200.withOpacity(0.4),
                //             title: const Text('Sport type'),
                //             trailing: Text('abc'.toString())))),
                Stack(children: [
                  const Divider(color: Colors.black, thickness: 1),
                  Center(
                      child: Container(
                          color: Colors.grey.shade50,
                          child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text('2',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      letterSpacing: 2)))))
                ]),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: CupertinoListTile(
                            backgroundColor: Colors.grey.shade200,
                            leading: Image.asset(
                              Assets.coachProfile,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(Assets.boxer);
                              },
                            ),
                            title: const Text('Name'),
                            trailing: Text('abc'.toString())))),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: CupertinoListTile(
                            backgroundColor:
                                Colors.grey.shade200.withOpacity(0.4),
                            title: const Text('Tornament type'),
                            trailing: Text('abc'.toString())))),
                // Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 4.0),
                //     child: ClipRRect(
                //         borderRadius: BorderRadius.circular(7),
                //         child: CupertinoListTile(
                //             backgroundColor:
                //                 Colors.grey.shade200.withOpacity(0.4),
                //             title: const Text('Sport type'),
                //             trailing: Text('abc'.toString())))),
                const SizedBox(height: 10),
                Stack(children: [
                  const Divider(color: Colors.black, thickness: 1),
                  Center(
                      child: Container(
                          color: Colors.grey.shade50,
                          child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text('Update',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      letterSpacing: 2)))))
                ]),
                const SizedBox(height: 10),
                CupertinoTextField(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2500),
                      );
                      if (picked != null) {
                        setState(() {
                          dateController.text = formatDate(picked);
                        });
                      }
                    },
                    prefix: const Icon(Icons.history),
                    controller: dateController,
                    placeholder: 'Update Playing Date'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("  Status"),
                    Row(
                      children: [
                        const Text("Pending"),
                        Radio.adaptive(
                          value: "Pending",
                          groupValue: vBy,
                          onChanged: (value) {
                            setState(() {
                              vBy = value!;
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
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                vBy == "Done"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            GestureDetector(
                              onTap: () {
                                selectedBox = 1;
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 4,
                                        color: selectedBox == 1
                                            ? MaterialColors.deepOrange
                                            : Colors.blueGrey.shade100)),
                                height:
                                    MediaQuery.of(context).size.width * 0.41,
                                width: MediaQuery.of(context).size.width * 0.41,
                                child: Image.asset(Assets.coach),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  selectedBox = 2;
                                  setState(() {});
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 4,
                                            color: selectedBox == 2
                                                ? MaterialColors.deepOrange
                                                : Colors.blueGrey.shade100)),
                                    height: MediaQuery.of(context).size.width *
                                        0.41,
                                    width: MediaQuery.of(context).size.width *
                                        0.41,
                                    child: Image.asset(Assets.coach)))
                          ])
                    : const SizedBox(height: 0),
                const SizedBox(height: 5),
                vBy == "Done"
                    ? const Text("   Select To Update Wining Match")
                    : const SizedBox(height: 0),
                const SizedBox(height: 10),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                MaterialColors.deepOrange.shade300)),
                        child: const Text("Update",
                            style: TextStyle(color: Colors.white)))),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red.shade700)),
                        child: const Text("Delete",
                            style: TextStyle(color: Colors.white))))
              ],
            );
          }),
        ),
      );
    },
    anchors: [0, 0.6, 1],
    isSafeArea: true,
  );
}
