import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  // A reusable method to build a profile section
  Widget _buildProfileSection(String name, String email, String imageUrl) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(imageUrl),
        ),
        Text(name),
        Text(email),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About us",
          style: TextStyle(fontSize: 24),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileSection(
              "Gerard Duane D. Aqui",
              "Duaneaqui2001@gmail.com",
              "https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg", // Replace with actual image URL
            ),
            const SizedBox(height: 40), // Adds spacing between sections
            _buildProfileSection(
              "Sam Charles A. Rivera",
              "alontecharles1999@gmail.com",
              "https://example.com/image2.jpg", // Replace with actual image URL
            ),
            const SizedBox(height: 40), // Adds spacing between sections
            _buildProfileSection(
              "Genesis P. Sargento",
              "siseneg.sargento@gmail.com",
              "https://example.com/image3.jpg", // Replace with actual image URL
            ),
            const SizedBox(height: 40), // Adds spacing between sections
            _buildProfileSection(
              "Arjay D. Tibor",
              "Tiborarjay76@gmail.com",
              "https://example.com/image4.jpg", // Replace with actual image URL
            ),
          ],
        ),
      ),
    );
  }
}
