import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeProviderC extends ChangeNotifier {
  bool isLoading = false;
  List coachesList = [];
  List allTeamsOfCoaches = [];

  getCoachesF(context) async {
    try {
      isLoading = true;
      notifyListeners();
      var getData = await FirebaseFirestore.instance.collection("users").get();
      coachesList = getData.docs;
      isLoading = false;
      notifyListeners();
    } catch (error, stackTrace) {
      isLoading = false;
      notifyListeners();
      debugPrint("💥 try catch when getCoachesF error: Error: $error");
      debugPrint("💥 try catch stackTrace getCoachesF: $stackTrace");
    }
  }

  //////////////////////////////////////////////////////////////
}
