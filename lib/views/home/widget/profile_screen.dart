import 'package:daytask/auth/auth_services.dart';
import 'package:daytask/auth/login_screen.dart';
import 'package:daytask/components/navigationBar/bottomNavBar.dart';
import 'package:daytask/constants/color.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authService = AuthServices();

  void logout() async {
    await authService.signOut();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Bottomnavbar()));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Text("Profile", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // Profile Picture
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(
                    'assets/profile_avatar.png',
                  ), // Add this image to assets
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ],
            ),
            SizedBox(height: 20),

            ProfileTile(icon: Icons.person, label: 'Fazil Laghari'),
            ProfileTile(icon: Icons.email, label: 'fazzzil72@gmail.com'),
            ProfileTile(icon: Icons.lock, label: 'Password'),

            ExpandTile(label: 'My Tasks', icon: Icons.list),
            ExpandTile(label: 'Privacy', icon: Icons.privacy_tip),
            ExpandTile(label: 'Setting', icon: Icons.settings),

            SizedBox(height: 30),

            // Logout Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonColor,
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () => logout(),
              icon: Icon(Icons.logout, color: Colors.black),
              label: Text("Logout", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const ProfileTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: AppColors.lightBlue),
      height: 50,
      child: Row(
        children: [
          Icon(icon, color: AppColors.deepBlueText),
          SizedBox(width: 12),
          Expanded(child: Text(label, style: TextStyle(color: Colors.white))),
          Icon(Icons.edit, color: AppColors.deepBlueText),
        ],
      ),
    );
  }
}

class ExpandTile extends StatelessWidget {
  final String label;
  final IconData icon;

  const ExpandTile({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: AppColors.lightBlue),
      height: 50,
      child: Row(
        children: [
          Icon(icon, color: AppColors.deepBlueText),
          SizedBox(width: 12),
          Expanded(child: Text(label, style: TextStyle(color: Colors.white))),
          Icon(Icons.keyboard_arrow_down, color: AppColors.deepBlueText),
        ],
      ),
    );
  }
}
