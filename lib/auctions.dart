import 'package:flutter/material.dart';

class AuctionsPage extends StatefulWidget {
  const AuctionsPage({super.key});

  @override
  State<AuctionsPage> createState() => _AuctionsPageState();
}

class _AuctionsPageState extends State<AuctionsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String searchQuery = "";
  String sortOption = "None"; // 🔸 New: Sort option state

  final List<Map<String, dynamic>> auctions = [
    {
      "title": "Gaming Console",
      "price": "\$299",
      "image": "https://images.unsplash.com/photo-1542751110-97427bbecf20?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
      "status": "LIVE",
    },
    {
      "title": "Laptop",
      "price": "\$1299",
      "image": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8",
      "status": "UPCOMING",
    },
    {
      "title": "Beats Studio Pro Wireless Headphones — Black",
      "price": "\$349.99",
      "image": "https://images.unsplash.com/photo-1580894908361-967195033215?auto=format&fit=crop&w=800&q=80",
      "status": "ENDED",
    },
    {
      "title": "Smartphone",
      "price": "\$849",
      "image": "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9",
      "status": "LIVE",
    },
    {
      "title": "Headphones",
      "price": "\$199",
      "image": "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
      "status": "UPCOMING",
    },
    {
      "title": "Smart Watch",
      "price": "\$249",
      "image": "https://images.unsplash.com/photo-1516557070061-c3d1653fa646",
      "status": "ENDED",
    },
    {
      "title": "4K Smart TV",
      "price": "\$999",
      "image": "https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04",
      "status": "LIVE",
    },
    {
      "title": "Mechanical Keyboard",
      "price": "\$129",
      "image": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8",
      "status": "UPCOMING",
    },
    {
      "title": "Smart Home Speaker",
      "price": "\$129",
      "image": "https://images.unsplash.com/photo-1580894908361-967195033215",
      "status": "ENDED",
    },
    {
      "title": "Wireless Earbuds",
      "price": "\$179",
      "image": "https://images.unsplash.com/photo-1573496529574-be85d6a60704",
      "status": "LIVE",
    },
    {
      "title": "iMac 27\" Retina",
      "price": "\$1999",
      "image": "https://images.unsplash.com/photo-1527443154391-507e9dc6c5cc",
      "status": "LIVE",
    },
    {
      "title": "Portable Power Bank 20000mAh",
      "price": "\$79",
      "image": "https://images.unsplash.com/photo-1593642532973-d31b6557fa68",
      "status": "UPCOMING",
    },
  ];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 🧮 Convert price string like "$299" to double
  double _parsePrice(String price) {
    return double.tryParse(price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
  }

  /// 🧩 Filter + Sort logic
  List<Map<String, dynamic>> _getFilteredItems(String status) {
    final filtered = auctions.where((item) {
      final matchesStatus = item["status"].toUpperCase() == status;
      final matchesSearch = item["title"]
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      return matchesStatus && matchesSearch;
    }).toList();

    if (sortOption == "Low to High") {
      filtered.sort((a, b) => _parsePrice(a["price"]).compareTo(_parsePrice(b["price"])));
    } else if (sortOption == "High to Low") {
      filtered.sort((a, b) => _parsePrice(b["price"]).compareTo(_parsePrice(a["price"])));
    }

    return filtered;
  }

  Widget _buildAuctionCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    item["image"],
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 110,
                      color: Colors.grey[800],
                      child:
                      const Icon(Icons.broken_image, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: item["status"] == "LIVE"
                          ? Colors.red
                          : item["status"] == "UPCOMING"
                          ? Colors.blue
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item["status"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["title"],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  item["price"],
                  style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(String filterStatus) {
    final filteredItems = _getFilteredItems(filterStatus);

    if (filteredItems.isEmpty) {
      return const Center(
        child: Text(
          "No items found",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.82,
      ),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) => _buildAuctionCard(filteredItems[index]),
    );
  }

  /// ⚙️ Bottom sheet filter menu
  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Sort by Price",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.arrow_downward, color: Colors.orange),
                title: const Text("Low to High", style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() => sortOption = "Low to High");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_upward, color: Colors.orange),
                title: const Text("High to Low", style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() => sortOption = "High to Low");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.clear, color: Colors.grey),
                title: const Text("Clear Sort", style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() => sortOption = "None");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        title: const Text(
          "Auctions",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() => searchQuery = value);
                      },
                      decoration: const InputDecoration(
                        prefixIcon:
                        Icon(Icons.search, color: Colors.grey, size: 22),
                        hintText: "Search auctions",
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _showSortOptions,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.tune, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // 🟠 Tab bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              tabs: const [
                Tab(text: "Live Now"),
                Tab(text: "Upcoming"),
                Tab(text: "Ended"),
              ],
            ),
          ),

          // 🧱 TabBarView with filtered + sorted data
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildGrid("LIVE"),
                _buildGrid("UPCOMING"),
                _buildGrid("ENDED"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
