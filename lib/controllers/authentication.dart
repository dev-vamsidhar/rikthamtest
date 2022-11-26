import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:riktam/views/navigation.dart';
import 'package:riktam/views/navigation/home.dart';

class AuthenticationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future checkuser() async {}
  Future login(email, password) async {
    EasyLoading.show(status: "loading...");
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      EasyLoading.dismiss();
      if (credential.user != null) {
        //signin sucessfull
        Get.offAll(Navigation());
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showToast(e.message.toString(),
          toastPosition: EasyLoadingToastPosition.bottom);
      print(e);
    }
  }

  Future signup(String email, String password, String username) async {
    EasyLoading.show(status: "loading...");
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      ;
      if (credential.user != null) {
        //signin sucessfull
        await FirebaseAuth.instance.currentUser?.updateDisplayName(username);
        await saveuser(email, username);
        EasyLoading.dismiss();
        Get.offAll(Navigation());
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showToast(e.message.toString(),
          toastPosition: EasyLoadingToastPosition.bottom);
      print(e);
    }
  }

  Future saveuser(String email, String username) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid.toString();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set({"uid": uid, "email": email, "username": username});
  }
}
