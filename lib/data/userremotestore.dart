import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:quicktask/pages/signinpage.dart';
import 'package:quicktask/pages/todolistpage.dart';
import 'package:quicktask/widgets/message.dart';

class UserRemoteStore {

  Future<ParseUser?> getCurrentUser() async {
    return await ParseUser.currentUser() as ParseUser?;
  }

  Future<ParseACL> getACL() async {
    ParseUser? currentUser = await getCurrentUser();
    if (currentUser == null) {
      throw Exception('User is not logged in');
    }
     final ParseACL parseACL = ParseACL();
    if(currentUser.objectId != null){
       String objectId = currentUser.objectId!;
       parseACL.setReadAccess(userId: objectId ,allowed: true);
       parseACL.setWriteAccess(userId: objectId , allowed: true);
    }
    //TODO: Returning empty ACL for now
    return parseACL;
  }

  Future<bool> hasUserLogged() async {
    ParseUser? currentUser = await getCurrentUser();
    if (currentUser == null) {
      return false;
    }
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }

  void doUserLogin(String username, String password, BuildContext context,
      VoidCallback successCallback) async {
    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {
      successCallback();
    } else {
      Message.showError(context: context, message: response.error!.message);
    }
  }

  void doUserLogout(BuildContext context) async {
    ParseUser? currentUser = await getCurrentUser();
    var response = await currentUser!.logout();
    if (response.success) {
      Message.showSuccess(
          context: context,
          message: 'User was successfully logout!',
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Signinpage()),
              (Route<dynamic> route) => false,
            );
          });
    } else {
      Message.showError(context: context, message: response.error!.message);
    }
  }

  void doUserRegistration(String username, String email, String password,
      BuildContext context) async {
    final user = ParseUser.createUser(username, password, email);

    var response = await user.signUp();

    if (response.success) {
      Message.showSuccess(
          context: context,
          message: 'User was successfully created!',
          onPressed: () async {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ToDoListPage()),
              (Route<dynamic> route) => false,
            );
          });
    } else {
      Message.showError(context: context, message: response.error!.message);
    }
  }

  void doUserResetPassword(String email, BuildContext context) async {
    final ParseUser user = ParseUser(null, null, email);
    final ParseResponse parseResponse = await user.requestPasswordReset();
    if (parseResponse.success) {
      Message.showSuccess(
          context: context,
          message: 'Password reset instructions have been sent to email!',
          onPressed: () {
            Navigator.of(context).pop();
          });
    } else {
      Message.showError(
          context: context, message: parseResponse.error!.message);
    }
  }
}
