import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:riktam/views/addissue.dart';
import 'package:riktam/views/login.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddIssue());
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () async {
              EasyLoading.show(status: "Logging out...");
              await FirebaseAuth.instance.signOut();
              EasyLoading.dismiss();
              Get.offAll(Login());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
