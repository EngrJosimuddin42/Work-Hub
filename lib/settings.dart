import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey; // Drawer control এর জন্য

  const SettingsPage({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings & Privacy"),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context); // SettingsPage বন্ধ হবে
            Future.delayed(const Duration(milliseconds: 300), () {
              scaffoldKey.currentState?.openDrawer(); // drawer auto-open
            });
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.settings)),
            trailing: Icon(Icons.arrow_forward_ios, size: 32),
            title: Text("Settings"),
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.lock)),
            trailing: Icon(Icons.arrow_forward_ios, size: 32),
            title: Text("Privacy checkup"),
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.shield)),
            trailing: Icon(Icons.arrow_forward_ios, size: 32),
            title: Text("Privacy Center"),
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.list)),
            trailing: Icon(Icons.arrow_forward_ios, size: 32),
            title: Text("Activity log"),
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.tune)),
            trailing: Icon(Icons.arrow_forward_ios, size: 32),
            title: Text("Content preferences"),
          ),
        ],
      ),
    );
  }
}
