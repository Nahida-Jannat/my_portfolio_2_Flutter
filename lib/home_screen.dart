import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'widgets/side_menu.dart';
import 'widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Keys for sections
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _achievementsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // Animation controllers
  late AnimationController _waveController;
  late AnimationController _floatController;

  // State for experience tabs
  int _selectedCompanyIndex = 0;

  // List of experience data
  final List<Map<String, dynamic>> _experiences = [
    {
      'company': 'JVAI',
      'title': 'Flutter App Development Intern',
      'period': 'Present',
      'points': [
        'Developed cross-platform mobile applications using Flutter framework',
        'Collaborated with team members on project planning and development',
        'Implemented responsive UI designs and state management solutions',
        'Participated in code reviews and agile development processes',
      ],
    },
    {
      'company': 'ILO',
      'title': 'IT Technician Intern',
      'period': 'Sep 2021 - Mar 2022',
      'points': [
        'Hardware and software troubleshooting for office equipment',
        'Microsoft Office suite support and maintenance',
        'Network infrastructure maintenance and support',
        'Technical support for International Labour Organization staff',
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _waveController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(
        onMenuItemTap: _scrollToSection,
        scaffoldKey: _scaffoldKey,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A0B2E),
              Color(0xFF2D1B4E),
              Color(0xFF4A2C7A),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            CustomAppBar(
              scaffoldKey: _scaffoldKey,
              onNavItemTap: _scrollToSection,
            ),

            // All sections with responsive padding
            SliverToBoxAdapter(
              key: _homeKey,
              child: _buildHeroSection(isMobile, isTablet),
            ),

            SliverToBoxAdapter(
              key: _aboutKey,
              child: _buildAboutSection(isMobile, isTablet),
            ),

            SliverToBoxAdapter(
              key: _experienceKey,
              child: _buildExperienceSection(isMobile),
            ),

            SliverToBoxAdapter(
              key: _educationKey,
              child: _buildEducationSection(isMobile),
            ),

            SliverToBoxAdapter(
              key: _skillsKey,
              child: _buildSkillsSection(isMobile, isTablet),
            ),

            SliverToBoxAdapter(
              key: _achievementsKey,
              child: _buildAchievementsSection(isMobile, isTablet),
            ),

            SliverToBoxAdapter(
              key: _contactKey,
              child: _buildContactSection(isMobile),
            ),

            SliverToBoxAdapter(
              child: _buildFooter(),
            ),
          ],
        ),
      ),
    );
  }

  // Navigation function
  void _scrollToSection(String section) {
    _scaffoldKey.currentState?.closeDrawer();

    Future.delayed(100.ms, () {
      switch (section) {
        case 'home':
          Scrollable.ensureVisible(
            _homeKey.currentContext!,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
          break;
        case 'about':
          Scrollable.ensureVisible(
            _aboutKey.currentContext!,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
          break;
        case 'experience':
          Scrollable.ensureVisible(
            _experienceKey.currentContext!,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
          break;
        case 'education':
          Scrollable.ensureVisible(
            _educationKey.currentContext!,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
          break;
        case 'skills':
          Scrollable.ensureVisible(
            _skillsKey.currentContext!,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
          break;
        case 'achievements':
          Scrollable.ensureVisible(
            _achievementsKey.currentContext!,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
          break;
        case 'contact':
          Scrollable.ensureVisible(
            _contactKey.currentContext!,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
          break;
      }
    });
  }

  // RESPONSIVE HERO SECTION
  Widget _buildHeroSection(bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 60 : 100,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _ParticlePainter(controller: _waveController),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Shimmer.fromColors(
                baseColor: const Color(0xFFDA70D6),
                highlightColor: Colors.white,
                child: Text(
                  'Hi, my name is',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 16 : 20,
                    fontWeight: FontWeight.w400,
                    letterSpacing: isMobile ? 1 : 2,
                  ),
                ),
              ).animate()
                  .fadeIn(duration: 800.ms)
                  .slideY(begin: -0.5),

              SizedBox(height: isMobile ? 10 : 15),

              // Main name - responsive font size
              AnimatedBuilder(
                animation: _waveController,
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
                        transform: _GradientTransform(_waveController.value),
                      ).createShader(bounds);
                    },
                    child: Text(
                      'NAHIDA JANNAT MAYOUREE',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: isMobile ? 28 : (isTablet ? 36 : 48),
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                  );
                },
              ).animate()
                  .fadeIn(delay: 300.ms)
                  .slideX(begin: -0.3, curve: Curves.easeOutCubic),

              SizedBox(height: isMobile ? 10 : 15),

              // Subtitle - responsive width and font
              SizedBox(
                width: isMobile ? double.infinity : 500,
                child: Text(
                  'I create beautiful mobile experiences with Flutter & transform ideas into reality.',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[300],
                    fontSize: isMobile ? 16 : 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ).animate(onComplete: (controller) => controller.repeat())
                  .fadeIn(delay: 500.ms)
                  .slideY(begin: 0.3)
                  .then()
                  .fade(curve: Curves.easeInOut, duration: 2000.ms)
                  .then()
                  .fade(end: 1.0, curve: Curves.easeInOut, duration: 2000.ms),

              SizedBox(height: isMobile ? 30 : 40),

              // Responsive buttons - column on mobile, row on larger screens
              if (isMobile)
                Column(
                  children: [
                    _buildAnimatedButton(
                      'Get In Touch',
                      Icons.email,
                          () => _scrollToSection('contact'),
                      isPrimary: true,
                      isMobile: isMobile,
                    ).animate().slideX(begin: -1, delay: 700.ms).fadeIn(),
                    SizedBox(height: 16),
                    _buildAnimatedButton(
                      'View Projects',
                      Icons.folder,
                          () {},
                      isPrimary: false,
                      isMobile: isMobile,
                    ).animate().slideX(begin: 1, delay: 800.ms).fadeIn(),
                  ],
                )
              else
                Row(
                  children: [
                    _buildAnimatedButton(
                      'Get In Touch',
                      Icons.email,
                          () => _scrollToSection('contact'),
                      isPrimary: true,
                      isMobile: isMobile,
                    ).animate().slideX(begin: -1, delay: 700.ms).fadeIn(),
                    SizedBox(width: 20),
                    _buildAnimatedButton(
                      'View Projects',
                      Icons.folder,
                          () {},
                      isPrimary: false,
                      isMobile: isMobile,
                    ).animate().slideX(begin: 1, delay: 800.ms).fadeIn(),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedButton(String text, IconData icon, VoidCallback onTap,
      {bool isPrimary = true, required bool isMobile}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: 300.ms,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 30,
            vertical: isMobile ? 14 : 16,
          ),
          decoration: BoxDecoration(
            gradient: isPrimary
                ? const LinearGradient(
              colors: [Color(0xFF8A2BE2), Color(0xFFDA70D6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                : null,
            color: isPrimary ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isPrimary ? Colors.transparent : const Color(0xFFDA70D6),
              width: 1.5,
            ),
            boxShadow: isPrimary
                ? [
              BoxShadow(
                color: const Color(0xFF8A2BE2).withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 0,
                offset: const Offset(0, 10),
              ),
            ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,
                  color: isPrimary ? Colors.white : const Color(0xFFDA70D6),
                  size: isMobile ? 18 : 20),
              SizedBox(width: isMobile ? 8 : 10),
              Text(
                text,
                style: GoogleFonts.poppins(
                  color: isPrimary ? Colors.white : const Color(0xFFDA70D6),
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ).animate().custom(
          duration: 200.ms,
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: 1 + value * 0.05,
              child: child,
            );
          },
        ),
      ),
    );
  }

  // RESPONSIVE ABOUT SECTION
  Widget _buildAboutSection(bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          _buildSectionTitle('01', 'About Me', Icons.person, isMobile),

          SizedBox(height: isMobile ? 20 : 40),

          // Responsive layout - column on mobile, row on larger screens
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text content
                _buildAboutContent(isMobile),
                SizedBox(height: 30),
                // Profile image
                _buildProfileImage(isMobile),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildAboutContent(isMobile),
                ),
                SizedBox(width: isTablet ? 30 : 60),
                Expanded(
                  flex: 2,
                  child: _buildProfileImage(isMobile),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildAboutContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello! I\'m Nahida, a passionate Flutter developer based in Dhaka, Bangladesh with a strong academic background in Computer Science.',
          style: GoogleFonts.poppins(
            color: Colors.grey[300],
            fontSize: isMobile ? 15 : 17,
            height: 1.6,
          ),
        ).animate(delay: 50.ms).slideX(begin: -0.2).fadeIn(),

        SizedBox(height: isMobile ? 20 : 25),

        // Responsive stats - wrap on mobile, row on larger screens
        if (isMobile)
          Wrap(
            spacing: 20,
            runSpacing: 15,
            children: [
              _buildAnimatedStat('3.80', 'University CGPA', isMobile),
              _buildAnimatedStat('2+', 'Years Experience', isMobile),
              _buildAnimatedStat('10+', 'Projects', isMobile),
            ].animate(delay: 100.ms).slideY(begin: 0.3).fadeIn(),
          )
        else
          Row(
            children: [
              _buildAnimatedStat('3.85', 'University CGPA', isMobile),
              SizedBox(width: 30),
              _buildAnimatedStat('2+', 'Years Experience', isMobile),
              SizedBox(width: 30),
              _buildAnimatedStat('10+', 'Projects', isMobile),
            ].animate(delay: 100.ms).slideY(begin: 0.3).fadeIn(),
          ),

        SizedBox(height: isMobile ? 25 : 30),

        Text(
          'Technologies I work with:',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: isMobile ? 16 : 18,
            fontWeight: FontWeight.w600,
          ),
        ).animate().fadeIn(delay: 200.ms),

        SizedBox(height: isMobile ? 10 : 15),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            'Flutter', 'Dart', 'Firebase', 'Python',
            'Java', 'HTML/CSS', 'JavaScript', 'PHP',
            'Git', 'MySQL', 'REST API', 'Provider',
          ].map((tech) => _buildTechChip(tech)).toList()
              .animate(interval: 50.ms)
              .slideY(begin: 0.2)
              .fadeIn(),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String number, String title, IconData icon, bool isMobile) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(isMobile ? 8 : 10),
          decoration: BoxDecoration(
            color: const Color(0xFF8A2BE2).withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF8A2BE2).withOpacity(0.5)),
          ),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFFDA70D6), size: isMobile ? 18 : 20),
              SizedBox(width: isMobile ? 6 : 8),
              Text(
                number,
                style: GoogleFonts.poppins(
                  color: const Color(0xFFDA70D6),
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ).animate().custom(
          duration: 500.ms,
          builder: (context, value, child) {
            return Transform.scale(
              scale: 0.5 + value * 0.5,
              child: child,
            );
          },
        ),

        SizedBox(width: isMobile ? 10 : 15),

        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),

        SizedBox(width: isMobile ? 10 : 20),

        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFFDA70D6).withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedStat(String value, String label, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.grey[400],
            fontSize: isMobile ? 12 : 14,
          ),
        ),
      ],
    );
  }

  Widget _buildTechChip(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Text(
        tech,
        style: GoogleFonts.poppins(
          color: Colors.grey[300],
          fontSize: 12,
        ),
      ),
    );
  }

  // PROFILE IMAGE WITH YOUR PHOTO
  Widget _buildProfileImage(bool isMobile) {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatController.value * 10),
          child: Container(
            width: isMobile ? 200 : 280,
            height: isMobile ? 200 : 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF8A2BE2), Color(0xFFDA70D6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8A2BE2).withOpacity(0.5),
                  blurRadius: 30,
                  spreadRadius: 5,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Your profile image with error handling
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/profile1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Fallback if image doesn't load
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),

                // Animated border
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).animate().custom(
      delay: 400.ms,
      duration: 800.ms,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + value * 0.2,
          child: child,
        );
      },
    );
  }

  Widget _buildExperienceSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('02', 'Work Experience', Icons.work, isMobile),

          SizedBox(height: isMobile ? 20 : 40),

          // Timeline - adjust for mobile
          Stack(
            children: [
              // Timeline line - hide on mobile or adjust position
              if (!isMobile)
                Positioned(
                  left: 100,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          const Color(0xFFDA70D6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

              Column(
                children: _experiences.asMap().entries.map((entry) {
                  int index = entry.key;
                  var exp = entry.value;
                  bool isSelected = _selectedCompanyIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCompanyIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: isMobile ? 20 : 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Timeline dot - adjust position for mobile
                          Container(
                            width: 16,
                            height: 16,
                            margin: EdgeInsets.only(right: isMobile ? 12 : 20, top: isMobile ? 4 : 0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? const Color(0xFFDA70D6) : Colors.grey[700],
                            ),
                          ),

                          Expanded(
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: AnimatedContainer(
                                duration: 300.ms,
                                padding: EdgeInsets.all(isMobile ? 16 : 25),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white.withOpacity(0.05)
                                      : Colors.white.withOpacity(0.02),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFFDA70D6).withOpacity(0.5)
                                        : Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (isMobile)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            exp['title'] as String,
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            '@ ${exp['company']}',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFFDA70D6),
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFDA70D6).withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Text(
                                              exp['period'] as String,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFFDA70D6),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    else
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                exp['title'] as String,
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                '@ ${exp['company']}',
                                                style: GoogleFonts.poppins(
                                                  color: const Color(0xFFDA70D6),
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFDA70D6).withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              exp['period'] as String,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFFDA70D6),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    SizedBox(height: isMobile ? 12 : 15),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: (exp['points'] as List<String>)
                                          .map((point) => Padding(
                                        padding: const EdgeInsets.only(bottom: 6),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.arrow_right,
                                              color: const Color(0xFFDA70D6),
                                              size: 18,
                                            ),
                                            SizedBox(width: isMobile ? 6 : 8),
                                            Expanded(
                                              child: Text(
                                                point,
                                                style: GoogleFonts.poppins(
                                                  color: Colors.grey[300],
                                                  fontSize: isMobile ? 13 : 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEducationSection(bool isMobile) {
    final List<Map<String, dynamic>> educationData = [
      {
        'institution': 'Southeast University',
        'degree': 'Bachelor of Science in Computer Science & Engineering',
        'period': '2022 - Present',
        'grade': 'CGPA: 3.80/4.00',
        'icon': Icons.school,
      },
      {
        'institution': 'Dhaka Polytechnic Institute',
        'degree': 'Diploma in Computer Technology',
        'period': '2017 - 2022',
        'grade': 'CGPA: 3.70/4.00',
        'icon': Icons.engineering,
      },
      {
        'institution': 'Ispahani Girls School and College',
        'degree': 'Secondary School Certificate (SSC)',
        'period': '2017',
        'grade': 'GPA: 5.00/5.00',
        'icon': Icons.school,
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('03', 'Education', Icons.school, isMobile),

          SizedBox(height: isMobile ? 20 : 40),

          // Responsive grid for education cards
          if (isMobile)
            Column(
              children: List.generate(educationData.length, (index) =>
                  _buildEducationCard(educationData[index], isMobile).animate(delay: (index * 200).ms)
                      .slideY(begin: 0.2)
                      .fadeIn(),
              ),
            )
          else
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: List.generate(educationData.length, (index) =>
                  _buildEducationCard(educationData[index], isMobile).animate(delay: (index * 200).ms)
                      .slideY(begin: 0.2)
                      .fadeIn(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(Map<String, dynamic> data, bool isMobile) {
    return Container(
      width: isMobile ? double.infinity : 350,
      padding: EdgeInsets.all(isMobile ? 16 : 25),
      margin: isMobile ? const EdgeInsets.only(bottom: 16) : null,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.05),
            Colors.white.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: isMobile ? 50 : 60,
            height: isMobile ? 50 : 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8A2BE2), Color(0xFFDA70D6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(data['icon'] as IconData, color: Colors.white, size: isMobile ? 24 : 28),
          ),

          SizedBox(width: isMobile ? 16 : 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['institution'] as String,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  data['degree'] as String,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[300],
                    fontSize: isMobile ? 12 : 14,
                  ),
                ),

                SizedBox(height: 12),

                if (isMobile)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8A2BE2).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          data['period'] as String,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFDA70D6),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 14),
                            SizedBox(width: 4),
                            Text(
                              data['grade'] as String,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8A2BE2).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          data['period'] as String,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFDA70D6),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 14),
                            SizedBox(width: 5),
                            Text(
                              data['grade'] as String,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildSkillsSection(bool isMobile, bool isTablet) {
    final List<Map<String, dynamic>> skills = [
      {'name': 'Flutter', 'level': 70, 'icon': Icons.phone_android},
      {'name': 'Python', 'level': 60, 'icon': Icons.code},
      {'name': 'Java', 'level': 50, 'icon': Icons.computer},
      {'name': 'HTML/CSS/JS', 'level': 80, 'icon': Icons.web},
      {'name': 'PHP', 'level': 55, 'icon': Icons.storage},
      {'name': 'IT Support', 'level': 50, 'icon': Icons.build},
      {'name': 'MS Office', 'level': 95, 'icon': Icons.article},
      {'name': 'Git/GitHub', 'level': 85, 'icon': Icons.settings},
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('04', 'Skills & Expertise', Icons.code, isMobile),

          SizedBox(height: isMobile ? 20 : 40),

          // Responsive grid for skills
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : (isTablet ? 3 : 4),
              crossAxisSpacing: isMobile ? 12 : 20,
              mainAxisSpacing: isMobile ? 12 : 20,
              childAspectRatio: isMobile ? 1 : 0.8,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              var skill = skills[index];
              return _buildSkillCard(
                skill['name'] as String,
                skill['level'] as int,
                skill['icon'] as IconData,
                isMobile,
              ).animate(delay: (index * 100).ms)
                  .slideY(begin: 0.3)
                  .fadeIn();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(String name, int level, IconData icon, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.05),
            Colors.white.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: isMobile ? 40 : 60,
            height: isMobile ? 40 : 60,
            margin: EdgeInsets.only(bottom: isMobile ? 10 : 15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFFDA70D6), size: isMobile ? 22 : 28),
          ),

          Text(
            name,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: isMobile ? 14 : 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: isMobile ? 8 : 10),

          // Progress bar container
          Container(
            width: isMobile ? 80 : 140, // Fixed width for the progress bar container
            child: Stack(
              children: [
                // Background bar (full width)
                Container(
                  height: 6,
                  width: double.infinity, // This should be full width of parent
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),

                // Foreground progress bar (based on level)
                AnimatedContainer(
                  duration: 1000.ms,
                  height: 6,
                  width: (level / 100) * (isMobile ? 80 : 140), // This calculates width based on level
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8A2BE2), Color(0xFFDA70D6)],
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 4),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '$level%',
              style: GoogleFonts.poppins(
                color: Colors.grey[400],
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection(bool isMobile, bool isTablet) {
    final List<Map<String, dynamic>> achievements = [
      {'title': 'National Skill Certificate-I', 'subtitle': 'Computer Operation', 'icon': Icons.verified},
      {'title': 'IT Essentials', 'subtitle': 'Cisco Networking Academy', 'icon': Icons.network_check},
      {'title': 'Windows Server Admin', 'subtitle': 'IDEB Certification', 'icon': Icons.storage},
      {'title': 'Cyber Security', 'subtitle': 'Trends & Awareness', 'icon': Icons.security},
      {'title': 'Social Media Marketing', 'subtitle': 'Mastery Session', 'icon': Icons.trending_up},
      {'title': 'Girls Guides Association', 'subtitle': 'Leadership Training', 'icon': Icons.people},
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('05', 'Achievements', Icons.emoji_events, isMobile),

          SizedBox(height: isMobile ? 20 : 40),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : (isTablet ? 3 : 3),
              crossAxisSpacing: isMobile ? 12 : 20,
              mainAxisSpacing: isMobile ? 12 : 20,
              childAspectRatio: isMobile ? 1.2 : 1.5,
            ),
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              var achievement = achievements[index];
              return _buildAchievementCard(
                achievement['title'] as String,
                achievement['subtitle'] as String,
                achievement['icon'] as IconData,
                isMobile,
              ).animate(delay: (index * 150).ms)
                  .slideY(begin: 0.3)
                  .fadeIn();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(String title, String subtitle, IconData icon, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.05),
            Colors.white.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: isMobile ? 40 : 50,
            height: isMobile ? 40 : 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8A2BE2), Color(0xFFDA70D6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: isMobile ? 20 : 24),
          ),

          SizedBox(height: isMobile ? 10 : 15),

          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: isMobile ? 13 : 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),

          SizedBox(height: 4),

          Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: Colors.grey[400],
              fontSize: isMobile ? 11 : 13,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'Let\'s Connect',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: isMobile ? 32 : 48,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn().slideY(begin: 0.3),

              SizedBox(height: 8),

              Text(
                'Have a project in mind? Let\'s make it happen!',
                style: GoogleFonts.poppins(
                  color: Colors.grey[300],
                  fontSize: isMobile ? 16 : 18,
                ),
                textAlign: TextAlign.center,
              ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.3),
            ],
          ),

          SizedBox(height: isMobile ? 30 : 50),

          // Responsive contact methods
          if (isMobile)
            Column(
              children: [
                _buildContactMethod(
                  Icons.email,
                  'Email',
                  'nahidajannat28@gmail.com',
                  'Send me a message',
                      () async {
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'nahidajannat28@gmail.com',
                    );
                    if (await canLaunchUrl(emailLaunchUri)) {
                      await launchUrl(emailLaunchUri);
                    }
                  },
                  isMobile,
                ),
                SizedBox(height: 16),
                _buildContactMethod(
                  Icons.phone,
                  'Phone',
                  '+880 1971111111',
                  'Call or WhatsApp',
                      () async {
                    final Uri phoneLaunchUri = Uri(
                      scheme: 'tel',
                      path: '+8801971111111',
                    );
                    if (await canLaunchUrl(phoneLaunchUri)) {
                      await launchUrl(phoneLaunchUri);
                    }
                  },
                  isMobile,
                ),
                SizedBox(height: 16),
                _buildContactMethod(
                  Icons.location_on,
                  'Location',
                  'Dhaka, Bangladesh',
                  'Based in Dhaka',
                      () {},
                  isMobile,
                ),
              ].animate(interval: 100.ms).slideY(begin: 0.3).fadeIn(),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildContactMethod(
                  Icons.email,
                  'Email',
                  'nahidajannat28@gmail.com',
                  'Send me a message',
                      () async {
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'nahidajannat28@gmail.com',
                    );
                    if (await canLaunchUrl(emailLaunchUri)) {
                      await launchUrl(emailLaunchUri);
                    }
                  },
                  isMobile,
                ),
                SizedBox(width: 30),
                _buildContactMethod(
                  Icons.phone,
                  'Phone',
                  '+880 1971111111',
                  'Call or WhatsApp',
                      () async {
                    final Uri phoneLaunchUri = Uri(
                      scheme: 'tel',
                      path: '+8801971521040',
                    );
                    if (await canLaunchUrl(phoneLaunchUri)) {
                      await launchUrl(phoneLaunchUri);
                    }
                  },
                  isMobile,
                ),
                SizedBox(width: 30),
                _buildContactMethod(
                  Icons.location_on,
                  'Location',
                  'Dhaka, Bangladesh',
                  'Based in Dhaka',
                      () {},
                  isMobile,
                ),
              ].animate(interval: 100.ms).slideY(begin: 0.3).fadeIn(),
            ),

          SizedBox(height: isMobile ? 40 : 60),

          Text(
            'Find me on',
            style: GoogleFonts.poppins(
              color: Colors.grey[400],
              fontSize: isMobile ? 14 : 16,
            ),
          ).animate(delay: 600.ms).fadeIn(),

          SizedBox(height: 16),

          // Social buttons - wrap on mobile
          if (isMobile)
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _buildSocialButton(
                  Icons.link,
                  'Portfolio',
                  'https://github.com/Nahida-Jannat',
                  Colors.white,
                  isMobile,
                ),
                _buildSocialButton(
                  Icons.email,
                  'Email',
                  'mailto:nahidajannat28@gmail.com',
                  const Color(0xFFDA70D6),
                  isMobile,
                ),
                _buildSocialButton(
                  Icons.phone,
                  'Call',
                  'tel:+8801971111111',
                  const Color(0xFF8A2BE2),
                  isMobile,
                ),
              ].animate(interval: 100.ms).slideY(begin: 0.5).fadeIn(),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton(
                  Icons.link,
                  'Portfolio',
                  'https://github.com/Nahida-Jannat',
                  Colors.white,
                  isMobile,
                ),
                SizedBox(width: 20),
                _buildSocialButton(
                  Icons.email,
                  'Email',
                  'mailto:nahidajannat28@gmail.com',
                  const Color(0xFFDA70D6),
                  isMobile,
                ),
                SizedBox(width: 20),
                _buildSocialButton(
                  Icons.phone,
                  'Call',
                  'tel:+8801971111111',
                  const Color(0xFF8A2BE2),
                  isMobile,
                ),
              ].animate(interval: 100.ms).slideY(begin: 0.5).fadeIn(),
            ),
        ],
      ),
    );
  }

  Widget _buildContactMethod(IconData icon, String title, String value, String subtitle,
      VoidCallback onTap, bool isMobile) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: 300.ms,
          width: isMobile ? double.infinity : 200,
          padding: EdgeInsets.all(isMobile ? 20 : 25),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.02),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              Container(
                width: isMobile ? 50 : 60,
                height: isMobile ? 50 : 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFDA70D6).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: const Color(0xFFDA70D6), size: isMobile ? 24 : 28),
              ),

              SizedBox(height: isMobile ? 12 : 15),

              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 4),

              Text(
                value,
                style: GoogleFonts.poppins(
                  color: Colors.grey[300],
                  fontSize: isMobile ? 13 : 14,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 4),

              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  color: const Color(0xFFDA70D6),
                  fontSize: isMobile ? 11 : 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label, String url, Color color, bool isMobile) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          }
        },
        child: AnimatedContainer(
          duration: 300.ms,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 25,
            vertical: isMobile ? 12 : 15,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: isMobile ? 18 : 20),
              SizedBox(width: isMobile ? 8 : 10),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: color,
                  fontSize: isMobile ? 13 : 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.3),
          ],
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              'Designed & Built with 💜 by Nahida Jannat Mayouree',
              style: GoogleFonts.poppins(
                color: Colors.grey[400],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ).animate(onPlay: (controller) => controller.repeat())
                .fade(duration: 3000.ms, begin: 0.5, end: 1)
                .then()
                .fade(duration: 3000.ms, begin: 1, end: 0.5),

            SizedBox(height: 10),

            Text(
              '© ${DateTime.now().year} All Rights Reserved',
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom gradient transform for wave effect
class _GradientTransform extends GradientTransform {
  final double value;

  _GradientTransform(this.value);

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.identity()
      ..translate(bounds.width * value * 0.5, 0);
  }
}

// Particle painter for background
class _ParticlePainter extends CustomPainter {
  final Animation<double> controller;

  _ParticlePainter({required this.controller}) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDA70D6).withOpacity(0.1)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 20; i++) {
      final x = size.width * (0.1 + 0.8 * (i / 20));
      final y = size.height * 0.2 + 50 * sin(controller.value + i * 0.1);
      final radius = 2 + 3 * sin(controller.value + i * 0.05).abs();

      canvas.drawCircle(Offset(x, y), radius.toDouble(), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}