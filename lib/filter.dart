import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String? selectedCategory;
  RangeValues budgetRange = const RangeValues(500, 5000);
  String? selectedLocation;

  final List<String> categories = [
    "Design",
    "Development",
    "Marketing",
    "Writing",
    "Data Entry"
  ];

  final List<String> locations = [
    "Brooklyn, NY",
    "Los Angeles, CA",
    "Chicago, IL",
    "Houston, TX",
    "Remote"
  ];

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
        title: const Text("Filter Projects",
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Filter
            const Text("Category",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: categories.map((cat) {
                final isSelected = selectedCategory == cat;
                return ChoiceChip(
                  label: Text(cat),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedCategory = isSelected ? null : cat;
                    });
                  },
                  labelStyle: TextStyle(
                      color: isSelected ? Colors.black : Colors.white),
                  selectedColor: Colors.orange,
                  backgroundColor: Colors.grey[800],
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Budget Range Filter
            const Text("Budget Range",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 12),
            RangeSlider(
              values: budgetRange,
              min: 100,
              max: 10000,
              divisions: 50,
              activeColor: Colors.orange,
              inactiveColor: Colors.grey,
              labels: RangeLabels(
                "\$${budgetRange.start.toInt()}",
                "\$${budgetRange.end.toInt()}",
              ),
              onChanged: (values) {
                setState(() {
                  budgetRange = values;
                });
              },
            ),
            const SizedBox(height: 20),

            // Location Filter
            const Text(
              "Location",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              dropdownColor: Colors.grey[900],
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              hint: const Text(
                "Select Location",
                style: TextStyle(color: Colors.white54),
              ),
              initialValue: selectedLocation,
              items: locations
                  .map((loc) => DropdownMenuItem(
                value: loc,
                child: Text(loc),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedLocation = value;
                });
              },
            ),

            const Spacer(),


            // Apply Filter Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    "category": selectedCategory,
                    "budgetRange": budgetRange,
                    "location": selectedLocation,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Apply Filters",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
