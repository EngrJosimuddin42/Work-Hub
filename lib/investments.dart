import 'package:flutter/material.dart';
import 'investment_details.dart';
import 'filter.dart';

class InvestmentsPage extends StatefulWidget {
  const InvestmentsPage({super.key});

  @override
  State<InvestmentsPage> createState() => _InvestmentsPageState();
}

class _InvestmentsPageState extends State<InvestmentsPage> {
  final List<Map<String, dynamic>> investments = [
    {
      "title": "Stocks",
      "category": "Equity",
      "shortDesc": "Track and manage your stock portfolio with real-time updates.",
      "fullDesc":
      "Invest in top companies' stocks with detailed analytics, risk management, and long-term growth potential.",
      "amount": "\$1,000 - \$50,000",
      "roi": "10% p.a.",
      "duration": "1-3 years",
      "investors": "500",
      "icon": Icons.trending_up,
      "color": Colors.green,
    },
    {
      "title": "Mutual Funds",
      "category": "Diversified",
      "shortDesc": "Diversified investment plans for long-term savings.",
      "fullDesc":
      "Invest in mutual funds across sectors to balance risk and reward. Monthly updates and insights provided.",
      "amount": "\$500 - \$20,000",
      "roi": "8% p.a.",
      "duration": "2-5 years",
      "investors": "300",
      "icon": Icons.savings,
      "color": Colors.blue,
    },
    {
      "title": "Crypto",
      "category": "Digital",
      "shortDesc": "Bitcoin, Ethereum & more digital currencies.",
      "fullDesc":
      "High-risk, high-reward digital currency investments. Includes wallet management and crypto market analysis.",
      "amount": "\$200 - \$10,000",
      "roi": "15% p.a.",
      "duration": "1-2 years",
      "investors": "250",
      "icon": Icons.currency_bitcoin,
      "color": Colors.orange,
    },
    {
      "title": "Coming Soon",
      "category": "Locked",
      "shortDesc": "This feature is not available yet.",
      "fullDesc": "Stay tuned for new investment opportunities coming soon.",
      "amount": "-",
      "roi": "-",
      "duration": "-",
      "investors": "-",
      "icon": Icons.lock,
      "color": Colors.grey,
    },
  ];

  List<Map<String, dynamic>> filteredInvestments = [];

  @override
  void initState() {
    super.initState();
    filteredInvestments = investments;
  }

  void _filterInvestments(String query) {
    final results = investments.where((inv) {
      final title = inv["title"].toLowerCase();
      final desc = inv["shortDesc"].toLowerCase();
      final input = query.toLowerCase();
      return title.contains(input) || desc.contains(input);
    }).toList();

    setState(() {
      filteredInvestments = results;
    });
  }

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
        ),actions: [
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
        title:const Text("Investments", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Search Box
            TextField(
              decoration: InputDecoration(
                hintText: "Search Investment",
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
              onChanged: _filterInvestments,
            ),
            const SizedBox(height: 16),

            // Investment List
            Expanded(
              child: ListView.builder(
                itemCount: filteredInvestments.length,
                itemBuilder: (context, index) {
                  final inv = filteredInvestments[index];
                  return InvestmentCard(inv: inv);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================== Investment Card =========================
class InvestmentCard extends StatelessWidget {
  final Map<String, dynamic> inv;
  const InvestmentCard({super.key, required this.inv});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: inv['color'],
              child: Icon(inv['icon'], color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                inv["title"],
                style: const TextStyle(
                    color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ]),
          const SizedBox(height: 8),
          Text(inv["shortDesc"], style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 12),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: inv['title'] == "Coming Soon"
                  ? null
                  : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InvestmentDetailsPage(investment: inv),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                inv['title'] == "Coming Soon" ? Colors.grey : Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
              ),
              child: const Text("View Details"),
            ),
          ),
        ],
      ),
    );
  }
}