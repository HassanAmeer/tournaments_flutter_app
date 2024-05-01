import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../config/config.dart';

class PlaningProviderVersion2C extends ChangeNotifier {
  List choosedCoachesForPlaning = [];

  List filterdTeamVsTeamList = [];
  filterTeamVsTeamF(context,
      {String tournamentType = "",
      String sportType = "",
      String genderIs = "",
      List teams = const []}) async {
    try {
      if (filterdTeamVsTeamList.isNotEmpty) {
        filterdTeamVsTeamList.clear();
      }
      for (var i = 0; i < teams.length; i++) {
        for (var j = i + 1; j < teams.length; j++) {
          var person1 = teams[i];
          var person2 = teams[j];

          if (!filterdTeamVsTeamList.any((team) =>
              team.containsValue(person1) || team.containsValue(person2))) {
            if (matchWeightF(
                weight1: int.parse(person1['weight'].toString()),
                weight2: int.parse(person2['weight'].toString()))) {
              filterdTeamVsTeamList.add({
                "status": "Pending",
                "winTeamNo": "0",
                "team0": person1,
                "team1": person2
              });
            }
          }
        }
      }

      if (filterdTeamVsTeamList.isNotEmpty) {
        await uploadGeneratedTeamsF(context,
            tournamentType: tournamentType,
            sportType: sportType,
            genderIs: genderIs,
            getFilterdTeamVsTeamList: filterdTeamVsTeamList);
      }
      // debugPrint("👉 filterdTeamVsTeamList:$filterdTeamVsTeamList");
      notifyListeners();
    } catch (e) {
      log("💥 try catch filterTeamVsTeamF:$e");
      notifyListeners();
    }
  }

  bool matchWeightF({required int weight1, required int weight2}) {
    return (weight1 - weight2).abs() <= Config.weightArround;
  }

////////////////////////
  // Map<String, dynamic> showCreatedPlansOnly = {};
  CollectionReference genTeams =
      FirebaseFirestore.instance.collection('planing');
  uploadGeneratedTeamsF(context,
      {String tournamentType = " ",
      String sportType = " ",
      String genderIs = " ",
      List getFilterdTeamVsTeamList = const []}) async {
    try {
      Map<String, dynamic> madeData = {
        "tournamentType": tournamentType.toString(),
        "sportType": sportType,
        "genderIs": genderIs,
        "teams": getFilterdTeamVsTeamList
      };
      // showCreatedPlansOnly = madeData;
      bool alreadyHaveTournamnet = planingList.any((element) =>
          element['sportType'].toString().toLowerCase() ==
              sportType.toString().toLowerCase() &&
          element['genderIs'].toString().toLowerCase() ==
              genderIs.toString().toLowerCase());
      if (alreadyHaveTournamnet) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Already Created This Tournament'),
            action: SnackBarAction(label: 'Undo', onPressed: () {})));
      } else {
        await genTeams.add(madeData).then((value) async {
          await getPlaningF(context);
        });
      }
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

  deletePlaningF(context, {String docId = ""}) async {
    try {
      isLoading = true;
      notifyListeners();
      await genTeams.doc(docId).delete().then((value) async {
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

  deletePlaningTeamsOnlyF(context,
      {String docId = "", dynamic planingListRemovedTeams}) async {
    try {
      isLoading = true;
      notifyListeners();

      await genTeams.doc(docId).update(
          {"teams": planingListRemovedTeams.toList()}).then((value) async {
        await getPlaningF(context);
        Navigator.pop(context);
      });

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: const Text('Deleted'),
      //     action: SnackBarAction(label: 'Ok!', onPressed: () {})));
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
      {String id = "abc", List updatedTeams = const []}) async {
    try {
      isLoading = true;
      notifyListeners();
      await genTeams
          .doc(id)
          .update({"teams": updatedTeams}).then((value) async {
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
