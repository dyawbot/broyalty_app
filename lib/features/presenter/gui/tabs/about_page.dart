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
  Widget _buildProfileSection(String name, String email) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
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
            _buildProfileSection("Juan Dela Cruz", "juandelacruz@gmail.com"),
            SizedBox(height: 40), // Adds spacing between sections
            _buildProfileSection("Juan Dela Cruz", "juandelacruz@gmail.com"),
            SizedBox(height: 40), // Adds spacing between sections
            _buildProfileSection("Juan Dela Cruz", "juandelacruz@gmail.com"),
          ],
        ),
      ),
    );
  }
}
