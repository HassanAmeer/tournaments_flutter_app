import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/homepage.dart';

class AdminAuthProviderC extends ChangeNotifier {
  CollectionReference sportTypes =
      FirebaseFirestore.instance.collection('adminAuth');

  List adminAuthDataList = [];

  updateAdminAuthF(context, {dynamic mapData = const {}}) async {
    try {
      await sportTypes.doc("adminID").update(mapData).then((value) async {
        await getAdminAuthF();
        // debugPrint("👉 addSportTypesF:$value")
      });
      notifyListeners();
    } catch (e) {
      debugPrint("💥 try catch updateAdminAuthF:$e");
      notifyListeners();
    }
  }

  Future<void> getAdminAuthF() async {
    try {
      var checkData = await sportTypes.doc("adminID").get();
      if (checkData.data().toString().isNotEmpty) {
        if (adminAuthDataList.isNotEmpty) {
          adminAuthDataList.clear();
        }
        adminAuthDataList.add(checkData.data());
        // debugPrint("👉 getSportTypesList:${getSportTypesList[0].id}");
        // debugPrint("👉 getSportTypesList:${adminAuthDataList[0]}");
      }
      notifyListeners();
    } catch (e) {
      notifyListeners();
      debugPrint("💥 try catch getAdminAuthF:$e");
    }
  }

  Future<void> matchAdminAuthF(context,
      {required String email, required String password}) async {
    try {
      var checkData = await sportTypes.doc("adminID").get();
      if (checkData.exists) {
        if (adminAuthDataList.isNotEmpty) {
          adminAuthDataList.clear();
        }
        adminAuthDataList.add(checkData.data());
        // var checkDataAuth =  checkData.data();
        if (adminAuthDataList[0]['email'].toString().toLowerCase() ==
                email.toLowerCase() &&
            adminAuthDataList[0]['password'].toString().toLowerCase() ==
                password.toLowerCase()) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Wrong Details'),
              action: SnackBarAction(label: 'Undo', onPressed: () {})));
        }
      }
      notifyListeners();
    } catch (e) {
      notifyListeners();
      debugPrint("💥 try catch getAdminAuthF:$e");
    }
  }
}
