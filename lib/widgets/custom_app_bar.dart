import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_iconly/flutter_iconly.dart';

AppBar customAppBar(BuildContext context,
    {Widget? titleWidget, List<Widget>? actionsWidgets}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        // Profile Image with Navigation to Profile Screen
        GestureDetector(
          onTap: () {
            
          },
          child: const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/images/image.png"), 
          ),
        ),
        const SizedBox(width: 10),

        // Welcome Text
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, User",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "How can we help you today?",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ),

    // Actions Section with Notification Badge & Home Icon
    actions: actionsWidgets ??
        [
          // Notification Button with Badge
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  elevation: .9,
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.infinity,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('          No Notification'),
                        );
                      },
                      itemCount: 1, // Replace with actual notification count
                    ),
                  ),
                );
              },
              icon: badges.Badge(
                badgeContent: const Text(
                  '1', // Dynamic notification count
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                position: badges.BadgePosition.topEnd(top: -13, end: -13),
                child: const Icon(
                  IconlyBroken.notification,
                  color: Colors.black, // Set color based on theme
                ),
              ),
            ),
          ),
        ],
  );
}
