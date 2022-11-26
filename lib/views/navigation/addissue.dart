import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riktam/controllers/issuecontroller.dart';
import 'package:riktam/controllers/navigationcontroller.dart';

class AddIssue extends StatefulWidget {
  AddIssue({super.key});

  @override
  State<AddIssue> createState() => _AddIssueState();
}

class _AddIssueState extends State<AddIssue> {
  List<XFile> selectedfiles = [];
  TextEditingController location = TextEditingController();
  TextEditingController date =
      TextEditingController(text: DateTime.now().toString());
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Add civic issue",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  selectedfiles = await ImagePicker().pickMultiImage();
                  setState(() {});
                },
                child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.indigo[100],
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 80,
                          color: Colors.white,
                        ),
                        Text(
                          "Upload multiple files",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.indigo[50],
                    borderRadius: BorderRadius.circular(10)),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedfiles.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(selectedfiles);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                              child:
                                  Image.file(File(selectedfiles[index].path))),
                          InkWell(
                            onTap: () {
                              selectedfiles.removeAt(index);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                maxLines: null,
                controller: description,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon:
                        Icon(Icons.description_outlined, color: Colors.indigo),
                    label: Text("Description about the issue")),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: location,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon:
                        Icon(Icons.location_on_outlined, color: Colors.indigo),
                    label: Text("Location(Address)")),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  DateTime? datetime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now());
                  date.text = datetime.toString();
                },
                child: AbsorbPointer(
                  absorbing: true,
                  child: TextField(
                    enabled: false,
                    controller: date,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.date_range_outlined,
                            color: Colors.indigo),
                        label: Text("Date - Time")),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  NavigationController navigationcontroller = Get.find();

                  FocusManager.instance.primaryFocus?.unfocus();
                  await IssueController().uploadissue(selectedfiles,
                      description.text, location.text, date.text);
                  await IssueController().getallissues();
                  navigationcontroller.index.value = 2;
                  navigationcontroller.update();
                  selectedfiles = [];
                  description.clear();
                  EasyLoading.showToast("Civic issue added");
                  location.clear();
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        "create",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
