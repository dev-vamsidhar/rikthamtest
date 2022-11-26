import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:get/state_manager.dart';

class FileController extends GetxController {
  Future uploadfile(File file) async {
    final storageRef = FirebaseStorage.instance.ref();
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    Reference mountainsRef = storageRef.child("$time.jpg");
    UploadTask task = mountainsRef.putFile(file);
    task.whenComplete(() async {
      String url = await mountainsRef.getDownloadURL();
      await saveurl(url);
    });
  }

  Future saveurl(String url) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid.toString();
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set({"url": url}, SetOptions(merge: true));
  }
}
