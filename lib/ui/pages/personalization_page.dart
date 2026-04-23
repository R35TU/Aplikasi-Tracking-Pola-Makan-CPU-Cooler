import 'package:eatly/ui/pages/goal_page.dart';
import 'package:flutter/material.dart';
import 'package:eatly/ui/widgets/eatly_button.dart';


class PersonalizationPage extends StatefulWidget {
  const PersonalizationPage({super.key});

  @override
  State<PersonalizationPage> createState() => _PersonalizationPageState();
}

class _PersonalizationPageState extends State<PersonalizationPage> {
  String gender = 'Male';
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Tell us about you", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("Help us personalize your experience", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),

            // Gender Selection
            const Text("Gender", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: ['Male', 'Female', 'Other'].map((label) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Center(child: Text(label)),
                      selected: gender == label,
                      selectedColor: Colors.green,
                      labelStyle: TextStyle(color: gender == label ? Colors.white : Colors.black),
                      onSelected: (bool selected) {
                        setState(() { gender = label; });
                      },
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 25),

            // Height Input (cm)
            const Text("Height (cm)", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Ex: 170"),
            ),

            const SizedBox(height: 25),

            // Weight Input (kg)
            const Text("Weight (kg)", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Ex: 65"),
            ),

            const Spacer(),
            
            EatlyButton(
              label: "Continue",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GoalPage()),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}