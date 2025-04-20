import 'package:daytask/auth/signup_screen.dart';
import 'package:daytask/components/navigationBar/bottomNavBar.dart';
import 'package:daytask/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/logo.png', height: 60),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Day',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Schyler',
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: 'Task',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Schyler',
                              color: Color(0xFFF5C85B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              buildTextField("Email Address"),

              const SizedBox(height: 10),

              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email, color: Colors.white),
                  hintText: 'Email Address',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: AppColors.lightBlue,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              buildTextField("Password"),
              const SizedBox(height: 10),

              TextField(
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  suffixIcon: const Icon(
                    Icons.visibility_off,
                    color: Colors.white,
                  ),
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: AppColors.lightBlue,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: AppColors.deepBlueText),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Bottomnavbar()));
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.deepBlueText)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Or continue with',
                      style: TextStyle(color: AppColors.deepBlueText),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppColors.deepBlueText)),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 65,
                child: OutlinedButton.icon(
                  icon: SvgPicture.asset(
                    'assets/images/google.svg',
                    height: 24,
                    width: 24,
                  ),
                  label: const Text(
                    'Google',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),

              const SizedBox(height: 10),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: "Don’t have an account? ",
                      style: TextStyle(color: Colors.white70),
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style: TextStyle(color: AppColors.buttonColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

buildTextField(String name) {
  return Text(
    name,
    style: TextStyle(
      color: AppColors.deepBlueText,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );
}
