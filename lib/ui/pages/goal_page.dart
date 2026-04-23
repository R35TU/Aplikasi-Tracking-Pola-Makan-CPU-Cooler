import 'package:flutter/material.dart';
import 'package:eatly/ui/widgets/eatly_button.dart';
import 'package:eatly/ui/pages/home_page.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  String selectedGoal = '';

  // Teknik Table-driven untuk styling (Poin 5b)
  final Map<String, Map<String, dynamic>> goalOptions = {
    'Lose Weight': {'icon': Icons.trending_down, 'color': Colors.orange},
    'Maintain Weight': {'icon': Icons.remove, 'color': Colors.blue},
    'Gain Muscle': {'icon': Icons.trending_up, 'color': Colors.green},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Choose your goal", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("We'll customize your plan accordingly", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),

            // Card Options
            ...goalOptions.entries.map((entry) {
              bool isSelected = selectedGoal == entry.key;
              return GestureDetector(
                onTap: () => setState(() => selectedGoal = entry.key),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: isSelected ? Colors.green : Colors.grey.shade300, width: 2),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Icon(entry.value['icon'], color: entry.value['color'], size: 30),
                      const SizedBox(width: 20),
                      Text(entry.key, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      const Spacer(),
                      if (isSelected) const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                ),
              );
            }).toList(),

            const Spacer(),
            EatlyButton(
              label: "Continue",
              onPressed: selectedGoal.isEmpty 
                ? () {} // Disabled jika belum pilih
                : () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false,
                    );
                  },
            ),
          ],
        ),
      ),
    );
  }
}