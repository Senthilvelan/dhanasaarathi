import 'package:dhansaarathi/app/utils_res/color_helper.dart';
import 'package:dhansaarathi/app/utils_res/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;

  PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryBlackColorFull,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white), // Logout icon
            onPressed: () {
              // Perform logout action
              Get.defaultDialog(
                title: "Logout",
                middleText: "Are you sure you want to logout?",
                textConfirm: "Yes",
                textCancel: "No",
                confirmTextColor: Colors.white,
                onConfirm: () {
                  Future.delayed(const Duration(milliseconds: 300), () async {
                    await StringHelper.clearPreferenceDataAndGetOff();
                  });
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "$title",
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
