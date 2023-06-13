import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _textEditingController = TextEditingController();
void _sendMessage() async {
  String message = _textEditingController.text.trim();
  if (message.isNotEmpty) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {

      // Get the sender's name from the user's collection
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection("customers").doc(user.uid).get();
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      String senderName = userData["name"];

      await FirebaseFirestore.instance.collection("messages").add({
        "content": message,
        "senderId": user.uid,
        "receiverId":"rVLN9DfYYBaGf0vbNXTHBGIkEu93",
        "role":"user",
        "sender": senderName, // Add the sender's name to the sender field
        "timestamp": FieldValue.serverTimestamp(),
      });
      _textEditingController.clear();
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("messages").orderBy("timestamp").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return MessageBubble(
                      content: data["content"],
                      senderId: data["senderId"],
                      role: data["role"],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class MessageBubble extends StatelessWidget {
  final String content;
  final String senderId;
  final String role;

  MessageBubble({required this.content, required this.senderId, required this.role});

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: role == "user" ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: role == "admin" ? Color.fromARGB(255, 231, 148, 92) : senderId == currentUser?.uid ? Color.fromRGBO(103, 6, 240, 1) : Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                content,
                style: TextStyle(
                  color: role == "admin" ? Colors.black : senderId == currentUser?.uid ? Colors.white : Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}