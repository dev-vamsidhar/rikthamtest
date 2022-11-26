import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:riktam/controllers/issuecontroller.dart';
import 'package:riktam/views/navigation/addissue.dart';
import 'package:riktam/views/authentication/login.dart';
import 'package:riktam/views/navigation/myposts.dart';
import 'package:riktam/views/post.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IssueController issueController = Get.put(IssueController());
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () async {
              EasyLoading.show(
                status: "Logging out...",
              );
              await FirebaseAuth.instance.signOut();
              EasyLoading.dismiss();
              Get.offAll(Login());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: GetBuilder<IssueController>(builder: (_) {
        return ListView.builder(
          itemCount: issueController.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return issueController.docs[index]['uid'] != uid
                ? post(
                    issueController.docs[index].data()['like'],
                    issueController.docs[index].data()['comments'],
                    issueController.docs[index].data()['description'],
                    issueController.docs[index].data()['location'],
                    issueController.docs[index].data()['date'],
                    issueController.docs[index].data()['urls'],
                    issueController.docs[index].data(),
                    issueController.docs[index].id)
                : Container();
          },
        );
      }),
    );
  }

  Widget post(int likes, List comments, String description, String location,
      String date, List imagelink, Map<String, dynamic> data, String id) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    IssueController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.indigo[50], borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imagelink.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 200,
                        child: Image.network(
                          imagelink[index],
                          fit: BoxFit.fill,
                        )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 30,
                  child: Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (!data['likedby'].contains(uid)) {
                            controller.getallissues();
                            controller.update();
                            controller.addlike(id, data['likedby']);
                          }
                        },
                        child: Icon(
                          data['likedby'].contains(uid)
                              ? Icons.thumb_up
                              : Icons.thumb_up_outlined,
                          color: Colors.indigo,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        likes.toString(),
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.message_outlined,
                        color: Colors.indigo,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        comments.length.toString(),
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(PostView(
                        data: data,
                        id: id,
                      ));
                    },
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.indigo[300],
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "View",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
