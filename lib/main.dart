import 'package:flutter/material.dart';
import 'package:eatly/ui/pages/login_page.dart'; // Pastikan import ini ada

void main() {
  runApp(const EatlyApp());
}

class EatlyApp extends StatelessWidget {
  const EatlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eatly',
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug di pojok kanan
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true, // Biar tampilan lebih modern ala Android terbaru
      ),
      // Ganti home dari HomePage() menjadi LoginPage()
      home: const LoginPage(), 
    );
  }
}