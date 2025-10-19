import 'package:flutter/material.dart';
import 'service_details.dart';
import 'Service.dart';
import 'custom_drawer.dart';

class ServicesPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey; // Drawer control

  const ServicesPage({super.key, required this.scaffoldKey});

  final List<Service> services = const [
    Service(
      title: "🌐 Web Development",
      description: "We build modern and responsive websites.",
      imageAsset: "assets/images/web.png",
      gifAsset: "assets/gifs/demo.gif",
      videoAsset: "assets/videos/demo.mp4",
      color: Colors.blue,
    ),
    Service(
      title: "📱 Mobile App Development",
      description: "High performance Android and iOS apps.",
      imageAsset: "assets/images/mobile.png",
      gifAsset: "assets/gifs/demo.gif",
      videoAsset: "assets/videos/demo.mp4",
      color: Colors.green,
    ),
    Service(
      title: "🛒 E-Commerce Solutions",
      description: "Complete online store setup with payment gateway.",
      imageAsset: "assets/images/ecommerce.png",
      gifAsset: "assets/gifs/demo.gif",
      videoAsset: "assets/videos/demo.mp4",
      color: Colors.deepOrange,
    ),
    Service(
      title: "🎨 UI/UX Design",
      description: "Modern and user-friendly design for apps & websites.",
      imageAsset: "assets/images/design.png",
      gifAsset: "assets/gifs/demo.gif",
      videoAsset: "assets/videos/demo.mp4",
      color: Colors.pink,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("My Services"),
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceDetailsPage(service: service),
                  ),
                );
              },
              child: ListTile(
                leading: Image.asset(service.imageAsset, width: 40, height: 40),
                title: Text(
                  service.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(service.description),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
