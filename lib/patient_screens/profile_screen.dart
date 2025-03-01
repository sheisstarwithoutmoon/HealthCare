import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:health/services/authentication.dart';
// import 'package:health/widgets/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture & Name
            Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 60,
                      foregroundImage: AssetImage('assets/vanya_aws.jpeg'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Vanya Awasthi",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "vanya.a23@iiits.in",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Account Options
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              "Account Options",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildListTileItem(
              title: 'My Orders',
              leadingIcon: IconlyLight.bag,
              onTap: () {},
            ),
            
            const SizedBox(height: 24),
            
            // Logout Option
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  AuthServices().signOut();
                },
                icon: const Icon(IconlyBold.logout),
                label: const Text("Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTileItem({
    required String title,
    required IconData leadingIcon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(leadingIcon, color: Colors.blue),
        ),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: const Icon(IconlyLight.arrowRight2, color: Colors.teal),
        onTap: onTap,
      ),
    );
  }
}
