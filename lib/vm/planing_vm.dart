import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helpers/weightmatch.dart';

class PlaningProviderC extends ChangeNotifier {
  List choosedCoachesForPlaning = [];
  choosedCoachesF(value, context) {
    if (value['teams'].length <= 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('have No Teams')));
    } else if (choosedCoachesForPlaning.contains(value)) {
    } else if (choosedCoachesForPlaning.length < 2) {
      choosedCoachesForPlaning.add(value);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Max 2 Coaches Can be Select')));
    }
    Navigator.pop(context);
    // log(choosedCoachesForPlaning[1]['teams'].toString());
    notifyListeners();
  }

  //// remove item
  removeCoachesF(index, context) {
    choosedCoachesForPlaning.removeAt(index);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Deleted!')));
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////
  String planingDate = "choose";
  updateChooseDateF(planingDateValue) {
    planingDate = planingDateValue.toString();
    notifyListeners();
  }

  List filterdTeamVsTeamList = [];
  filterTeamVsTeamF(context) async {
    try {
      if (filterdTeamVsTeamList.isNotEmpty) {
        filterdTeamVsTeamList.clear();
      }

      choosedCoachesForPlaning[0]['teams'].forEach((element) {
        for (var e2 in choosedCoachesForPlaning[1]['teams']) {
          if (element['gender'].toString().toLowerCase() ==
                  e2['gender'].toString().toLowerCase() &&
              matchWeightF(
                  weight1: int.parse(element['weight'].toString()),
                  weight2: int.parse(e2['weight'].toString())) &&
              !filterdTeamVsTeamList.contains(element) &&
              !filterdTeamVsTeamList.contains(e2)) {
            filterdTeamVsTeamList.add({"team0": element, "team1": e2});
          }
        }
      });

      if (choosedCoachesForPlaning.isNotEmpty) {
        await uploadGeneratedTeamsF(context);
      }
      notifyListeners();
    } catch (e) {
      log("💥 try catch filterTeamVsTeamF:$e");
      notifyListeners();
    }
  }

////////////////////////
  Map<String, dynamic> showCreatedPlansOnly = {};
  CollectionReference genTeams =
      FirebaseFirestore.instance.collection('planing');
  uploadGeneratedTeamsF(context) async {
    try {
      Map<String, dynamic> madeData = {
        "planingDate": planingDate.toString(),
        "winingTeamNo": 1,
        "status": "Pending", // Done
        "coaches": [
          {
            "id": choosedCoachesForPlaning[0]['uid'],
            "request": "Pending",
            "profile": choosedCoachesForPlaning[0]['profile']
          },
          {
            "id": choosedCoachesForPlaning[1]['uid'],
            "request": "Pending",
            "profile": choosedCoachesForPlaning[1]['profile']
          }
        ],
        "teams": filterdTeamVsTeamList
      };
      showCreatedPlansOnly = madeData;

      // log("👉 choosedCoachesForPlaning:$choosedCoachesForPlaning");
      // log("👉 madeData:$madeData");
      // log("👉 showCreatedPlansOnly:$showCreatedPlansOnly");

      await genTeams.add(madeData).then((value) async {
        await getPlaningF(context);
        // debugPrint("👉 uploadGeneratedTeamsF:$value");
      });
      notifyListeners();
    } catch (e) {
      log("💥 try catch uploadGeneratedTeamsF:$e");
      notifyListeners();
    }
  }

  //////////////////////////////////////////////////////////////
  bool isLoading = false;
  List planingList = [];

  getPlaningF(context) async {
    try {
      isLoading = true;
      notifyListeners();
      var getData = await genTeams.get();
      planingList = getData.docs;
      isLoading = false;
      notifyListeners();
    } catch (error, stackTrace) {
      isLoading = false;
      notifyListeners();
      debugPrint("💥 try catch when getCoachesF error: Error: $error");
      debugPrint("💥 try catch stackTrace getCoachesF: $stackTrace");
    }
  }

  deletePlaningF(context, {String id = "abc"}) async {
    try {
      isLoading = true;
      notifyListeners();
      await genTeams.doc(id).delete().then((value) async {
        await getPlaningF(context);
        Navigator.pop(context);
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Deleted'),
          action: SnackBarAction(label: 'Ok!', onPressed: () {})));
      isLoading = false;
      notifyListeners();
    } catch (error, stackTrace) {
      isLoading = false;
      notifyListeners();
      debugPrint("💥 try catch when getCoachesF error: Error: $error");
      debugPrint("💥 try catch stackTrace getCoachesF: $stackTrace");
    }
  }

  updatePlaningF(context,
      {String id = "abc",
      String planingDateString = "after 7 days",
      int winingTeamNoVal = 1,
      String statusVal = "Done"}) async {
    try {
      isLoading = true;
      notifyListeners();
      await genTeams.doc(id).update({
        "planingDate": planingDateString,
        "winingTeamNo": winingTeamNoVal,
        "status": statusVal // Done
      }).then((value) async {
        await getPlaningF(context);
        Navigator.pop(context);
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Updated'),
          action: SnackBarAction(label: 'Ok!', onPressed: () {})));
      isLoading = false;
      notifyListeners();
    } catch (error, stackTrace) {
      isLoading = false;
      notifyListeners();
      debugPrint("💥 try catch when getCoachesF error: Error: $error");
      debugPrint("💥 try catch stackTrace getCoachesF: $stackTrace");
    }
  }
}
