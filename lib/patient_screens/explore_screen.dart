import 'package:flutter/material.dart';
import 'package:health/patient_screens/book_screen.dart';
import 'package:health/widgets/feature_card.dart';
import 'package:health/widgets/custom_app_bar.dart';
import 'package:health/widgets/filter_and_search.dart';
import 'package:url_launcher/url_launcher.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  void _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, 
      appBar: customAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterAndSearchField(),
              const SizedBox(height: 16),

              // Appointment Reminder Notification
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade100, 
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade600, width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.notifications_active, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Reminder: Your appointment is scheduled in 3 days at 11:00 AM.",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Book Appointment Card
              FeatureCardWithImage(
                title: "Book Appointment",
                description: "Schedule a consultation with top doctors.",
                imagePath: "assets/images/book_appointment.png",
                buttonText: "Book Now",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BookAppointmentScreen()));
                },
              ),
              const SizedBox(height: 16),

              // Toll-Free Call Card
              FeatureCardWithImage(
                title: "Toll-Free Call",
                description: "Call our 24/7 health support helpline.",
                imagePath: "assets/images/toll_free.png",
                buttonText: "Call Now",
                onTap: () => _makePhoneCall("18001234567"),
              ),
              const SizedBox(height: 20),

              // Snap Carousel
              const Text(
                "Health Tips",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const SnapCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}

// Snap Carousel Widget
class SnapCarousel extends StatelessWidget {
  const SnapCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCarouselItem(Color.fromARGB(255, 189, 206, 248), "Stay Hydrated"),
          _buildCarouselItem(Color.fromARGB(255, 11, 93, 82), "Exercise Daily"),
          _buildCarouselItem(Colors.green, "Eat Healthy"),
          _buildCarouselItem(Colors.yellow, "Get Enough Sleep"),
          _buildCarouselItem(Colors.orange, "Reduce Stress"),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(Color color, String text) {
    return Container(
      width: 300.0,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}