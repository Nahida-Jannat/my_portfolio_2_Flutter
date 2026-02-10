import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(String) onNavItemTap;

  const CustomAppBar({
    super.key,
    required this.scaffoldKey,
    required this.onNavItemTap,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> with SingleTickerProviderStateMixin {
  late AnimationController _logoController;
  int _hoveredIndex = -1;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return SliverAppBar(
      backgroundColor: const Color(0xFF1A0B2E).withOpacity(0.95),
      elevation: 0,
      floating: true,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () => widget.scaffoldKey.currentState?.openDrawer(),
      ),
      title: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => widget.onNavItemTap('home'),
          child: AnimatedBuilder(
            animation: _logoController,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [
                      Colors.white,
                      const Color(0xFFDA70D6),
                      Colors.white,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds);
                },
                child: Text(
                  'NJM',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      centerTitle: false,
      actions: isMobile
          ? [] // Hide nav items on mobile, use drawer instead
          : [
        _buildNavItem('Home', 'home', 0, isMobile),
        _buildNavItem('About', 'about', 1, isMobile),
        _buildNavItem('Experience', 'experience', 2, isMobile),
        _buildNavItem('Education', 'education', 3, isMobile),
        _buildNavItem('Skills', 'skills', 4, isMobile),
        _buildNavItem('Contact', 'contact', 5, isMobile),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildNavItem(String title, String section, int index, bool isMobile) {
    bool isHovered = _hoveredIndex == index;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 4 : 8),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hoveredIndex = index),
        onExit: (_) => setState(() => _hoveredIndex = -1),
        child: GestureDetector(
          onTap: () => widget.onNavItemTap(section),
          child: AnimatedContainer(
            duration: 300.ms,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 8 : 12,
              vertical: isMobile ? 6 : 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isHovered ? const Color(0xFFDA70D6).withOpacity(0.2) : Colors.transparent,
              border: Border.all(
                color: isHovered ? const Color(0xFFDA70D6).withOpacity(0.5) : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: isHovered ? const Color(0xFFDA70D6) : Colors.white,
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isHovered && !isMobile) ...[
                  const SizedBox(width: 5),
                  const Icon(Icons.arrow_forward, color: Color(0xFFDA70D6), size: 14),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}