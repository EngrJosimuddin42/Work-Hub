import 'package:flutter/material.dart';
import 'project_details.dart';
import 'filter.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final List<Map<String, dynamic>> projects = [
    {
      "title": "Website Redesign for Local Business",
      "desc": "Looking for an experienced web designer to revamp our company website.",
      "budget": "\$1,500 - \$3,000",
      "days": "15 Days",
      "location": "Brooklyn, NY",
      "proposals": "10 Proposals",
    },
    {
      "title": "Mobile App Development",
      "desc": "Need a Flutter developer to build a mobile app.",
      "budget": "\$2,000 - \$5,000",
      "days": "20 Days",
      "location": "Queens, NY",
      "proposals": "5 Proposals",
    },
    {
      "title": "Logo Design Project",
      "desc": "Creative designer needed for brand logo design.",
      "budget": "\$300 - \$700",
      "days": "7 Days",
      "location": "Bronx, NY",
      "proposals": "12 Proposals",
    },
  ];

  List<Map<String, dynamic>> filteredProjects = [];

  @override
  void initState() {
    super.initState();
    filteredProjects = projects;
  }

  void _filterProjects(String query) {
    final results = projects.where((project) {
      final title = project["title"].toLowerCase();
      final desc = project["desc"].toLowerCase();
      final input = query.toLowerCase();
      return title.contains(input) || desc.contains(input);
    }).toList();

    setState(() {
      filteredProjects = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        title: const Text("Projects", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FilterPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search Project",
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: _filterProjects,
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: filteredProjects.length,
                itemBuilder: (context, index) {
                  final project = filteredProjects[index];
                  return ProjectCard(project: project);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Map<String, dynamic> project;
  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(project["title"],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(project["desc"], style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const Icon(Icons.monetization_on, color: Colors.green, size: 18),
                const SizedBox(width: 4),
                Text(project["budget"], style: const TextStyle(color: Colors.white70)),
              ]),
              Row(children: [
                const Icon(Icons.access_time, color: Colors.orange, size: 18),
                const SizedBox(width: 4),
                Text(project["days"], style: const TextStyle(color: Colors.white70)),
              ]),
            ],
          ),
          const SizedBox(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const Icon(Icons.location_on, color: Colors.red, size: 18),
                const SizedBox(width: 4),
                Text(project["location"], style: const TextStyle(color: Colors.white70)),
              ]),
              Row(children: [
                const Icon(Icons.people, color: Colors.blue, size: 18),
                const SizedBox(width: 4),
                Text(project["proposals"], style: const TextStyle(color: Colors.white70)),
              ]),
            ],
          ),
          const SizedBox(height: 12),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectDetailsPage(project: project),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("View Details"),
            ),
          )
        ],
      ),
    );
  }
}
