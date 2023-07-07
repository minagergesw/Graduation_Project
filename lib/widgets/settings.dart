import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final auth = FirebaseAuth.instance;
final databaseReference = FirebaseDatabase.instance.ref();

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: StreamBuilder(
        stream: databaseReference
            .child('admins')
            .child(auth.currentUser!.uid)
            .onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            final adminData =
                snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            return Center(
              child: Text('Welcome, ${adminData['displayName']}!'),
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
}
