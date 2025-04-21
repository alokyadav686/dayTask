import 'package:daytask/constants/color.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});
  final List<ChatMessage> messages = [
    ChatMessage(text: "Hi, please check the new task.", isSentByMe: false),
    ChatMessage(text: "Hi, please check the new task.", isSentByMe: true),
    ChatMessage(text: "Got it. Thanks.", isSentByMe: false),
    ChatMessage(
      text: "Hi, please check the last task, that I have completed.",
      isSentByMe: false,
    ),
    ChatMessage(
      imagePath: 'assets/chat_screenshot.png',
      isSentByMe: false,
    ), // You must place the image in assets
    ChatMessage(text: "Got it. Will check it soon.", isSentByMe: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/avatar.png',
              ), // replace with your avatar image
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Olivia Anna", style: TextStyle(color: Colors.white)),
                Text(
                  "Online",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Icon(Icons.call, color: Colors.white),
          SizedBox(width: 15),
          Icon(Icons.videocam, color: Colors.white),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment:
                      message.isSentByMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    padding:
                        message.imagePath != null
                            ? EdgeInsets.zero
                            : EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                    decoration: BoxDecoration(
                      color:
                          message.isSentByMe
                              ? Color(0xFFFFD36A)
                              : Color(0xFF1F2C34),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                        message.imagePath != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                message.imagePath!,
                                width: 200,
                              ),
                            )
                            : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.text ?? "",
                                  style: TextStyle(
                                    color:
                                        message.isSentByMe
                                            ? Colors.black
                                            : Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Seen",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color:
                                        message.isSentByMe
                                            ? Colors.grey[800]
                                            : Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Color(0xFF1F2C34),
            child: Row(
              children: [
                Icon(Icons.apps, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.send, color: Colors.amber),
                SizedBox(width: 8),
                Icon(Icons.mic, color: Colors.amber),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String? text;
  final bool isSentByMe;
  final String? imagePath;

  ChatMessage({this.text, required this.isSentByMe, this.imagePath});
}
