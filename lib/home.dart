import 'package:flutter/material.dart';
import 'custom_drawer.dart';
import 'services.dart';
import 'profile.dart';
import 'investments.dart';
import 'projects.dart';
import 'auctions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _pages = [
      _buildHomePage(),
      ServicesPage(scaffoldKey: _scaffoldKey),
      ProfilePage(scaffoldKey: _scaffoldKey),
    ];
  }

  /// 🏠 Home Page UI
  Widget _buildHomePage() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text("Work Hub", style: TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white70,
          ),
          drawer: CustomDrawer(scaffoldKey: _scaffoldKey),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFE0B2), Color(0xFFFFFFFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSectionCard(
                  icon: Icons.attach_money,
                  title: "Investments",
                  subtitle: "Develop investment strategy and connect.",
                  page: const InvestmentsPage(),
                ),
                _buildSectionCard(
                  icon: Icons.work,
                  title: "Projects",
                  subtitle: "Post or offer to complete someone else's project.",
                  page: const ProjectsPage(),
                ),
                _buildSectionCard(
                  icon: Icons.gavel,
                  title: "Auctions",
                  subtitle: "Join live product auctions by placing your bid.",
                  page: const AuctionsPage(),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Live Auctions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.orange.shade200, Colors.orange.shade50],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withValues(alpha: 0.2),
                              blurRadius: 5,
                              offset: const Offset(2, 3),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.gavel, size: 50, color: Colors.deepOrange),
                            const SizedBox(height: 10),
                            Text(
                              "Live Auction ${index + 1}",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Text("\$150.0", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Investment Deals",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                Column(
                  children: List.generate(3, (index) {
                    return Card(
                      color: Colors.white,
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.monetization_on, color: Colors.green),
                        title: Text("Deal ${index + 1}"),
                        subtitle: const Text("Special investment opportunity."),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {},
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget page,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepOrange.withValues(alpha: 0.2),
            child: Icon(icon, color: Colors.deepOrange),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          },
        ),
      ),
    );
  }

  /// Bottom NavigationBar Tap
  void _onItemTapped(int index) {
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_work), label: "Work Hub"),
          BottomNavigationBarItem(icon: Icon(Icons.language), label: "Services"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
