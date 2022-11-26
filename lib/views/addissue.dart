import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddIssue extends StatefulWidget {
  AddIssue({super.key});

  @override
  State<AddIssue> createState() => _AddIssueState();
}

class _AddIssueState extends State<AddIssue> {
  List<XFile> selectedfiles = [];
  TextEditingController location = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
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
                height: 10,
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
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now());
                },
                child: AbsorbPointer(
                  absorbing: true,
                  child: TextField(
                    enabled: false,
                    controller: location,
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
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(),
                  child: Text("create"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
