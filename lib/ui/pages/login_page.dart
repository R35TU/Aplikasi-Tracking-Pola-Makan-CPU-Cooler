import 'package:eatly/ui/pages/personalization_page.dart';
import 'package:flutter/material.dart';
import 'package:eatly/ui/widgets/eatly_button.dart'; // Import reuse widget
import 'package:eatly/ui/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();

  void handleLogin() {
    final String inputName = _nameController.text.trim();

    try {
      // 1. Validasi Defensive sederhana untuk User Experience
      if (inputName.length < 3) {
        throw "Nama minimal 3 karakter ya!";
      }

      // 3. Navigasi ke Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      // Menangani error agar aplikasi tidak crash (Defensive)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Track Your Nutrition,\nSmarter.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            
            // Icon Placeholder
            const Icon(Icons.apple, size: 100, color: Colors.green),
            
            const SizedBox(height: 40),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Enter your name",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
            const SizedBox(height: 20),
            
            // Menggunakan Teknik Code Reuse
            // Menggunakan Teknik Code Reuse
            EatlyButton(
              label: "Get Started",
              onPressed: () {
                final String inputName = _nameController.text.trim();
                
                // Validasi Defensive sederhana (User Experience)
                if (inputName.length >= 3) {
                  // Langsung pindah ke halaman Personalization sambil membawa data nama
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonalizationPage(),
                      // Tips: Data nama bisa dipassing di sini kalau mau, 
                      // tapi untuk sekarang pindah halaman saja dulu agar error hilang.
                    ),
                  );
                } else {
                  // Tampilkan error jika nama kurang dari 3 karakter
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Nama minimal 3 karakter ya!"), 
                      backgroundColor: Colors.red
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}