import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/side_menu.dart';
import 'widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(
        onMenuItemTap: _scrollToSection,
        scaffoldKey: _scaffoldKey,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple[900]!,
              Colors.purple[800]!,
              Colors.deepPurple[700]!,
            ],
          ),
        ),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Custom App Bar
            CustomAppBar(
              scaffoldKey: _scaffoldKey,
              onNavItemTap: _scrollToSection,
            ),

            // Hero Section
            SliverToBoxAdapter(
              key: _homeKey,
              child: _buildHeroSection(),
            ),

            // About Section
            SliverToBoxAdapter(
              key: _aboutKey,
              child: _buildAboutSection(),
            ),

            // Experience Section
            SliverToBoxAdapter(
              key: _experienceKey,
              child: _buildExperienceSection(),
            ),

            // Education Section
            SliverToBoxAdapter(
              key: _educationKey,
              child: _buildEducationSection(),
            ),

            // Skills Section
            SliverToBoxAdapter(
              key: _skillsKey,
              child: _buildSkillsSection(),
            ),

            // Achievements Section
            SliverToBoxAdapter(
              key: _achievementsKey,
              child: _buildAchievementsSection(),
            ),

            // Contact Section
            SliverToBoxAdapter(
              key: _contactKey,
              child: _buildContactSection(),
            ),

            // Footer
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

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, my name is',
            style: GoogleFonts.poppins(
              color: Colors.purpleAccent,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 10),
          Text(
            'NAHIDA JANNAT MAYOUREE.',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 10),
          Text(
            'Flutter Developer & IT Specialist.',
            style: GoogleFonts.poppins(
              color: Colors.grey[200],
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 20),
          SizedBox(
            width: 500,
            child: Text(
              'I\'m a passionate Flutter developer and IT expert with experience in building exceptional mobile applications and providing technical solutions. Currently pursuing Computer Science at Southeast University with CGPA 3.80/4.00.',
              style: GoogleFonts.poppins(
                color: Colors.grey[300],
                fontSize: 16,
              ),
            ),
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => _scrollToSection('contact'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.purpleAccent,
              side: const BorderSide(color: Colors.purpleAccent, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              'Get In Touch!',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ).animate().fadeIn(delay: 500.ms),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '01.',
                style: GoogleFonts.poppins(
                  color: Colors.purpleAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'About Me',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello! I\'m Nahida Jannat Mayouree, a passionate Flutter developer and IT specialist based in Dhaka, Bangladesh.',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[300],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'I enjoy creating mobile applications that provide exceptional user experiences. My goal is to always build products that are performant, accessible, and beautiful.',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[300],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Here are a few technologies I\'ve been working with recently:',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[300],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTechItem('Flutter & Dart'),
                              _buildTechItem('Python'),
                              _buildTechItem('Java'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTechItem('HTML/CSS/JavaScript'),
                              _buildTechItem('PHP'),
                              _buildTechItem('Firebase'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              Expanded(
                flex: 2,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.purpleAccent, width: 2),
                    color: Colors.purple[800]!.withOpacity(0.3),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/profile.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTechItem(String tech) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(Icons.arrow_right, color: Colors.purpleAccent, size: 20),
          const SizedBox(width: 5),
          Text(
            tech,
            style: GoogleFonts.poppins(
              color: Colors.grey[300],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '02.',
                style: GoogleFonts.poppins(
                  color: Colors.purpleAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Work Experience',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Experience Tabs
              Container(
                width: 200,
                child: Column(
                  children: _experiences.asMap().entries.map((entry) {
                    int index = entry.key;
                    var company = entry.value['company'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCompanyIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: _selectedCompanyIndex == index
                                  ? Colors.purpleAccent
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          color: _selectedCompanyIndex == index
                              ? Colors.white.withOpacity(0.05)
                              : Colors.transparent,
                        ),
                        child: Text(
                          company,
                          style: GoogleFonts.poppins(
                            color: _selectedCompanyIndex == index
                                ? Colors.purpleAccent
                                : Colors.grey[400],
                            fontSize: 14,
                            fontWeight: _selectedCompanyIndex == index
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 40),
              // Experience Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _experiences[_selectedCompanyIndex]['title'],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '@ ${_experiences[_selectedCompanyIndex]['company']}',
                      style: GoogleFonts.poppins(
                        color: Colors.purpleAccent,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _experiences[_selectedCompanyIndex]['period'],
                      style: GoogleFonts.poppins(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (_experiences[_selectedCompanyIndex]['points'] as List<String>)
                          .map((point) => _buildExperiencePoint(point))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExperiencePoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_right, color: Colors.purpleAccent, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: Colors.grey[300],
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '03.',
                style: GoogleFonts.poppins(
                  color: Colors.purpleAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Education',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          _buildEducationCard(
            'Southeast University',
            'Bachelor of Science in Computer Science & Engineering',
            'Aug 2022 - Present',
            'CGPA: 3.80/4.00',
            Icons.school,
          ),
          const SizedBox(height: 30),
          _buildEducationCard(
            'Dhaka Polytechnic Institute',
            'Diploma in Computer Technology',
            'Aug 2017 - Jul 2022',
            'CGPA: 3.70/4.00',
            Icons.engineering,
          ),
          const SizedBox(height: 30),
          _buildEducationCard(
            'Ispahani Girls School and College',
            'Secondary School Certificate (SSC)',
            '2017',
            'GPA: 5.00/5.00',
            Icons.school,
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(String institution, String degree, String period, String grade, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.purple[800]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.purpleAccent, size: 40),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  institution,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  degree,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[300],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      period,
                      style: GoogleFonts.poppins(
                        color: Colors.purpleAccent,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      height: 20,
                      width: 1,
                      color: Colors.grey[700],
                    ),
                    const SizedBox(width: 20),
                    Text(
                      grade,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: 0.1);
  }

  Widget _buildSkillsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '04.',
                style: GoogleFonts.poppins(
                  color: Colors.purpleAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Skills & Technologies',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              _buildSkillCard('Flutter', 'Mobile Development', Icons.phone_android),
              _buildSkillCard('Dart', 'Programming Language', Icons.code),
              _buildSkillCard('Python', 'Backend Development', Icons.developer_mode),
              _buildSkillCard('Java', 'Desktop Applications', Icons.computer),
              _buildSkillCard('HTML/CSS/JS', 'Web Development', Icons.web),
              _buildSkillCard('PHP', 'Server-side Scripting', Icons.storage),
              _buildSkillCard('Git/GitHub', 'Version Control', Icons.settings),
              _buildSkillCard('IT Support', 'Hardware & Software', Icons.build),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(String title, String subtitle, IconData icon) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.purple[800]!),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.purpleAccent, size: 40),
          const SizedBox(height: 15),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: Colors.grey[300],
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '05.',
                style: GoogleFonts.poppins(
                  color: Colors.purpleAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Achievements & Certifications',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              _buildAchievementCard(
                'National Skill Certificate-I',
                'Computer Operation, NTVQF Level-I',
                Icons.verified,
              ),
              _buildAchievementCard(
                'IT Essentials',
                'Cisco Networking Academy',
                Icons.network_check,
              ),
              _buildAchievementCard(
                'Windows Server Admin',
                'IDEB Certification',
                Icons.storage,
              ),
              _buildAchievementCard(
                'Cyber Security',
                'Trends & Awareness',
                Icons.security,
              ),
              _buildAchievementCard(
                'Social Media Marketing',
                'Mastery Session',
                Icons.trending_up,
              ),
              _buildAchievementCard(
                'Girls Guides Association',
                'Leadership Training',
                Icons.people,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.purple[800]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.purpleAccent, size: 40),
          const SizedBox(height: 15),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: Colors.grey[300],
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '06. What\'s Next?',
            style: GoogleFonts.poppins(
              color: Colors.purpleAccent,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Get In Touch',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 500,
            child: Text(
              'I\'m currently looking for new opportunities in Flutter development and IT roles. Whether you have a question or just want to say hi, I\'ll try my best to get back to you!',
              style: GoogleFonts.poppins(
                color: Colors.grey[300],
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'nahidajannat28@gmail.com',
                queryParameters: {
                  'subject': 'Job Opportunity Inquiry',
                  'body': 'Hello Nahida,\n\nI would like to discuss...',
                },
              );
              if (await canLaunchUrl(emailLaunchUri)) {
                await launchUrl(emailLaunchUri);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.purpleAccent,
              side: const BorderSide(color: Colors.purpleAccent, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              'Say Hello',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.email, 'mailto:nahidajannat28@gmail.com'),
              const SizedBox(width: 20),
              _buildSocialIcon(Icons.phone, 'tel:+8801971521040'),
              const SizedBox(width: 20),
              _buildSocialIcon(Icons.link, 'https://github.com/Nahida-Jannat'),
              const SizedBox(width: 20),
              _buildSocialIcon(Icons.location_on, 'https://maps.google.com/?q=Dhaka,Bangladesh'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return IconButton(
      onPressed: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        }
      },
      icon: Icon(icon, color: Colors.grey[300], size: 28),
      hoverColor: Colors.purpleAccent.withOpacity(0.2),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.purple[800]!)),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              'Designed & Built by Nahida Jannat Mayouree',
              style: GoogleFonts.poppins(
                color: Colors.grey[300],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '© ${DateTime.now().year} All Rights Reserved',
              style: GoogleFonts.poppins(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}