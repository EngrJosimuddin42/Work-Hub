import 'package:flutter/material.dart';
import 'custom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey; // Drawer control

  const ProfilePage({super.key, required this.scaffoldKey});

  // ফোন কল করার ফাংশন
  Future<void> _makeCall() async {
    final Uri callUri = Uri(scheme: "tel", path: "+8801518380199");
    try {
      await launchUrl(callUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("❌ Could not launch dialer: $e");
    }
  }

  // ইমেইল পাঠানোর ফাংশন
  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: "mailto",
      path: "josimcse@gmail.com",
      query: "subject=Hello&body=How are you?",
    );
    try {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("❌ Could not launch email app: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer(); // Drawer open
          },
        ),
      ),
      drawer: CustomDrawer(scaffoldKey: scaffoldKey),
      body: Center(
        child: Card(
          elevation: 10,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 320,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/aaa.jpg"),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Josim Uddin",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Flutter Developer",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                const Divider(height: 30, thickness: 1),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.teal),
                  title: const Text("+8801518380199"),
                  onTap: _makeCall,
                ),
                ListTile(
                  leading: const Icon(Icons.email, color: Colors.teal),
                  title: const Text("josimcse@gmail.com"),
                  onTap: _sendEmail,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _makeCall,
                      icon: const Icon(Icons.call),
                      label: const Text("Call"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _sendEmail,
                      icon: const Icon(Icons.email),
                      label: const Text("Email"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
