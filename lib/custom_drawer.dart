import 'package:flutter/material.dart';
import 'settings.dart';
import 'change_password.dart';
import 'language.dart';
import 'login.dart';

class CustomDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey; // Drawer control

  const CustomDrawer({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100,
            color: Colors.orange,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 10),
                const Text(
                  "Menu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Settings
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.orange, // optional
              child: Icon(Icons.settings, color: Colors.white),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
            title: const Text("Settings & privacy", style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SettingsPage(scaffoldKey: scaffoldKey),
                ),
              );
            },
          ),
          // Change Password
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.lock, color: Colors.white),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
            title: const Text("Change password", style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChangePasswordPage(scaffoldKey: scaffoldKey),
                ),
              );
            },
          ),
          // Language
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.public, color: Colors.white),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
            title: const Text("Language", style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LanguagePage(scaffoldKey: scaffoldKey),
                ),
              );
            },
          ),
          // Other Items
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.help, color: Colors.white),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
            title: const Text("Help & support", style: TextStyle(color: Colors.black)),
            onTap: () {},
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.info_outline, color: Colors.white),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
            title: const Text("About app", style: TextStyle(color: Colors.black)),
            onTap: () {},
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.description_outlined, color: Colors.white),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
            title: const Text("Terms & condition", style: TextStyle(color: Colors.black)),
            onTap: () {},
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.feedback, color: Colors.white),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
            title: const Text("Give feedback", style: TextStyle(color: Colors.black)),
            onTap: () {},
          ),
          // Log Out
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.logout, color: Colors.white),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
            title: const Text("Log Out", style: TextStyle(color: Colors.black)),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Log Out?"),
                  content: const Text("Are you sure you want to log out?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text("Log Out"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
