import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_project/widgets/text_form.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../constants/local_notification.dart';
import '../widgets/common_Button.dart';
import '../widgets/profile_items.dart';
import '../widgets/small_Container.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final _emailController = TextEditingController();
final _nameController = TextEditingController();
//final _emailController = TextEditingController();

class _ProfileScreenState extends State<ProfileScreen> {
  User? _user;
  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  void updateEmail() async {
    try {
      await _user?.updateEmail(_emailController.text);
      setState(() {
        // Update the user object and text controllers with the new values
        _user = FirebaseAuth.instance.currentUser;
        _emailController.text = _user?.email ?? "";
        NotificationService().showNotification(
            body: " Your Email Updated to ${_user!.email}",
            title: " Profile notification");
      });
      print("Email updated successfully");
    } catch (e) {
      print("Error updating profile: $e");
    }
  }

  void updateName() async {
    try {
      await _user?.updateDisplayName(_nameController.text);

      setState(() {
        _user = FirebaseAuth.instance.currentUser;
        _nameController.text = _user?.displayName ?? "";
        NotificationService().showNotification(
            body: " Your Name Updated to ${_user!.displayName}",
            title: " Profile notification");
      });
      print("Name updated successfully");
    } catch (e) {
      print("Error updating profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text('Profile Screen'),
        actions: [Icon(LineAwesomeIcons.moon)],
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset('images/images.jpg'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Name: ${_user?.displayName ?? 'Unknown'}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Email: ${_user?.email ?? 'Unknown'}",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                width: 200,
                child: commonButton(
                    text: "Editing Profile",
                    onpressed: () {
                      setState(() {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) => Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    children: [
                                      smallContainer(),
                                      Center(
                                          child: Text(
                                        " Update Your Information",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Color(0xff0E2954),
                                        ),
                                      )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      textForm(
                                          hintText: " Update Your Email",
                                          textForValidation:
                                              " new email please ",
                                          controller: _emailController),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: commonButton(
                                            onpressed: () {
                                              updateEmail();
                                            },
                                            text: "Update Email"),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      textForm(
                                          hintText: " Update Your name",
                                          textForValidation:
                                              "   new name please ",
                                          controller: _nameController),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: commonButton(
                                            onpressed: () {
                                              updateName();
                                            },
                                            text: "Update Name"),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      commonButton(
                                          onpressed: () {},
                                          text: " Change profile photo"),
                                    ],
                                  ),
                                ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30)),
                            ));
                      });
                    })),
            SizedBox(
              height: 30,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            ProfileItems(
              title: " Home",
              icon: LineAwesomeIcons.home,
              onpress: () {},
              endIcon: true,
            ),
            ProfileItems(
              title: " Devices ",
              icon: LineAwesomeIcons.robot,
              onpress: () {},
              endIcon: true,
            ),
            ProfileItems(
              title: " Members ",
              icon: LineAwesomeIcons.layer_group,
              onpress: () {},
              endIcon: true,
            ),
            ProfileItems(
              title: " Settings ",
              icon: LineAwesomeIcons.cog,
              onpress: () {},
              endIcon: true,
            ),
            ProfileItems(
              title: " information",
              icon: LineAwesomeIcons.book,
              onpress: () {},
              endIcon: true,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  FirebaseAuth.instance.signOut();
                });
              },
              child: ProfileItems(
                title: " Logout ",
                icon: LineAwesomeIcons.alternate_sign_out,
                onpress: () {},
                endIcon: false,
                textcolor: Colors.red,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
