import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestorePage extends StatefulWidget {
  const CloudFirestorePage({super.key});

  @override
  CloudFirestorePageState createState() {
    return CloudFirestorePageState();
  }
}

class CloudFirestorePageState extends State<CloudFirestorePage> {
  CloudFirestorePageState() {
    getData();
    monitorAuthenticationState();
  }

  // Authentication

  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  void monitorAuthenticationState() {
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        print("CloudFirestore: User logged in");
      } else {
        print("CloudFirestore: User logged out");
      }
      setState(() {
        this.user = user;
      });
    });
  }

  // Data

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void getData() {
    firestore.collection("election").snapshots().listen((querySnapshot) {
      List<QueryDocumentSnapshot> docSnapshots = querySnapshot.docs;
      for (var docSnapshot in docSnapshots) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        if (data["name"] != null) {
          switch (data["name"]) {
            case "cats":
              setState(() {
                catVotes = data["votes"] as int;
              });
              break;
            case "dogs":
              setState(() {
                dogVotes = data["votes"] as int;
              });
              break;
          }
        }
      }
      ;
    });
  }

  int dogVotes = 0;
  int catVotes = 0;

  void addVote(User? user, String selection) {
    firestore.collection("election").doc(selection).set({
      "name": selection,
      "votes": (selection == "dogs" ? dogVotes : catVotes) + 1
    }).then((value) {
      // Success callback
    }).catchError((err) {
      print("Error voting: $err");
    });
  }

  void onDogVote() {
    addVote(user, "dogs");
  }

  void onCatVote() {
    addVote(user, "cats");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Cloud Firestore"),
            backgroundColor: Colors.orange),
        body: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: const Text("Cats or dogs?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 36))),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
              child: Row(children: [
                VoteOption(
                    image: const AssetImage("images/cats.jpg"),
                    title: "Cats",
                    onVote: onCatVote,
                    votes: catVotes),
                VoteOption(
                    image: const AssetImage("images/dogs.jpg"),
                    title: "Dogs",
                    onVote: onDogVote,
                    votes: dogVotes)
              ]),
            )
          ],
        )));
  }
}

class VoteOption extends StatelessWidget {
  const VoteOption(
      {required this.image,
      required this.title,
      required this.onVote,
      required this.votes,
      super.key});

  final ImageProvider image;
  final String title;
  final VoidCallback onVote;
  final int votes;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Column(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(fit: BoxFit.fill, height: 250, image: image)),
          Text(title),
          Text("Votes: $votes"),
          ElevatedButton(
            onPressed: onVote,
            child: const Text('Vote'),
          )
        ]));
  }
}
