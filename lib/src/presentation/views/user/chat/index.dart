import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

import 'features/message.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatView> {
  late DialogFlowtter dialogFlowtter;
  late final TextEditingController _controller;
  late final ScrollController _scrollController;
  bool isLoading = false;

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _scrollController = ScrollController();
    initializeDialogFlowtter();
  }

  Future<void> initializeDialogFlowtter() async {
    try {
      setState(() {
        isLoading = true;
      });
      dialogFlowtter = await DialogFlowtter.fromFile();
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing DialogFlowtter: $e');
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Initialization Error'),
            content: const Text('Failed to initialize DialogFlowtter.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Handle initialization error gracefully
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MessagesScreen(
            messages: messages,
            scrollController: _scrollController,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          color: Colors.transparent,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Escribe un mensage...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    contentPadding: const EdgeInsets.all(12.0),
                  ),
                  onSubmitted: (text) {
                    sendMessage(text);
                    _controller.clear();
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  sendMessage(_controller.text);
                  _controller.clear();
                },
                icon: const Icon(Icons.send),
              )
            ],
          ),
        ),
        if (isLoading) const CircularProgressIndicator(),
      ],
    );
  }

  void sendMessage(String text) async {
    if (text.isEmpty) {
      if (kDebugMode) {
        print('Message is empty');
      }
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      try {
        final response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)),
        );
        if (response.message != null) {
          setState(() {
            addMessage(response.message!);
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error sending message to DialogFlowtter: $e');
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to send message to DialogFlowtter.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Handle error gracefully
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void addMessage(Message message, [bool isUserMessage = false]) {
    setState(() {
      messages.add({'message': message, 'isUserMessage': isUserMessage});
    });
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
