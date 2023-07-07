import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../status/authState.dart';

class RoleAuthCubit extends Cubit<RoleAuthStates> {
  RoleAuthCubit() : super(InitialRoleAuth());

  final auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.ref();

  bool hasUsers = false;
  bool isvisible = true;
  bool isvisiblegas = false;

  //handling Sign Up as Admin
  void signUpAsAdmin(
      {required String email,
      required String password,
      required String namee}) async {
    databaseReference.child('admin').onValue.listen((event) async {
      print(event.snapshot.value);
      
        try {
          emit(LoadingRoleAuth());
          final credential = await auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          await databaseReference
              .child('admin')
              .child(credential.user!.uid)
              .set({
            'email': credential.user!.email,
          });

          void submitForm() {
            final String name = namee;
            final userId = FirebaseAuth.instance.currentUser!.uid;
            databaseReference.child('admin/$userId/name').set(name);
          }

          emit(SuccessAdminAuth());
        } catch (error) {
          print('Sign-up error: $error');
          emit(ErrorAdminAuth(message: error.toString()));
        }
       
    });
  }

  // Handling Sign Up As a User

  void signUpAsUser({
    required String email,
    required String password,
    required String namee,
  }) async {
    try {
      emit(LoadingUserRoleAuth());
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Add the user to the "users" node in the database

      // final name = namee;

      //await databaseReference
      //   .child('users/${credential.user!.uid}/name')
      //   .set(name);

      emit(SuccessUserAuth());
    } catch (error) {
      // Handle sign-up errors
      print('Sign-up error: $error');
      emit(ErrorUserAuth(message: error.toString()));
    }
  }

  // check admins data

  bool checkAdmin() {
    databaseReference.child('admin').onValue.listen((event) {
      if (hasUsers = event.snapshot.value != null) {
        isvisible = false;
      } else {
        isvisible = true;
      }
      emit(changeVisiblity());
    }, onError: (Error) {
      print('Error: ${Error.code} ${Error.message}');
    });

    return true;
  }

// control Signing in

// // 1- first method for checking if user is admin or normal user

//   Future<void> checkSignedEmail({required String email}) async {
//     final DatabaseEvent adminsSnapshot = await databaseReference
//         .child('admin')
//         .orderByChild('email')
//         .equalTo(email)
//         .once();
//     final DatabaseEvent usersSnapshot = await databaseReference
//         .child('users')
//         .orderByChild('email')
//         .equalTo(email)
//         .once();
//     if (adminsSnapshot.snapshot.value != null) {
//       emit(SignInAsAdmin());
//       print(" welcome admin");
//     } else if (usersSnapshot.snapshot.value != null) {
//       emit(SignInAsUser());
//       print("welcome user ");
//     } else {
//       emit(EmailNotValid());
//       print(" Sorry, there is an error");
//     }
  // }

// 2- second method for :  after detecting who is admin or user wil sign in as it's role and navigate to it's destination

  void UserSignIn({required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (state is SignInAsAdmin) {
        emit(SignInAsAdminSuccess());
        print("welcome back admin");
      } else {
        emit(SignInAsUserSuccess());
        print("welcome back user");
      }
    } catch (error) {
      emit(SignInError(message: error.toString()));
    }
  }

  void checkisAdmin() async {
    try {
      databaseReference.child('admin').onValue.listen((event) {
        if (FirebaseAuth.instance.currentUser!.email == event.snapshot.value) {
          isvisiblegas = true;
        } else {
          isvisiblegas = false;
        }
      });

      if (state is SignInAsAdmin) {
        emit(SignInAsAdminSuccess());
        print("welcome back admin");
      } else {
        emit(SignInAsUserSuccess());
        print("welcome back user");
      }
    } catch (error) {
      emit(SignInError(message: error.toString()));
    }
  }
}
