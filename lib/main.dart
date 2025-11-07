import 'dart:math';

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

void main() {
  runApp(PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thiriveedhi Srivishnu - Portfolio',
      themeMode: _themeMode,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        chipTheme: ChipThemeData(
          backgroundColor: Colors.indigo.shade50,
          labelStyle: TextStyle(color: Colors.black87),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
          bodyLarge: TextStyle(color: Colors.black87),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.indigo,
        scaffoldBackgroundColor: Color(0xFF0D0D0D),
        cardColor: Color(0xFF1E1E1E),
        chipTheme: ChipThemeData(
          backgroundColor: Color(0xFF2C2C2C),
          labelStyle: TextStyle(color: Colors.white),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: PortfolioHome(onToggleTheme: _toggleTheme, themeMode: _themeMode),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;
  PortfolioHome({required this.onToggleTheme, required this.themeMode});

  @override
  _PortfolioHomeState createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final profile = {
    'name': 'Thiriveedhi Srivishnu',
    'title': 'Flutter Developer',
    'location': 'Nellore, Andhra Pradesh',
    'email': 'srivishnuthiriveedhi@gmail.com',
    'phone': '+91 8106824579',
    'summary':
        'Graduating with a Master of Computer Applications (MCA). Strong foundation in programming, Flutter app development, REST APIs, and responsive UI design. Passionate about creating efficient and beautiful applications.',
  };

  final skills = [
    'Flutter & Dart',
    'REST API (Dio)',
    'Provider / GetX',
    'MVVM Pattern',
    'Git & GitHub',
    'Firebase',
    'Responsive UI',
    'AI Bot Integration',
  ];

  final education = [
    {
      'degree': 'MCA',
      'institute': 'JNTUA University',
      'year': '2022–2024',
      'grade': '89%',
    },
    {
      'degree': 'B.Com (Computer Applications)',
      'institute': 'Vikrama Simhapuri University',
      'year': '2020–2022',
      'grade': '80%',
    },
  ];

  final experience = [
    {
      'role': 'Junior Flutter Developer',
      'company': 'Rsalesarm IT Company',
      'duration': 'Oct 2024 – Present',
      'bullets': [
        'Developed and maintained mobile and web apps using Flutter.',
        'Integrated REST APIs and managed app state efficiently.',
        'Collaborated with UI/UX and backend teams to deliver end-to-end modules.',
      ],
    },
  ];

  final projects = List.generate(6, (i) {
    return {
      'title': 'Project ${i + 1}',
      'desc':
          'A short project overview focusing on Flutter, responsive layout, and animations.',
      'image': 'https://picsum.photos/seed/portfolio${i + 1}/800/600',
    };
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: MediaQuery.of(context).size,
                painter: StarfieldPainter(
                  _controller.value,
                  isDark: brightness == Brightness.dark,
                ),
              );
            },
          ),
          SafeArea(
            child: Column(
              children: [
                _TopNav(
                  profile: profile,
                  onToggleTheme: widget.onToggleTheme,
                  themeMode: widget.themeMode,
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth >= 1100) {
                        return _DesktopBody(
                          profile: profile,
                          skills: skills,
                          education: education,
                          experience: experience,
                          projects: projects,
                        );
                      } else if (constraints.maxWidth >= 700) {
                        return _TabletBody(
                          profile: profile,
                          skills: skills,
                          education: education,
                          experience: experience,
                          projects: projects,
                        );
                      } else {
                        return _MobileBody(
                          profile: profile,
                          skills: skills,
                          education: education,
                          experience: experience,
                          projects: projects,
                        );
                      }
                    },
                  ),
                ),
                _Footer(profile: profile),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ======================= BACKGROUND STARFIELD ==========================
class StarfieldPainter extends CustomPainter {
  final double progress;
  final bool isDark;
  final Random _random = Random();
  StarfieldPainter(this.progress, {required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final bg = isDark ? Colors.black : Colors.white;
    final starColor = isDark ? Colors.white70 : Colors.blueGrey;
    paint.color = bg;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    for (int i = 0; i < 150; i++) {
      final x = (i * 40 + progress * size.width * 0.8) % size.width;
      final y = (i * 70 + progress * size.height * 1.2) % size.height;
      paint.color = starColor.withOpacity(_random.nextDouble() * 0.8 + 0.2);
      canvas.drawCircle(Offset(x, y), _random.nextDouble() * 2 + 0.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ======================= NAVIGATION BAR ==========================
class _TopNav extends StatelessWidget {
  final Map profile;
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;
  const _TopNav({
    required this.profile,
    required this.onToggleTheme,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://picsum.photos/seed/profile/100',
                ),
                radius: 20,
              ),
              SizedBox(width: 10),
              Text(
                profile['name'],
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
            tooltip: 'Toggle Theme',
            onPressed: onToggleTheme,
          ),
        ],
      ),
    );
  }
}

// ======================= BODY LAYOUTS ==========================
class _DesktopBody extends StatelessWidget {
  final Map profile;
  final List<String> skills;
  final List education;
  final List experience;
  final List projects;
  _DesktopBody({
    required this.profile,
    required this.skills,
    required this.education,
    required this.experience,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProfileCard(profile: profile),
                  SizedBox(height: 18),
                  _SectionTitle(title: 'Projects'),
                  _ProjectsGrid(projects: projects, crossAxis: 3),
                  SizedBox(height: 18),
                  _SectionTitle(title: 'Experience'),
                  ...experience.map((e) => _ExperienceTile(item: e)).toList(),
                ],
              ),
            ),
          ),
          SizedBox(width: 24),
          Flexible(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AboutCard(profile: profile),
                  SizedBox(height: 16),
                  _SectionTitle(title: 'Skills'),
                  _SkillsChipList(skills: skills),
                  SizedBox(height: 16),
                  _SectionTitle(title: 'Education'),
                  ...education.map((e) => _EducationTile(item: e)).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabletBody extends StatelessWidget {
  final Map profile;
  final List<String> skills;
  final List education;
  final List experience;
  final List projects;
  _TabletBody({
    required this.profile,
    required this.skills,
    required this.education,
    required this.experience,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProfileCard(profile: profile),
            SizedBox(height: 18),
            _AboutCard(profile: profile),
            SizedBox(height: 18),
            _SectionTitle(title: 'Skills'),
            _SkillsChipList(skills: skills),
            SizedBox(height: 18),
            _SectionTitle(title: 'Projects'),
            _ProjectsGrid(projects: projects, crossAxis: 2),
            SizedBox(height: 18),
            _SectionTitle(title: 'Experience'),
            ...experience.map((e) => _ExperienceTile(item: e)).toList(),
            SizedBox(height: 18),
            _SectionTitle(title: 'Education'),
            ...education.map((e) => _EducationTile(item: e)).toList(),
          ],
        ),
      ),
    );
  }
}

class _MobileBody extends StatelessWidget {
  final Map profile;
  final List<String> skills;
  final List education;
  final List experience;
  final List projects;
  _MobileBody({
    required this.profile,
    required this.skills,
    required this.education,
    required this.experience,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProfileCard(profile: profile),
            SizedBox(height: 12),
            _AboutCard(profile: profile),
            SizedBox(height: 12),
            _SectionTitle(title: 'Skills'),
            _SkillsChipList(skills: skills),
            SizedBox(height: 12),
            _SectionTitle(title: 'Projects'),
            _ProjectsListMobile(projects: projects),
            SizedBox(height: 12),
            _SectionTitle(title: 'Experience'),
            ...experience.map((e) => _ExperienceTile(item: e)).toList(),
            SizedBox(height: 12),
            _SectionTitle(title: 'Education'),
            ...education.map((e) => _EducationTile(item: e)).toList(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// ======================= COMMON COMPONENTS ==========================
class _ProfileCard extends StatelessWidget {
  final Map profile;
  _ProfileCard({required this.profile});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color;
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: theme.brightness == Brightness.light
            ? [BoxShadow(color: Colors.black12, blurRadius: 8)]
            : [],
      ),
      child: Row(
        children: [
          Hero(
            tag: 'profile-pic',
            child: CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(
                'https://picsum.photos/seed/profile_main/100',
              ),
            ),
          ),
          SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile['name'],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  profile['title'],
                  style: TextStyle(fontSize: 16, color: Colors.indigoAccent),
                ),
                SizedBox(height: 12),
                Text(
                  profile['summary'],
                  style: TextStyle(fontSize: 14, height: 1.4, color: textColor),
                ),
                SizedBox(height: 12),
                // Inside _ProfileCard build method:

                // The fix is here: Wrap the Text in Expanded
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.indigo),
                    SizedBox(width: 6),
                    Expanded(
                      // <-- The Expanded widget correctly provides constrained width
                      child: SizedBox(
                        // Give the Marquee a defined height (necessary for the marquee widget)
                        height: 20.0,
                        child: Marquee(
                          // 1. PASS THE TEXT DIRECTLY to the 'text' property
                          text: profile['location'],
                          style: TextStyle(color: textColor),

                          // 2. Remove the nested 'Text' widget and its 'overflow' property

                          // --- Marquee Customization ---
                          scrollAxis: Axis.horizontal,
                          velocity: 30.0, // Adjust speed as needed
                          blankSpace: 20.0,
                          pauseAfterRound: Duration(seconds: 1),
                          showFadingOnlyWhenScrolling: true,
                          fadingEdgeStartFraction: 0.05,
                          fadingEdgeEndFraction: 0.05,
                        ),
                      ),
                    ),
                    Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.mail),
                      label: Text('Contact'),
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
}

class _AboutCard extends StatelessWidget {
  final Map profile;
  _AboutCard({required this.profile});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color;
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? Colors.indigo[50]
            : theme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            profile['summary'],
            style: TextStyle(height: 1.4, color: textColor),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.email, size: 16, color: Colors.indigo),
              SizedBox(width: 8),
              Text(profile['email'], style: TextStyle(color: textColor)),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.phone, size: 16, color: Colors.indigo),
              SizedBox(width: 8),
              Text(profile['phone'], style: TextStyle(color: textColor)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  _SectionTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).textTheme.bodyLarge?.color;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class _ProjectsGrid extends StatelessWidget {
  final List projects;
  final int crossAxis;
  _ProjectsGrid({required this.projects, this.crossAxis = 2});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxis,
        mainAxisExtent: 220,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final p = projects[index];
        return _ProjectCard(item: p);
      },
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Map item;
  _ProjectCard({required this.item});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color;
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ), // Added margin for spacing in list
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: theme.brightness == Brightness.light
            ? [BoxShadow(color: Colors.black12, blurRadius: 8)]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🛑 FIX: Replaced Expanded with SizedBox
          // Expanded was causing an unbounded height error inside a non-Expanded Column.
          SizedBox(
            height:
                120, // Set a reasonable fixed height for the image on mobile
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                item['image'],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  item['desc'],
                  style: TextStyle(fontSize: 12, height: 1.3, color: textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// NOTE: You should also update _ProjectsListMobile to ensure it provides margin between cards
class _ProjectsListMobile extends StatelessWidget {
  final List projects;
  _ProjectsListMobile({required this.projects});
  @override
  Widget build(BuildContext context) {
    // The margin is now inside _ProjectCard, so this simply returns the list.
    return Column(
      children: projects.map((e) => _ProjectCard(item: e)).toList(),
    );
  }
}

class _ExperienceTile extends StatelessWidget {
  final Map item;
  _ExperienceTile({required this.item});
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).textTheme.bodyMedium?.color;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: Theme.of(context).brightness == Brightness.light
            ? [BoxShadow(color: Colors.black12, blurRadius: 6)]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['role'],
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          Text(
            item['company'],
            style: TextStyle(color: Colors.indigoAccent, fontSize: 13),
          ),
          SizedBox(height: 4),
          Text(item['duration'], style: TextStyle(fontSize: 12, color: color)),
          SizedBox(height: 6),
          ...item['bullets']
              .map<Widget>(
                (b) => Row(
                  children: [
                    Icon(Icons.check, color: Colors.indigo, size: 14),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        b,
                        style: TextStyle(fontSize: 12, color: color),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class _EducationTile extends StatelessWidget {
  final Map item;
  _EducationTile({required this.item});
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).textTheme.bodyMedium?.color;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: Theme.of(context).brightness == Brightness.light
            ? [BoxShadow(color: Colors.black12, blurRadius: 6)]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['degree'],
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          Text(item['institute'], style: TextStyle(color: Colors.indigoAccent)),
          Text(item['year'], style: TextStyle(fontSize: 12, color: color)),
          Text(
            'Grade: ${item['grade']}',
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      ),
    );
  }
}

class _SkillsChipList extends StatelessWidget {
  final List<String> skills;
  _SkillsChipList({required this.skills});
  @override
  Widget build(BuildContext context) {
    final chipTheme = Theme.of(context).chipTheme;
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: skills
          .map(
            (s) => Chip(
              label: Text(s, style: chipTheme.labelStyle),
              backgroundColor: chipTheme.backgroundColor,
            ),
          )
          .toList(),
    );
  }
}

// ======================= FOOTER ==========================
// Inside _Footer build method:

class _Footer extends StatelessWidget {
  final Map profile;
  _Footer({required this.profile});

  @override
  Widget build(BuildContext context) {
    // 1. Combine all the data into a single, well-spaced string
    final String footerText =
        '${profile['name']} • ${profile['location']}   |   Email: ${profile['email']}   |   Connect Today!';

    // 2. The Marquee widget must have defined dimensions (like a height).
    return Container(
      width: double.infinity,
      // Provide a fixed height for the Marquee effect
      height: 48.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.indigo[900],

      child: Center(
        // Center the Marquee vertically
        // Wrap the Marquee in an Expanded or SizedBox to constrain its width
        child: SizedBox(
          // Ensure it takes the full width available
          width: MediaQuery.of(context).size.width,
          child: Marquee(
            text: footerText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            // --- Marquee Customization ---
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            // Gap between repetitions of the text
            blankSpace: 40.0,
            // Scroll speed (pixels per second)
            velocity: 50.0,
            // Duration to pause after a full scroll round before repeating
            pauseAfterRound: Duration(seconds: 1),
            // Show a fading edge to indicate scrolling is happening
            showFadingOnlyWhenScrolling: true,
            fadingEdgeStartFraction: 0.1,
            fadingEdgeEndFraction: 0.1,
            // Makes it loop continuously
            numberOfRounds: null,
          ),
        ),
      ),
    );
  }
}
