import 'package:flutter/material.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Project Details",
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category
              const Text("Design",
                  style: TextStyle(color: Colors.orange, fontSize: 14)),
              const SizedBox(height: 6),

              // Title
              Text(
                project["title"],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Short Description
              Text(
                project["desc"],
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Info Section (Budget, Days, Location, Proposals)
              Card(
                color: Colors.grey[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            const Icon(Icons.monetization_on,
                                color: Colors.green, size: 20),
                            const SizedBox(width: 6),
                            Text(project["budget"],
                                style:
                                const TextStyle(color: Colors.white70)),
                          ]),
                          Row(children: [
                            const Icon(Icons.access_time,
                                color: Colors.orange, size: 20),
                            const SizedBox(width: 6),
                            Text(project["days"],
                                style:
                                const TextStyle(color: Colors.white70)),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            const Icon(Icons.location_on,
                                color: Colors.red, size: 20),
                            const SizedBox(width: 6),
                            Text(project["location"],
                                style:
                                const TextStyle(color: Colors.white70)),
                          ]),
                          Row(children: [
                            const Icon(Icons.people,
                                color: Colors.blue, size: 20),
                            const SizedBox(width: 6),
                            Text(project["proposals"],
                                style:
                                const TextStyle(color: Colors.white70)),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Full Description / Requirements
              const Text("Project Requirements",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text(
                "We need a full redesign of our company website with modern UI/UX. "
                    "The project should include:\n\n"
                    "• Responsive design for mobile and desktop\n"
                    "• SEO optimization\n"
                    "• Fast loading speed\n"
                    "• Clean and professional look\n"
                    "• Integration with contact forms and social media\n\n"
                    "Only experienced designers with a strong portfolio should apply.",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),

              const SizedBox(height: 30),

              // Apply Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Apply for this Project",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
