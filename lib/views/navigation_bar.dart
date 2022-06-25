import 'package:flutter/material.dart';
import 'package:tm_mobile_app/constants/routes.dart';
import 'package:tm_mobile_app/services/auth/auth_service.dart';

class NavBar extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final _name = 'user 1 anak lelaki user';
    final _email = 'user1niboss@abc.com';

    return Drawer(
      child: Material(
        color: Colors.orange[300],
        child: ListView(
          children: <Widget>[
            buildHeader(
              name: _name,
              email: _email,
              // onClicked: null;
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  buildMenuItem(
                    text: 'Dashboard',
                    icon: Icons.dashboard,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 15),
                  buildMenuItem(
                    text: 'Complaint Form',
                    icon: Icons.note,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 15),
                  buildMenuItem(
                    text: 'Complaint Log',
                    icon: Icons.list,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 15),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  buildMenuItem(
                    text: 'Sign Out',
                    icon: Icons.logout,
                    onClicked: () => selectedItem(context, 3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String name,
    required String email,
    // required VoidCallback onClicked,
  }) =>
      InkWell(
        // onTap: onClicked,
        child: Container(
          color: Colors.orange[400],
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          // margin: EdgeInsets.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.black;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: color,
          fontSize: 20,
        ),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).pushNamedAndRemoveUntil(
          dashboardRoute,
          (route) => false,
        );

        break;
      case 1:
        Navigator.of(context).pushNamedAndRemoveUntil(
          complainRoute,
          (route) => false,
        );
        break;
      case 2:
        Navigator.of(context).pushNamedAndRemoveUntil(
          compLogRoute,
          (route) => false,
        );
        break;
      case 3:
        final shouldLogout = await showLogOutDialog(context);
        if (shouldLogout) {
          await AuthService.firebase().logOut();
          Navigator.of(context).pushNamedAndRemoveUntil(
            loginRoute,
            (_) => false,
          );
        }
        break;
    }
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Log Out')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
