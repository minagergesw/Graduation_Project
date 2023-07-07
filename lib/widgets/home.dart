import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Home2Screen extends StatelessWidget {
 final databaseReference = FirebaseDatabase.instance.ref();
 final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Push Notification'),
        ),
        body: StreamBuilder(
          stream: databaseReference
              .child('users')
              .child(auth.currentUser!.uid)
              .onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              final userData =
                  snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
              return Center(
                child: Text(" Home center"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
}
