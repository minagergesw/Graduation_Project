// ignore: file_names
abstract class RoleAuthStates {}

//for SignUp Auth States as Admin
class InitialRoleAuth extends RoleAuthStates {}

class LoadingRoleAuth extends RoleAuthStates {}

class SuccessAdminAuth extends RoleAuthStates {}

class ErrorAdminAuth extends RoleAuthStates {
  late final String message;

  ErrorAdminAuth({required String message});
}

// For SignUp Auth State as User

class LoadingUserRoleAuth extends RoleAuthStates {}

class SuccessUserAuth extends RoleAuthStates {}

class ErrorUserAuth extends RoleAuthStates {
  late final String message;

  ErrorUserAuth({required String message});
}

//check admin State
class changeVisiblity extends RoleAuthStates {}

// sign in states

class SignInAsAdmin extends RoleAuthStates {}

class SignInAsUser extends RoleAuthStates {}

class SignInAsAdminSuccess extends RoleAuthStates {}

class SignInAsUserSuccess extends RoleAuthStates {}

class EmailNotValid extends RoleAuthStates {}

class SignInError extends RoleAuthStates {
  late final String message;

  SignInError({required String message});
}

class addingName extends RoleAuthStates {}
