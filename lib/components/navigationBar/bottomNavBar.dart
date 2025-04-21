import 'package:daytask/constants/color.dart';
import 'package:daytask/dashboard/task_tile.dart';
import 'package:daytask/views/calendar/calendar_screen.dart';
import 'package:daytask/views/chat/chat_screen.dart';
import 'package:daytask/views/home/home_screen.dart';
import 'package:daytask/views/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int currentIndex = 0;
  final _screen = [
    HomeScreen(),
    ChatScreen(),
    Calendar(),
    NotificationScreen(),
  ];
  _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[currentIndex],
      bottomNavigationBar: CustomNavBar(
        selectedIndex: currentIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(color: Color.fromRGBO(38, 50, 56, 1)),
      child: Row(
        children: [
          _buildNavItem("assets/images/home2.svg", "Home", 0),
          _buildNavItem("assets/images/messages1.svg", "Chat", 1),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TaskTile()),
              );
            },
            child: _buildCenterNavItem(),
          ),
          _buildNavItem("assets/images/calendar.svg", "Calendar", 2),
          _buildNavItem("assets/images/notification1.svg", "Notification", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(String iconPath, String label, int index) {
    bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onItemSelected(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 24,
              width: 24,
              color:
                  isSelected ? AppColors.buttonColor : AppColors.navItemColor,
            ),
            SizedBox(height: 4),
            FittedBox(
              child: Text(
                label,
                style: TextStyle(
                  color:
                      isSelected
                          ? AppColors.buttonColor
                          : AppColors.navItemColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterNavItem() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: AppColors.buttonColor),
            child: Icon(
              Icons.add_box_outlined,
              size: 28,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
