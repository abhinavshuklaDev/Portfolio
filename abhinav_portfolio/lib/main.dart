import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abhinav Shukla',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1), // Indigo
          brightness: Brightness.dark,
          surface: const Color(0xFF0F172A), // Slate 900
        ),
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();

  // Keys for scrolling
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final targetContext = key.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
      // Close drawer if open
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navItems = [
      ('Home', _homeKey),
      ('About', _aboutKey),
      ('Skills', _skillsKey),
      ('Projects', _projectsKey),
      ('Experience', _experienceKey),
      ('Contact', _contactKey),
    ];

    return LayoutBuilder(builder: (context, constraints) {
      final isDesktop = constraints.maxWidth > 800;

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
          elevation: 0,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Abhinav',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          actions: isDesktop
              ? navItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextButton(
                      onPressed: () => _scrollToSection(item.$2),
                      child: Text(
                        item.$1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  );
                }).toList()
              : null, // Mobile shows hamburger automatically
        ),
        drawer: isDesktop
            ? null
            : Drawer(
                backgroundColor: const Color(0xFF1E293B),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  children: navItems.map((item) {
                    return ListTile(
                      title: Text(
                        item.$1,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onTap: () => _scrollToSection(item.$2),
                    );
                  }).toList(),
                ),
              ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              HeroSection(
                key: _homeKey,
                onViewWorkPressed: () => _scrollToSection(_projectsKey),
              ),
              AboutSection(key: _aboutKey),
              SkillsSection(key: _skillsKey),
              ProjectsSection(key: _projectsKey),
              ExperienceSection(key: _experienceKey),
              ContactSection(key: _contactKey),
              const Footer(),
            ],
          ),
        ),
      );
    });
  }
}

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewWorkPressed;

  const HeroSection({super.key, this.onViewWorkPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 800),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 800;
          return Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: isDesktop ? 5 : 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: isDesktop
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hello, I\'m',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold),
                    )
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: 0.2, end: 0),
                    const SizedBox(height: 16),
                    Text(
                      'Abhinav Shukla',
                      style: GoogleFonts.outfit(
                        fontSize: isDesktop ? 64 : 42,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                        color: Colors.white,
                      ),
                      textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                    )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 600.ms)
                        .slideY(begin: 0.2, end: 0),
                    const SizedBox(height: 16),
                    Text(
                      'Android & Flutter Developer\nGenerative AI Enthusiast',
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        color: Colors.grey[400],
                        height: 1.4,
                      ),
                      textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                    ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: onViewWorkPressed,
                          icon: const Icon(Icons.code),
                          label: const Text('View Work'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => launchUrl(
                              Uri.parse('mailto:abhinavshukla.dev@gmail.com')),
                          icon: const Icon(Icons.mail_outline),
                          label: const Text('Contact Me'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white54),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(delay: 600.ms, duration: 600.ms)
                        .slideY(begin: 0.2, end: 0),
                  ],
                ),
              ),
              if (isDesktop) const SizedBox(width: 40),
              if (!isDesktop) const SizedBox(height: 60),
              Expanded(
                flex: isDesktop ? 4 : 0,
                child: Center(
                  child: Container(
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                      image: DecorationImage(
                        image: const AssetImage('assets/images/profile.png'),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          // Error handled by showing fallback below
                        },
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.person_add_disabled,
                          size: 90, color: Colors.transparent),
                    ),
                  ),
                ).animate().fadeIn(delay: 400.ms, duration: 800.ms).scale(),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 4,
          width: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E293B), // Slate 800
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      width: double.infinity,
      child: Column(
        children: [
          const SectionTitle(title: 'About Me'),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: const Text(
              'I\'m Abhinav Shukla, an Associate Engineer at Volansys Technologies with 3+ years of experience. \n\nI specialize in building high-performance mobile applications using Java, Kotlin, Jetpack Compose, and Flutter. Recently, I have been integrating Generative AI into my workflows and experimenting with Python automation.\n\nI am passionate about Clean Architecture, intuitive UX, and exploring new tech stacks like Shopify development.',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 18, color: Colors.white70, height: 1.6),
            ),
          ),
        ],
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skillCategories = {
      'Languages': [
        'Java',
        'Kotlin',
        'Dart',
        'JavaScript',
        'Python',
      ],
      'Frameworks': [
        'Android SDK',
        'Jetpack Compose',
        'Flutter',
        'React Native',
      ],
      'Tools & Technologies': [
        'Firebase',
        'Git & GitHub',
        'REST APIs',
        'CI/CD',
        'Generative AI',
        'Shopify',
      ],
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
      width: double.infinity,
      child: Column(
        children: [
          const SectionTitle(title: 'Technical Skills'),
          const SizedBox(height: 10),
          ...skillCategories.entries.map((category) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    category.key,
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: category.value.map((skill) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Text(
                          skill,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        'title': 'IoT Control App',
        'desc':
            'IoT control app built with Kotlin & REST APIs. Features clean architecture and real-time device status updates.',
        'tech': 'Kotlin • Compose • IoT',
      },
      {
        'title': 'E-card Sharing app',
        'desc':
            'Cross-platform Flutter app for sharing e-cards. Implements complex UI animations, local caching, and responsive layouts.',
        'tech': 'Flutter • Provider • API',
      },
      {
        'title': 'Home Security app',
        'desc':
            'IoT control app built with Kotlin & REST APIs. Features clean architecture and real-time device status updates.',
        'tech': 'Kotlin • Compose • IoT',
      },
      {
        'title': 'E-commerce app',
        'desc':
            'Cross-platform Flutter app for e-commerce. Implements complex UI animations, local caching, and responsive layouts.',
        'tech': 'Flutter • Provider • API',
      },
      {
        'title': 'Video Dubbing Tool',
        'desc':
            'Automated video dubbing pipeline using Python & AI models. Handles speech-to-text, translation (French-English), and text-to-speech synchronization.',
        'tech': 'Python • AI • FFMPEG',
      },
      {
        'title': 'Recipe Explorer',
        'desc':
            'Cross-platform Flutter app for discovering recipes. Implements complex UI animations, local caching, and responsive layouts.',
        'tech': 'Flutter • Provider • API',
      }
    ];

    return Container(
      color: const Color(0xFF1E293B),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      width: double.infinity,
      child: Column(
        children: [
          const SectionTitle(title: 'Featured Projects'),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: projects.map((project) {
              return SizedBox(
                width: 350,
                child: Card(
                  color: const Color(0xFF0F172A),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project['title']!,
                          style: GoogleFonts.outfit(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          project['tech']!,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          project['desc']!,
                          style: const TextStyle(
                              color: Colors.white70, height: 1.5),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
    );
  }
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      width: double.infinity,
      child: Column(
        children: [
          const SectionTitle(title: 'Work Experience'),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: const Card(
              color: Color(0xFF1E293B),
              child: ListTile(
                contentPadding: EdgeInsets.all(24),
                title: Text(
                  'Associate Engineer',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Volansys Technologies • 2023 - Present\n\n- Contributing to enterprise-grade Android applications.\n- Collaborating with cross-functional teams to deliver features on time.\n- Optimizing app performance and resolving complex bugs.',
                    style: TextStyle(color: Colors.white70, height: 1.5),
                  ),
                ),
                trailing: Icon(Icons.work_outline, color: Colors.white54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E293B),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      width: double.infinity,
      child: Column(
        children: [
          const SectionTitle(title: 'Get In Touch'),
          const Text(
            'Interested in working together or have a question?',
            style: TextStyle(color: Colors.white70, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // Contact Info
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 32,
            runSpacing: 16,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone,
                      color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  const Text(
                    '+91 6351349815',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.email,
                      color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  const Text(
                    'abhinavshukla.dev@gmail.com',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () =>
                launchUrl(Uri.parse('mailto:abhinavshukla.dev@gmail.com')),
            icon: const Icon(Icons.email),
            label: const Text('Say Hello'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 60),
          const Text(
            'Connect with me',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Wrap(
            alignment: WrapAlignment.center,
            spacing: 24,
            runSpacing: 24,
            children: [
              _SocialIcon(
                  icon: Icons.code,
                  url: 'https://github.com/abhinavshuklaDev',
                  label: 'GitHub'),
              _SocialIcon(
                  icon: Icons.business_center,
                  url: 'https://www.linkedin.com/in/abhinavshukla123',
                  label: 'LinkedIn'),
              _SocialIcon(
                  icon: Icons.work_outline,
                  url: 'https://www.upwork.com/freelancers/~010756b4d15a67f287',
                  label: 'Upwork'),
            ],
          ),
        ],
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;
  final String label;

  const _SocialIcon({
    required this.icon,
    required this.url,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: const Color(0xFF0F172A),
      child: Center(
        child: Text(
          '© ${DateTime.now().year} Abhinav Shukla. Built with Flutter & Skia.',
          style: const TextStyle(color: Colors.white38, fontSize: 12),
        ),
      ),
    );
  }
}
