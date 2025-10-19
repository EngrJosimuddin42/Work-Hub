import 'package:flutter/material.dart';

class InvestmentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> investment;

  const InvestmentDetailsPage({super.key, required this.investment});

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
        title: const Text(
          "Investment Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  investment["category"],
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                investment["title"],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Short Description
              Text(
                investment["shortDesc"],
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Info Card Section
              Card(
                color: Colors.grey[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _infoRow(Icons.attach_money, "Amount", investment["amount"], Colors.green),
                      const SizedBox(height: 12),
                      _infoRow(Icons.show_chart, "ROI", investment["roi"], Colors.blue),
                      const SizedBox(height: 12),
                      _infoRow(Icons.timer, "Duration", investment["duration"], Colors.orange),
                      const SizedBox(height: 12),
                      _infoRow(Icons.person, "Investors", investment["investors"], Colors.purple),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Full Description
              const Text(
                "Investment Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                investment["fullDesc"],
                style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.5),
              ),
              const SizedBox(height: 30),

              // Invest Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.orange.shade700,
                    shadowColor: Colors.orangeAccent,
                    elevation: 6,
                  ),
                  child: const Text(
                    "Invest Now",
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value, Color iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(color: Colors.white70)),
          ],
        ),
        Text(value, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
