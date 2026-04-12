import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'contact_us_page.dart';
import 'about_us_page.dart';
import 'order_history_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    setState(() {});

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: ListView(
          children: [

            Container(
              width: double.infinity,
              color: const Color(0xFFFF8C42),
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 34,
                      color: Color(0xFFFF8C42),
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    user?.email ?? "Guest User",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  user == null
                      ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFFF8C42),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Login / Register",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  )
                      : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFFF8C42),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    onPressed: logout,
                    child: const Text(
                      "Logout",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            buildMenuItem(
              context,
              Icons.phone,
              "Contact Us",
              const ContactUsPage(),
            ),

            buildMenuItem(
              context,
              Icons.info,
              "About Us",
              const AboutUsPage(),
            ),
            buildMenuItem(
              context,
              Icons.history,
              "Order History",
              const OrderHistoryPage(),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget buildMenuItem(
      BuildContext context,
      IconData icon,
      String title,
      Widget page,
      ) {
    return ListTile(
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 2),

      leading: Icon(
        icon,
        color: Colors.black54,
        size: 24,
      ),

      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black87,
        ),
      ),

      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 18,
        color: Colors.black54,
      ),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => page,
          ),
        );
      },
    );
  }
}