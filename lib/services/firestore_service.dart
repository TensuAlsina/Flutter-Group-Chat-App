import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  final _firebaseFirestore = FirebaseFirestore.instance;
  Future<void> putMessageToFirebase({
    required String senderEmail,
    required String messageToSend,
  }) async {
    await _firebaseFirestore.collection("messages").add(
      {
        "text": messageToSend,
        "sender": senderEmail,
      },
    );
  }

  Stream<QuerySnapshot> messageStream() {
    return _firebaseFirestore.collection("messages").snapshots();
  }
}
