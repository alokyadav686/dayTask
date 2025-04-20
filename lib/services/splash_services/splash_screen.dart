import 'package:daytask/auth/login_screen.dart';
import 'package:daytask/constants/color.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/logo.png', height: 40),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Day",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Schyler',
                              ),
                            ),
                            TextSpan(
                              text: "Task",
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColors.buttonColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Schyler',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
            
                Image.asset(
                  'assets/images/splash_img.png',
                  // height: 280,
                  width: double.infinity,
                ),
                const SizedBox(height: 10),
            
                // Title Text
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Manage\nyour\nTask with\n",
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Schyler',
                        ),
                      ),
                      TextSpan(
                        text: "DayTask",
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w600,
                          color: AppColors.buttonColor,
                          fontFamily: 'Schyler',
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
            
                // const Spacer(),
            
                SizedBox(height: 10,),
                
                SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      shape: RoundedRectangleBorder(),
                    ),
                    child: const Text(
                      "Let’s Start",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
