import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riktam/controllers/issuecontroller.dart';

class PostView extends StatelessWidget {
  Map<String, dynamic> data;
  String id;
  PostView({super.key, required this.data, required this.id});
  TextEditingController commentcontroller = TextEditingController();
  IssueController issuecontroller = Get.find();
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Post",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    height: 250,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: data['urls'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Image.network(data['urls'][index]),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  )
                ],
              ),
              GetBuilder<IssueController>(builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (!data['likedby'].contains(uid)) {
                            data['likedby'].add(uid);
                            data['like'] += 1;
                            issuecontroller.getallissues();
                            issuecontroller.update();
                            issuecontroller.addlike(id, data['likedby']);
                          }
                        },
                        child: Icon(
                          data['likedby'].contains(uid)
                              ? Icons.thumb_up
                              : Icons.thumb_up_outlined,
                          color: Colors.indigo,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${data['like']}",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data['description']),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Comments",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
              GetBuilder<IssueController>(builder: (_) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: data['comments'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return commentwidget(data, index);
                    },
                  ),
                );
              }),
              SizedBox(
                height: 100,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent),
              child: TextField(
                controller: commentcontroller,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();

                          issuecontroller.addcomment(
                              data['comments'], commentcontroller.text, id);
                          issuecontroller.getallissues();
                          commentcontroller.clear();
                        },
                        child: Icon(Icons.send)),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "start typing...",
                    border: OutlineInputBorder()),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget commentwidget(Map<String, dynamic> data, int index) {
    data = data['comments'][index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(data['username']), Text(data['datetime'])],
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data['comment'],
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
