import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:riktam/controllers/issuecontroller.dart';
import 'package:riktam/controllers/navigationcontroller.dart';
import 'package:riktam/views/navigation/addissue.dart';
import 'package:riktam/views/navigation/home.dart';
import 'package:riktam/views/navigation/myposts.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

List<Widget> pages = [Home(), AddIssue(), MyPosts()];
int index = 0;
NavigationController controller = Get.put(NavigationController());

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.index.value]),
      bottomNavigationBar: GetBuilder<NavigationController>(builder: (_) {
        return BottomNavigationBar(
            currentIndex: controller.index.value,
            onTap: (i) {
              controller.index.value = i;
              controller.update();
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_card_sharp), label: "Add Issue"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "My Posts")
            ]);
      }),
    );
  }
}
