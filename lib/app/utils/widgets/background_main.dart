import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils_res/color_helper.dart';

class MainBackground extends StatelessWidget {
  const MainBackground({Key? key, required this.child, this.back = true})
      : super(key: key);

  final Widget child;

  final bool back;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlackColorFull,
      appBar: AppBar(
        backgroundColor: primaryBlackColorFull,
        elevation: 0,
        leading: back
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              )
            : Container(),
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black87],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
