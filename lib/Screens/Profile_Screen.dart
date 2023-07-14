import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_project/Screens/signin.dart';
import 'package:home_automation_project/widgets/settings.dart';
import 'package:home_automation_project/widgets/text_form.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../constants/local_notification.dart';
import '../widgets/common_Button.dart';
import '../widgets/profile_items.dart';
import '../widgets/small_Container.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const routename = '/profile';

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
        
      
      });
       await databaseReference
              .child('admin')
              .child(_user!.uid)
              .set({
            'email': _user!.email,
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
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          // padding: EdgeInsets.all(25),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
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
                "${_user?.displayName ?? 'Unknown'}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              ProfileItems(
                title: " Home",
                icon: LineAwesomeIcons.home,
                onpress: () {
                  Navigator.of(context).pop();
                },
                endIcon: true,
              ),
              ProfileItems(
                title: "Edit Profile",
                icon: LineAwesomeIcons.layer_group,
                onpress: () {
                  setState(() {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (_) => SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    smallContainer(),
                                    SizedBox(
                                      height: 20,
                                    ),
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
                                        textForValidation: " new email please ",
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
                                  ],
                                ),
                              ),
                            ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30)),
                        ));
                  });
                },
                endIcon: true,
              ),
              ProfileItems(
                title: " Information",
                icon: LineAwesomeIcons.book,
                onpress: () {},
                endIcon: true,
              ),
              GestureDetector(
                onTap: () {
                
                },
                child: ProfileItems(
                  title: " Logout ",
                  icon: LineAwesomeIcons.alternate_sign_out,
                  onpress: () {  setState(() {
                    FirebaseAuth.instance.signOut();
                  });
                  Navigator.of(context)
                      .pushReplacementNamed(SignInPage.routename);},
                  endIcon: false,
                  textcolor: Colors.red,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
