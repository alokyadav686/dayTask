import 'package:daytask/constants/color.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
   bool isChatSelected = true;

  final List<Map<String, String>> chatUsers = [
    {
      "name": "Olivia Anna",
      "message": "Hi, please check the last task, that I...",
      "time": "31 min",
      "avatar": "assets/avatars/avatar1.png",
    },
    {
      "name": "Emna",
      "message": "Hi, please check the last task, that I...",
      "time": "43 min",
      "avatar": "assets/avatars/avatar2.png",
    },
    {
      "name": "Robert Brown",
      "message": "Hi, please check the last task, that I...",
      "time": "6 Nov",
      "avatar": "assets/avatars/avatar3.png",
    },
    {
      "name": "James",
      "message": "Hi, please check the last task, that I...",
      "time": "8 Dec",
      "avatar": "assets/avatars/avatar4.png",
    },
    {
      "name": "Sophia",
      "message": "Hi, please check the last task, that I...",
      "time": "27 Dec",
      "avatar": "assets/avatars/avatar5.png",
    },
    {
      "name": "Isabella",
      "message": "Hi, please check the last task, that I...",
      "time": "31 min",
      "avatar": "assets/avatars/avatar6.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
        centerTitle: true,
        title: const Text("Messages", style: TextStyle(color: Colors.white)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.edit, color: Colors.white),
          )
        ],
      ),
      body: Column(
        children: [
          // Toggle Buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isChatSelected = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isChatSelected ? AppColors.buttonColor : Color.fromRGBO(38, 50, 56, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Chat",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isChatSelected ? Colors.black : Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isChatSelected = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !isChatSelected ? AppColors.buttonColor: Color.fromRGBO(38, 50, 56, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Groups",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: !isChatSelected ? Colors.black : Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatUsers.length,
              itemBuilder: (context, index) {
                var user = chatUsers[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(user["avatar"]!),
                  ),
                  title: Text(
                    user["name"]!,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    user["message"]!,
                    style: const TextStyle(color: Colors.white60),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        user["time"]!,
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      const CircleAvatar(radius: 4, backgroundColor: AppColors.buttonColor),
                    ],
                  ),
                );
              },
            ),
          ),


          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: 150,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: () {
                  
                  },
                  child: const Text(
                    "Start chat",
                    style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}