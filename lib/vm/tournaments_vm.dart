import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TournamentsC with ChangeNotifier {
  List<dynamic> getTournamentsList = [];

  CollectionReference tournamentTypes =
      FirebaseFirestore.instance.collection('tournamentTypes');

  Future<void> addTournamentsF(value) async {
    try {
      await tournamentTypes.add({"title": value}).then(
          (value) => debugPrint("👉 addTournamentsF:value"));
      notifyListeners();
      await getTournamentsF();
    } catch (e) {
      debugPrint("💥 try catch addTournamentsF:$e");
      notifyListeners();
    }
  }

  Future<void> getTournamentsF() async {
    try {
      var getList = await tournamentTypes.get();
      if (getList.docs.isNotEmpty) {
        getTournamentsList.clear();
        getTournamentsList = getList.docs;

        // debugPrint("👉 getTournamentsList:${getTournamentsList[0].id}");
        // debugPrint("👉 getTournamentsList:${getTournamentsList[0]tiitle}");
      }
      notifyListeners();
    } catch (e) {
      notifyListeners();
      debugPrint("💥 try catch getTournamentsF:$e");
    }
  }

  Future<void> deleteTournamentsF(id, context) async {
    try {
      await tournamentTypes.doc(id).delete().then((value) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('deleted!'),
            action: SnackBarAction(label: 'Ok', onPressed: () {})));
      });
      notifyListeners();
      await getTournamentsF();
    } catch (e) {
      notifyListeners();
      debugPrint("💥 try catch addTournamentsF:$e");
    }
  }
}

//// Frankfurt 14.10.2024
//// Hamburg 26.11.2024
//// Berlin 25.05.2024