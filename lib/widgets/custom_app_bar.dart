import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(String) onNavItemTap;

  const CustomAppBar({
    super.key,
    required this.scaffoldKey,
    required this.onNavItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.purple[900]!.withOpacity(0.95),
      elevation: 0,
      floating: true,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () => scaffoldKey.currentState?.openDrawer(),
      ),
      title: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => onNavItemTap('home'),
          child: Text(
            'NJM',
            style: GoogleFonts.poppins(
              color: Colors.purpleAccent,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
      centerTitle: false,
      actions: [
        _buildNavItem('Home', 'home'),
        _buildNavItem('About', 'about'),
        _buildNavItem('Experience', 'experience'),
        _buildNavItem('Education', 'education'),
        _buildNavItem('Skills', 'skills'),
        _buildNavItem('Contact', 'contact'),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildNavItem(String title, String section) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () => onNavItemTap(section),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}