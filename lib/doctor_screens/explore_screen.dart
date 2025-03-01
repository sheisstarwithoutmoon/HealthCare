import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:health/widgets/custom_app_bar.dart';
import 'package:health/widgets/filter_and_search.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterAndSearchField(),
            const SizedBox(height: 16),
            const Text(
              "Trending Topics",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildTopicCard(
                    icon: IconlyBold.document,
                    title: "Latest Research on Cardiovascular Health",
                    subtitle: "Updated 2 days ago",
                  ),
                  _buildTopicCard(
                    icon: IconlyBold.document,
                    title: "New Treatment for Type 2 Diabetes",
                    subtitle: "Updated 1 week ago",
                  ),
                  _buildTopicCard(
                    icon: IconlyBold.document,
                    title: "Advancements in Neurology",
                    subtitle: "Updated 3 days ago",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicCard({required IconData icon, required String title, required String subtitle}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade100,
          child: Icon(icon, color: Colors.teal.shade700),
        ),
        title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.black54)),
      ),
    );
  }
}
