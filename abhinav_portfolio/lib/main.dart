// File: lib/main.dart
// Flutter web single-file portfolio for Abhinav Shukla

import 'package:flutter/material.dart';

void main() => runApp(PortfolioApp());

class PortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abhinav Shukla — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatelessWidget {
  final sections = [
    'home',
    'about',
    'skills',
    'projects',
    'experience',
    'education',
    'contact'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Abhinav Shukla'),
        centerTitle: true,
        elevation: 0,
        actions: buildNav(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroSection(),
            SectionDivider(),
            AboutSection(),
            SectionDivider(),
            SkillsSection(),
            SectionDivider(),
            ProjectsSection(),
            SectionDivider(),
            ExperienceSection(),
            SectionDivider(),
            EducationSection(),
            SectionDivider(),
            ContactSection(),
            SizedBox(height: 40),
            Footer(),
          ],
        ),
      ),
    );
  }

  List<Widget> buildNav(BuildContext context) {
    // simple nav as text buttons — for web you can add scroll-to anchors
    return sections
        .map((s) => TextButton(
              onPressed: () {
                // Basic approach: jump to section using Scrollable.ensureVisible
                // For brevity we keep it simple; you can wire GlobalKeys later.
              },
              child: Text(
                s.toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
            ))
        .toList();
  }
}

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final isNarrow = mq.size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      width: double.infinity,
      color: Colors.indigo.shade50,
      child: Flex(
        direction: isNarrow ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment:
                  isNarrow ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                Text('Hi, I\'m', style: TextStyle(fontSize: 20)),
                SizedBox(height: 8),
                Text('Abhinav Shukla',
                    style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text('Android & Flutter Developer • Generative AI • Python',
                    style: TextStyle(fontSize: 18, color: Colors.grey[800])),
                SizedBox(height: 20),
                Wrap(spacing: 12, children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.code),
                    label: Text('View Projects'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      launchMail();
                    },
                    icon: Icon(Icons.mail_outline),
                    label: Text('Contact Me'),
                  ),
                ])
              ],
            ),
          ),
          SizedBox(width: isNarrow ? 0 : 40, height: isNarrow ? 40 : 0),
          Expanded(
            flex: 1,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 260),
                child: CircleAvatar(
                  radius: 110,
                  backgroundColor: Colors.indigo.shade100,
                  child: Icon(Icons.person, size: 88, color: Colors.indigo),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void launchMail() async {
    // mailto link — on web it opens an email client
    // Note: url_launcher not included here; for web you can use `window.open` via dart:html
  }
}

class SectionDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 24, color: Colors.white);
  }
}

class AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About Me', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text(
                  'I\'m Abhinav Shukla, an Associate Engineer (Android) at Volansys Technologies with 2+ year of experience. I build mobile apps using Java, Kotlin, Jetpack Compose, Flutter, and integrate AI/automation with Python. I\'m passionate about clean architecture, great UX, and learning new tools like Generative AI and Shopify development.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  final skills = [
    'Android (Java, Kotlin)',
    'Jetpack Compose',
    'Flutter (Dart)',
    'React Native',
    'Python & Generative AI',
    'Shopify Development',
    'Git / GitHub',
    'CI/CD basics',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Skills', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: skills
                .map((s) => Chip(label: Text(s, style: TextStyle(fontSize: 14))))
                .toList(),
          )
        ],
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  final projects = [
    {
      'title': 'Roku Smart Home (Demo)',
      'desc': 'IoT control app demo — Jetpack Compose + REST',
      'link': '#'
    },
    {
      'title': 'French→English Dubbing Tool',
      'desc': 'Structured Python project for video dubbing and automation',
      'link': '#'
    },
    {
      'title': 'Recipe App (Flutter)',
      'desc': 'Flutter recipe app with responsive UI and thumbnails',
      'link': '#'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Projects', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Column(
            children: projects
                .map((p) => Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(p['title']!),
                        subtitle: Text(p['desc']!),
                        trailing: TextButton(
                          onPressed: () {},
                          child: Text('View'),
                        ),
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

class ExperienceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final experiences = [
      {
        'role': 'Associate Engineer — Android',
        'company': 'Volansys Technologies',
        'duration': '2024 — Present',
        'details': 'Worked on Android apps, feature development, bug fixes, and release flows.'
      }
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Experience', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ...experiences.map((e) => ListTile(
                title: Text('${e['role']} • ${e['company']}'),
                subtitle: Text('${e['duration']}\n${e['details']}'),
              ))
        ],
      ),
    );
  }
}

class EducationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Education', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ListTile(
            title: Text('B.Tech / BE — (Your College)'),
            subtitle: Text('Year — Specialization'),
          )
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text('Email: abhinavshukla.dev@gmail.com'),
          SizedBox(height: 6),
          Text('LinkedIn: https://www.linkedin.com/in/abhinavshukla123'),
          SizedBox(height: 6),
          Text('GitHub: https://github.com/shuklaabhin'),
          SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                // For web - open mailto
              },
              child: Text('Send Email'))
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text('© ${DateTime.now().year} Abhinav Shukla'),
      ),
    );
  }
}
