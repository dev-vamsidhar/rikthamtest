import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riktam/controllers/filecontroller.dart';

class IssueController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getallissues();
  }

  Future uploadissue(List<XFile> selectedfiles, String description,
      String location, String datetime) async {
    EasyLoading.show(status: "Creating the issue");
    try {
      FileController filecontroller = Get.put(FileController());
      List imageurls = [];
      String? uid = FirebaseAuth.instance.currentUser?.uid.toString();
      for (var i = 0; i < selectedfiles.length; i++) {
        EasyLoading.show(status: "Uploading file ${i + 1}");
        String url =
            await filecontroller.uploadfile(File(selectedfiles[i].path));
        imageurls.add(url);
      }
      await FirebaseFirestore.instance.collection("issues").doc().set({
        "urls": imageurls,
        "location": location,
        "date": datetime,
        "description": description,
        "uid": uid,
        "like": 0,
        "comments": [],
        "likedby": [],
        "status": "open"
      });
      Get.back();
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
      EasyLoading.showToast("Something went wrong.",
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];
  Future getallissues() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("issues").get();
    docs = snapshot.docs;
    print(docs);
    print("ello");
    update();
    return docs;
  }

  Future addcomment(List comments, String comment, String id) async {
    String? username =
        FirebaseAuth.instance.currentUser?.displayName.toString();
    String datetime = DateTime.now().toString();
    comments
        .add({"comment": comment, "username": username, "datetime": datetime});
    await FirebaseFirestore.instance
        .collection("issues")
        .doc(id)
        .set({"comments": comments}, SetOptions(merge: true));
    update();
  }

  Future changestatus(String status, String id) async {
    EasyLoading.show();
    await FirebaseFirestore.instance
        .collection("issues")
        .doc(id)
        .set({"status": status}, SetOptions(merge: true));
    await getallissues();
    EasyLoading.dismiss();
  }

  Future addlike(String id, List likedby) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    likedby.add(uid);
    FirebaseFirestore.instance
        .collection('issues')
        .doc(id)
        .update({"like": FieldValue.increment(1), "likedby": likedby});
  }

  Future deletepost(String id) async {
    EasyLoading.show(status: "Deleting..");
    await FirebaseFirestore.instance.collection("issues").doc(id).delete();
    await getallissues();
    EasyLoading.dismiss();
    update();
  }
}
