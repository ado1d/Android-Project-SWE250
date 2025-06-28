import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeveloperInfoPage extends StatelessWidget {
  const DeveloperInfoPage({super.key});

  final String facebookUrl = "https://www.facebook.com/ayman.chowdhury.7731/";
  final String twitterUrl = "https://x.com/aymanbnb69";
  final String whatsappUrl = "https://wa.me/8801537717805";
  final String githubUrl = "https://github.com/ado1d";

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B232A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B232A),
        automaticallyImplyLeading: false,
        title: const Text(
          'Developer Info',
          style: TextStyle(
            color: Color(0xFF37FB83),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF37FB83),
            size: 28,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // profile img
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/developer.JPG'),
            ),
            const SizedBox(height: 30),

            const Text(
              "Ayman Chowdhury",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // bio
            const Text(
              "Studying Software Engineering.\nHave strong problem solving ability",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),

            // Socials
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialIcon(
                  icon: FontAwesomeIcons.facebookF,
                  color: Colors.blueAccent,
                  onTap: () => _launchUrl(facebookUrl),
                ),
                _buildSocialIcon(
                  icon: FontAwesomeIcons.xTwitter,
                  color: Colors.lightBlue,
                  onTap: () => _launchUrl(twitterUrl),
                ),
                _buildSocialIcon(
                  icon: FontAwesomeIcons.whatsapp,
                  color: Colors.green,
                  onTap: () => _launchUrl(whatsappUrl),
                ),
                _buildSocialIcon(
                  icon: FontAwesomeIcons.github,
                  color: Colors.white,
                  onTap: () => _launchUrl(githubUrl),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: color.withOpacity(0.15),
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }
}
