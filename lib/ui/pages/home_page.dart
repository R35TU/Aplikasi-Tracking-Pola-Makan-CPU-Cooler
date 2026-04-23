import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('eatly - Nutrition Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Contoh Widget Progres Kalori
            const Text("Kalori Hari Ini: 1500 / 2000 kkal", 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const LinearProgressIndicator(value: 0.75),
            
            const SizedBox(height: 20),
            
            // Checklist Gizi (Sesuai ide kamu tadi)
            CheckboxListTile(
              title: const Text("Protein Terpenuhi"),
              value: true,
              onChanged: (val) {},
            ),
          ],
        ),
      ),
    );
  }
}