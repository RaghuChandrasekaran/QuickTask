import "package:flutter/material.dart";
import "package:quicktask/data/userremotestore.dart";
import "package:quicktask/pages/signinpage.dart";
import "package:quicktask/pages/todolistpage.dart";

class Homepage extends StatelessWidget {
  final UserRemoteStore userRemoteStore = UserRemoteStore();

  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: userRemoteStore.hasUserLogged(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Scaffold(
                body: Center(
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator()),
                ),
              );
            default:
              if (snapshot.hasData && snapshot.data!) {
                return const ToDoListPage();
              } else {
                return const Signinpage();
              }
          }
        });
  }
}
