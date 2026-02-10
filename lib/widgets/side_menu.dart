import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideMenu extends StatelessWidget {
  final Function(String) onMenuItemTap;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key,
    required this.onMenuItemTap,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.purple[900],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple[800],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nahida Jannat',
                  style: GoogleFonts.poppins(
                    color: Colors.purpleAccent,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Portfolio',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          _buildMenuItem(Icons.home, 'Home', 'home'),
          _buildMenuItem(Icons.person, 'About', 'about'),
          _buildMenuItem(Icons.work, 'Experience', 'experience'),
          _buildMenuItem(Icons.school, 'Education', 'education'),
          _buildMenuItem(Icons.code, 'Skills', 'skills'),
          _buildMenuItem(Icons.emoji_events, 'Achievements', 'achievements'),
          _buildMenuItem(Icons.contact_mail, 'Contact', 'contact'),
          const Divider(color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Info',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                _buildContactInfo(Icons.email, 'nahidajannat28@gmail.com'),
                _buildContactInfo(Icons.phone, '+880 1971111111'),
                _buildContactInfo(Icons.location_on, 'Dhaka, Bangladesh'),
                const SizedBox(height: 20),
                Text(
                  'Quick Links',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.link, color: Colors.purpleAccent),
                      tooltip: 'GitHub',
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.email, color: Colors.purpleAccent),
                      tooltip: 'Email',
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.phone, color: Colors.purpleAccent),
                      tooltip: 'Phone',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String section) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[300]),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: () {
        scaffoldKey.currentState?.closeDrawer();
        onMenuItemTap(section);
      },
      hoverColor: Colors.purpleAccent.withOpacity(0.1),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.purpleAccent, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: Colors.grey[300],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}