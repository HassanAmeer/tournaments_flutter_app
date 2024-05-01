import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SportTypesC with ChangeNotifier {
  List<dynamic> getSportTypesList = [];

  CollectionReference sportTypes =
      FirebaseFirestore.instance.collection('sportTypes');

  Future<void> addSportTypesF(value) async {
    try {
      await sportTypes.add({"title": value}).then(
          (value) => debugPrint("👉 addSportTypesF:$value"));
      notifyListeners();
      await getSportTypesF();
    } catch (e) {
      debugPrint("💥 try catch addSportTypesF:$e");
      notifyListeners();
    }
  }

  Future<void> getSportTypesF() async {
    try {
      var getList = await sportTypes.get();
      if (getList.docs.isNotEmpty) {
        getSportTypesList.clear();
        getSportTypesList = getList.docs;

        // debugPrint("👉 getSportTypesList:${getSportTypesList[0].id}");
        // debugPrint("👉 getSportTypesList:${getSportTypesList[0]tiitle}");
      }
      notifyListeners();
    } catch (e) {
      notifyListeners();
      debugPrint("💥 try catch getSportTypesF:$e");
    }
  }

  Future<void> deleteSportTypesF(id, context) async {
    try {
      await sportTypes.doc(id).delete().then((value) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('deleted!'),
            duration: const Duration(seconds: 5),
            action: SnackBarAction(label: 'Ok', onPressed: () {})));
      });
      notifyListeners();
      await getSportTypesF();
    } catch (e) {
      notifyListeners();
      debugPrint("💥 try catch add sport type:$e");
    }
  }
}
