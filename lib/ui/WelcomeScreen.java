import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Gradient (Optional)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.black87],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),

              // Custom Logo
              Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Text(
                      'd',
                      style: TextStyle(
                        fontSize: 120,
                        fontWeight: FontWeight.bold,
                        color:blueMarine,
                      ),
                    ),
                    Positioned(
                      top: -10,
                      child: Icon(
                        Icons.arrow_upward,
                        size: 40,
                        color:blueMarine,
                      ),
                    ),
                  ],
                ),
              ),

              // Welcome Text
              Text(
                "Welcome to\nDhanSaarthi!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 10),

              // Subtitle
              Text(
                "One step closer to smarter\ninvesting. Let's begin!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white54,
                ),
              ),

              Spacer(),

              // Floating Navigation Button
              GestureDetector(
                onTap: () => Get.toNamed('/home'),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:blueMarine,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
