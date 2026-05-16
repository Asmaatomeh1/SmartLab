import 'package:appwithfirebase/features/test/test_card.dart';
import 'package:flutter/material.dart';

class PrepPage extends StatelessWidget {
  const PrepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preparation For Tests')),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(12),
        childAspectRatio: 1.5,
        children: [
          TestCard(
            title: "Anaemia",
            subtitle: "lack of blood",
            icon: Icons.bloodtype,
            onTap: () {
              print("Anaemia");
            },
          ),
          TestCard(
            title: "Thyroid",
            subtitle: "abnormal thyroid",
            icon: Icons.medical_services,
            onTap: () {},
          ),
          TestCard(
            title: "Nutrition",
            subtitle: "lack nutrients",
            icon: Icons.food_bank,
            onTap: () {},
          ),
          TestCard(
            title: "Bone",
            subtitle: "body skeleton",
            icon: Icons.accessibility_new,
            onTap: () {},
          ),
          TestCard(
            title: "Heart",
            subtitle: "heart issues",
            icon: Icons.favorite,
            onTap: () {},
          ),
          TestCard(
            title: "Fitness",
            subtitle: "exercise",
            icon: Icons.fitness_center,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
