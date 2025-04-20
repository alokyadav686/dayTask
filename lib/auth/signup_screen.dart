import 'package:daytask/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:daytask/constants/color.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool agreedToTerms = false;

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
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
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
                              color: AppColors.buttonColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              buildTextLabel("Full Name"),
              const SizedBox(height: 8),
              buildTextField(
                controller: nameController,
                hintText: "Enter Your Name",
                icon: Icons.person,
              ),

              const SizedBox(height: 16),
              buildTextLabel("Email Address"),
              const SizedBox(height: 8),
              buildTextField(
                controller: emailController,
                hintText: "Enter Your Email",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),
              buildTextLabel("Password"),
              const SizedBox(height: 8),
              buildTextField(
                controller: passwordController,
                hintText: "Password",
                icon: Icons.lock,
                obscureText: true,
                suffixIcon: const Icon(Icons.visibility_off, color: Colors.white),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Checkbox(
                    value: agreedToTerms,
                    checkColor: Colors.black,
                    activeColor: AppColors.buttonColor,
                    onChanged: (value) {
                      setState(() {
                        agreedToTerms = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'I have read & agreed to DayTask ',
                        style: TextStyle(color: Colors.white70),
                        children: [
                          TextSpan(
                            text: 'Privacy Policy,\nTerms & Condition',
                            style: TextStyle(color: AppColors.buttonColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                     if (!agreedToTerms) return;
                     
                  },
                  child: const Text(
                    'Sign Up',
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
                children: const [
                  Expanded(child: Divider(color: AppColors.deepBlueText)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Or continue with',
                      style: TextStyle(color: AppColors.deepBlueText),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.deepBlueText)),
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    
                  },
                ),
              ),

              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.white70),
                      children: [
                        TextSpan(
                          text: "Log In",
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

  Widget buildTextLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: AppColors.deepBlueText,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: AppColors.lightBlue,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
