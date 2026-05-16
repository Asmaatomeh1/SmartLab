import 'package:flutter/material.dart';

class HomeGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {"icon": Icons.science, "title": "Book A Test"},
    {"icon": Icons.description, "title": "View Reports"},
    {"icon": Icons.location_city, "title": "Find Centre"},
    {"icon": Icons.help_outline, "title": "Test Queries"},
    {"icon": Icons.refresh, "title": "Re-Order"},
    {"icon": Icons.people, "title": "Add A Member"},
  ];

  HomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(items[index]["icon"], size: 30, color: Colors.blue),
                const SizedBox(height: 8),
                Text(
                  items[index]["title"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
