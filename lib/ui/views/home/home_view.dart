import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) => viewModel.getLoggedInUser(),
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Chat"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: model.logOutUser, icon: const Icon(Icons.logout)),
            ],
          ),
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: model.myStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final messages = snapshot.data!.docs.reversed;
                                List<MessageContainer> messageWidgets = [];
                                for (var message in messages) {
                                  final messageText = message.get("text");
                                  final messageSender = message.get("sender");
                                  final currentUser = model.user.email;

                                  final messageWidget = MessageContainer(
                                    sender: messageSender,
                                    text: messageText,
                                    isMe: currentUser == messageSender,
                                  );
                                  messageWidgets.add(messageWidget);
                                }

                                return Expanded(
                                    child: ListView(
                                  reverse: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  children: messageWidgets,
                                ));
                              }
                              return const Text("");
                            }),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                                child: TextField(
                              controller: model.messageController,
                              // onChanged: model.onChange,
                              decoration: const InputDecoration(
                                  hintText: "New Message...",
                                  border: InputBorder.none),
                            )),
                            TextButton(
                                onPressed: model.addMessageToFireStore,
                                child: const Text(
                                  "Send",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class MessageContainer extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  const MessageContainer(
      {super.key,
      required this.sender,
      required this.text,
      required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            elevation: 5,
            color: isMe ? Colors.indigo[300] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                text,
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black54, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
