import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, textAlign: TextAlign.center)),
    );
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome Back",style: TextStyle(fontWeight: FontWeight.bold),),centerTitle: true,backgroundColor: Colors.deepOrange,automaticallyImplyLeading: false,),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                const Text(
                  "Log in or sign up",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                const Text(
                  "You'll get smarter responses and can upload\nfiles, images, and more.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 30),


                // Email Field
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 15),


                // Password Field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 20),


                // Continue/Login Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      String email = emailController.text.trim();
                      String password = passwordController.text.trim();
                      if (email.isEmpty || password.isEmpty) {
                        showSnackBar("⚠ Please fill all fields");
                      } else if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$')
                          .hasMatch(email)) {
                        showSnackBar("⚠ Please enter a valid email");
                      } else if (password.length < 6) {
                        showSnackBar("⚠ Password must be at least 6 characters");
                      } else {
                        clearFields();
                        Navigator.push(context,MaterialPageRoute(builder: (context) => const HomePage(),),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Login", style: TextStyle(fontSize: 16, color: Colors.white),),
                  ),
                ),
                const SizedBox(height: 30),


                const Text("OR", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 30),


                // Social Login Buttons
                _buildButton(icon: Icons.g_mobiledata,text: "Continue with Google", color: Colors.black,),
                const SizedBox(height: 15),

                _buildButton(icon: Icons.window,text: "Continue with Microsoft Account",color: Colors.black,),
                const SizedBox(height: 15),

                _buildButton(
                  icon: Icons.apple,text: "Continue with Apple",color: Colors.black,),
                const SizedBox(height: 15),

                _buildButton(
                  icon: Icons.phone,text: "Continue with phone",color: Colors.black,),
                const SizedBox(height: 40),


                // Terms & Privacy
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Terms of Use", style: TextStyle(color: Colors.blue,
                        decoration: TextDecoration.underline),),
                    SizedBox(width: 10),
                    Text("|"),
                    SizedBox(width: 10),
                    Text("Privacy Policy",style: TextStyle(color: Colors.blue,
                        decoration: TextDecoration.underline),),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // Reusable Social Button
  static Widget _buildButton({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(30),),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Text(text,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}