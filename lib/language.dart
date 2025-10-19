import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const LanguagePage({super.key, required this.scaffoldKey});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String _selectedLanguage = "English";

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('selectedLanguage') ?? 'English';
    });
  }

  Future<void> _saveLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', lang);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Language"),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
            Future.delayed(const Duration(milliseconds: 300), () {
              widget.scaffoldKey.currentState?.openDrawer();
            });
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          RadioListTile<String>(
            title: const Text("English"),
            value: "English",
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() => _selectedLanguage = value!);
            },
          ),
          RadioListTile<String>(
            title: const Text("বাংলা"),
            value: "বাংলা",
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() => _selectedLanguage = value!);
            },
          ),
          RadioListTile<String>(
            title: const Text("हिंदी"),
            value: "হिंदी",
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() => _selectedLanguage = value!);
            },
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              onPressed: () async {
                if (!mounted) return;
                await _saveLanguage(_selectedLanguage);
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Language changed to $_selectedLanguage ✅",
                      textAlign: TextAlign.center,
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text("Save", style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
