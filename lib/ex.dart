// // Srivishnu Portfolio - Flutter Web
// // Single-file demo app (main.dart)
// // Instructions:
// // 1) Create a new Flutter project (stable channel) with `flutter create my_portfolio`.
// // 2) Replace lib/main.dart with the contents of this file.
// // 3) In pubspec.yaml, ensure SDK >=2.18 and add `flutter_web_plugins` if needed. No extra packages required.
// // 4) Run with `flutter run -d chrome` or `flutter build web` then host `build/web`.
// //
// // Notes:
// // - Uses network placeholder images from picsum.photos (dummy images).
// // - Responsive layout for Mobile / Tablet / Desktop.
// // - Includes animations and simple navigation.
// // - Replace text and images with your real content as needed.

// import 'dart:math';

// import 'package:flutter/material.dart';

// void main() {
//   runApp(PortfolioApp());
// }

// class PortfolioApp extends StatefulWidget {
//   @override
//   State<PortfolioApp> createState() => _PortfolioAppState();
// }

// class _PortfolioAppState extends State<PortfolioApp> {
//   ThemeMode _themeMode = ThemeMode.light;

//   void _toggleTheme() {
//     setState(() {
//       _themeMode = _themeMode == ThemeMode.light
//           ? ThemeMode.dark
//           : ThemeMode.light;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Thiriveedhi Srivishnu - Portfolio',
//       themeMode: _themeMode,
//       theme: ThemeData.light().copyWith(
//         primaryColor: Colors.indigo,
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       darkTheme: ThemeData.dark().copyWith(
//         primaryColor: Colors.indigo,
//         scaffoldBackgroundColor: Colors.black,
//       ),
//       home: PortfolioHome(onToggleTheme: _toggleTheme, themeMode: _themeMode),
//     );
//   }
// }

// class PortfolioHome extends StatefulWidget {
//   final VoidCallback onToggleTheme;
//   final ThemeMode themeMode;
//   PortfolioHome({required this.onToggleTheme, required this.themeMode});

//   @override
//   _PortfolioHomeState createState() => _PortfolioHomeState();
// }

// class _PortfolioHomeState extends State<PortfolioHome>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 30),
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   final profile = {
//     'name': 'Thiriveedhi Srivishnu',
//     'title': 'Flutter Developer',
//     'location': 'Nellore, Andhra Pradesh',
//     'email': 'srivishnuthiriveedhi@gmail.com',
//     'phone': '+91 8106824579',
//     'summary':
//         'Graduating with a Master of Computer Applications (MCA). Strong foundation in programming, Flutter app development, REST APIs, and responsive UI design. Passionate about creating efficient and beautiful applications.',
//   };

//   final skills = [
//     'Flutter & Dart',
//     'REST API (Dio)',
//     'Provider / GetX',
//     'MVVM Pattern',
//     'Git & GitHub',
//     'Firebase',
//     'Responsive UI',
//     'AI Bot Integration',
//   ];

//   final education = [
//     {
//       'degree': 'MCA',
//       'institute': 'JNTUA University',
//       'year': '2022–2024',
//       'grade': '89%',
//     },
//     {
//       'degree': 'B.Com (Computer Applications)',
//       'institute': 'Vikrama Simhapuri University',
//       'year': '2020–2022',
//       'grade': '80%',
//     },
//   ];

//   final experience = [
//     {
//       'role': 'Junior Flutter Developer',
//       'company': 'Rsalesarm IT Company',
//       'duration': 'Oct 2024 – Present',
//       'bullets': [
//         'Developed and maintained mobile and web apps using Flutter.',
//         'Integrated REST APIs and managed app state efficiently.',
//         'Collaborated with UI/UX and backend teams to deliver end-to-end modules.',
//       ],
//     },
//   ];

//   final projects = List.generate(6, (i) {
//     return {
//       'title': 'Project ${i + 1}',
//       'desc':
//           'A short project overview focusing on Flutter, responsive layout, and animations.',
//       'image': 'https://picsum.photos/seed/portfolio${i + 1}/800/600',
//     };
//   });

//   @override
//   Widget build(BuildContext context) {
//     final brightness = Theme.of(context).brightness;

//     return Scaffold(
//       body: Stack(
//         children: [
//           AnimatedBuilder(
//             animation: _controller,
//             builder: (context, child) {
//               return CustomPaint(
//                 size: MediaQuery.of(context).size,
//                 painter: StarfieldPainter(
//                   _controller.value,
//                   isDark: brightness == Brightness.dark,
//                 ),
//               );
//             },
//           ),
//           SafeArea(
//             child: Column(
//               children: [
//                 _TopNav(
//                   profile: profile,
//                   onToggleTheme: widget.onToggleTheme,
//                   themeMode: widget.themeMode,
//                 ),
//                 Expanded(
//                   child: LayoutBuilder(
//                     builder: (context, constraints) {
//                       if (constraints.maxWidth >= 1100) {
//                         return _DesktopBody(
//                           profile: profile,
//                           skills: skills,
//                           education: education,
//                           experience: experience,
//                           projects: projects,
//                         );
//                       } else if (constraints.maxWidth >= 700) {
//                         return _TabletBody(
//                           profile: profile,
//                           skills: skills,
//                           education: education,
//                           experience: experience,
//                           projects: projects,
//                         );
//                       } else {
//                         return _MobileBody(
//                           profile: profile,
//                           skills: skills,
//                           education: education,
//                           experience: experience,
//                           projects: projects,
//                         );
//                       }
//                     },
//                   ),
//                 ),
//                 _Footer(profile: profile),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class StarfieldPainter extends CustomPainter {
//   final double progress;
//   final bool isDark;
//   final Random _random = Random();

//   StarfieldPainter(this.progress, {required this.isDark});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint();
//     final bg = isDark ? Colors.black : Colors.white;
//     final starColor = isDark ? Colors.white : Colors.blueGrey;

//     paint.color = bg;
//     canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

//     for (int i = 0; i < 150; i++) {
//       final x = (i * 40 + progress * size.width * 0.8) % size.width;
//       final y = (i * 70 + progress * size.height * 1.2) % size.height;
//       paint.color = starColor.withOpacity(_random.nextDouble() * 0.8 + 0.2);
//       canvas.drawCircle(Offset(x, y), _random.nextDouble() * 2 + 0.5, paint);
//     }

//     final cometPaint = Paint()
//       ..shader = LinearGradient(
//         colors: [Colors.cyanAccent.withOpacity(0.9), Colors.transparent],
//         begin: Alignment.centerLeft,
//         end: Alignment.centerRight,
//       ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

//     for (int i = 0; i < 4; i++) {
//       final offsetX = (progress * size.width * (0.4 + i * 0.2)) % size.width;
//       final offsetY = (size.height / 5 * i + progress * 250) % size.height;
//       canvas.drawLine(
//         Offset(offsetX, offsetY),
//         Offset(offsetX - 100, offsetY - 40),
//         cometPaint..strokeWidth = 2,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }

// class _TopNav extends StatelessWidget {
//   final Map profile;
//   final VoidCallback onToggleTheme;
//   final ThemeMode themeMode;

//   const _TopNav({
//     required this.profile,
//     required this.onToggleTheme,
//     required this.themeMode,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//       child: Row(
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: NetworkImage(
//                   'https://picsum.photos/seed/profile/100',
//                 ),
//                 radius: 20,
//               ),
//               SizedBox(width: 10),
//               Text(
//                 profile['name'],
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           Spacer(),
//           IconButton(
//             icon: Icon(
//               themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
//             ),
//             tooltip: 'Toggle Theme',
//             onPressed: onToggleTheme,
//           ),
//         ],
//       ),
//     );
//   }
// }

// bool _isSmallScreen(BuildContext context) =>
//     MediaQuery.of(context).size.width < 700;

// Widget _buildDrawer() {
//   return Drawer(
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: [
//         DrawerHeader(
//           decoration: BoxDecoration(color: Colors.indigo),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               CircleAvatar(
//                 radius: 28,
//                 backgroundImage: NetworkImage(
//                   'https://picsum.photos/seed/profile/200',
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Thiriveedhi Srivishnu',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 'Flutter Developer',
//                 style: TextStyle(color: Colors.white70),
//               ),
//             ],
//           ),
//         ),
//         ListTile(leading: Icon(Icons.person), title: Text('About')),
//         ListTile(leading: Icon(Icons.build), title: Text('Skills')),
//         ListTile(leading: Icon(Icons.work), title: Text('Experience')),
//         ListTile(leading: Icon(Icons.code), title: Text('Projects')),
//         ListTile(leading: Icon(Icons.mail), title: Text('Contact')),
//       ],
//     ),
//   );
// }

// class _NavButton extends StatelessWidget {
//   final String label;
//   _NavButton({required this.label});
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//       child: TextButton(
//         onPressed: () {},
//         child: Text(label, style: TextStyle(color: Colors.black87)),
//       ),
//     );
//   }
// }

// class _DesktopBody extends StatelessWidget {
//   final Map profile;
//   final List<String> skills;
//   final List education;
//   final List experience;
//   final List projects;
//   _DesktopBody({
//     required this.profile,
//     required this.skills,
//     required this.education,
//     required this.experience,
//     required this.projects,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Flexible(
//             flex: 3,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _ProfileCard(profile: profile),
//                   SizedBox(height: 18),
//                   _SectionTitle(title: 'Projects'),
//                   _ProjectsGrid(projects: projects, crossAxis: 3),
//                   SizedBox(height: 18),
//                   _SectionTitle(title: 'Experience'),
//                   ...experience.map((e) => _ExperienceTile(item: e)).toList(),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(width: 24),
//           Flexible(
//             flex: 1,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _AboutCard(profile: profile),
//                   SizedBox(height: 16),
//                   _SectionTitle(title: 'Skills'),
//                   _SkillsChipList(skills: skills),
//                   SizedBox(height: 16),
//                   _SectionTitle(title: 'Education'),
//                   ...education.map((e) => _EducationTile(item: e)).toList(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _TabletBody extends StatelessWidget {
//   final Map profile;
//   final List<String> skills;
//   final List education;
//   final List experience;
//   final List projects;
//   _TabletBody({
//     required this.profile,
//     required this.skills,
//     required this.education,
//     required this.experience,
//     required this.projects,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _ProfileCard(profile: profile),
//             SizedBox(height: 18),
//             _AboutCard(profile: profile),
//             SizedBox(height: 18),
//             _SectionTitle(title: 'Skills'),
//             _SkillsChipList(skills: skills),
//             SizedBox(height: 18),
//             _SectionTitle(title: 'Projects'),
//             _ProjectsGrid(projects: projects, crossAxis: 2),
//             SizedBox(height: 18),
//             _SectionTitle(title: 'Experience'),
//             ...experience.map((e) => _ExperienceTile(item: e)).toList(),
//             SizedBox(height: 18),
//             _SectionTitle(title: 'Education'),
//             ...education.map((e) => _EducationTile(item: e)).toList(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _MobileBody extends StatelessWidget {
//   final Map profile;
//   final List<String> skills;
//   final List education;
//   final List experience;
//   final List projects;
//   _MobileBody({
//     required this.profile,
//     required this.skills,
//     required this.education,
//     required this.experience,
//     required this.projects,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _ProfileCard(profile: profile),
//             SizedBox(height: 12),
//             _AboutCard(profile: profile),
//             SizedBox(height: 12),
//             _SectionTitle(title: 'Skills'),
//             _SkillsChipList(skills: skills),
//             SizedBox(height: 12),
//             _SectionTitle(title: 'Projects'),
//             _ProjectsListMobile(projects: projects),
//             SizedBox(height: 12),
//             _SectionTitle(title: 'Experience'),
//             ...experience.map((e) => _ExperienceTile(item: e)).toList(),
//             SizedBox(height: 12),
//             _SectionTitle(title: 'Education'),
//             ...education.map((e) => _EducationTile(item: e)).toList(),
//             SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ProfileCard extends StatelessWidget {
//   final Map profile;
//   _ProfileCard({required this.profile});
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 500),
//       padding: EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
//       ),
//       child: Row(
//         children: [
//           Hero(
//             tag: 'profile-pic',
//             child: CircleAvatar(
//               radius: 52,
//               backgroundImage: NetworkImage(
//                 'https://picsum.photos/seed/profile_main/400',
//               ),
//             ),
//           ),
//           SizedBox(width: 18),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   profile['name'],
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 6),
//                 Text(
//                   profile['title'],
//                   style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                 ),
//                 SizedBox(height: 12),
//                 Text(
//                   profile['summary'],
//                   style: TextStyle(fontSize: 14, height: 1.4),
//                 ),
//                 SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Icon(Icons.location_on, size: 16),
//                     SizedBox(width: 6),
//                     Text(profile['location']),
//                     Spacer(),
//                     ElevatedButton.icon(
//                       onPressed: () {},
//                       icon: Icon(Icons.mail),
//                       label: Text('Contact'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _AboutCard extends StatelessWidget {
//   final Map profile;
//   _AboutCard({required this.profile});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.indigo[50],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'About',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           Text(profile['summary'], style: TextStyle(height: 1.4)),
//           SizedBox(height: 12),
//           Row(
//             children: [
//               Icon(Icons.email, size: 16),
//               SizedBox(width: 8),
//               Text(profile['email']),
//             ],
//           ),
//           SizedBox(height: 6),
//           Row(
//             children: [
//               Icon(Icons.phone, size: 16),
//               SizedBox(width: 8),
//               Text(profile['phone']),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SectionTitle extends StatelessWidget {
//   final String title;
//   _SectionTitle({required this.title});
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Text(
//         title,
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

// class _ProjectsGrid extends StatelessWidget {
//   final List projects;
//   final int crossAxis;
//   _ProjectsGrid({required this.projects, this.crossAxis = 2});
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: crossAxis,
//         mainAxisExtent: 220,
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//       ),
//       itemCount: projects.length,
//       itemBuilder: (context, index) {
//         final p = projects[index];
//         return _ProjectCard(item: p);
//       },
//     );
//   }
// }

// class _ProjectCard extends StatefulWidget {
//   final Map item;
//   _ProjectCard({required this.item});
//   @override
//   __ProjectCardState createState() => __ProjectCardState();
// }

// class __ProjectCardState extends State<_ProjectCard>
//     with SingleTickerProviderStateMixin {
//   double _angle = 0.0;
//   late AnimationController _lift;

//   @override
//   void initState() {
//     super.initState();
//     _lift = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//     );
//   }

//   @override
//   void dispose() {
//     _lift.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => _lift.forward(),
//       onTapUp: (_) => _lift.reverse(),
//       onTapCancel: () => _lift.reverse(),
//       child: AnimatedBuilder(
//         animation: _lift,
//         builder: (context, child) {
//           final lift = _lift.value * -6;
//           return Transform.translate(offset: Offset(0, lift), child: child);
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//                   child: Image.network(
//                     widget.item['image'],
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.item['title'],
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 6),
//                     Text(
//                       widget.item['desc'],
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ProjectsListMobile extends StatelessWidget {
//   final List projects;
//   _ProjectsListMobile({required this.projects});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: projects.map((p) {
//         return Container(
//           margin: EdgeInsets.only(bottom: 12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
//           ),
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.horizontal(
//                   left: Radius.circular(10),
//                 ),
//                 child: Image.network(
//                   p['image'],
//                   width: 120,
//                   height: 90,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               SizedBox(width: 10),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         p['title'],
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 6),
//                       Text(
//                         p['desc'],
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

// class _ExperienceTile extends StatelessWidget {
//   final Map item;
//   _ExperienceTile({required this.item});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   '${item['role']} — ${item['company']}',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Text(item['duration'], style: TextStyle(color: Colors.grey[700])),
//             ],
//           ),
//           SizedBox(height: 8),
//           ...List<Widget>.from(
//             (item['bullets'] as List).map(
//               (b) => Row(
//                 children: [
//                   Icon(Icons.check, size: 14, color: Colors.green),
//                   SizedBox(width: 8),
//                   Expanded(child: Text(b)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _EducationTile extends StatelessWidget {
//   final Map item;
//   _EducationTile({required this.item});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 6),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.school),
//           SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               '${item['degree']} — ${item['institute']} (${item['year']})',
//             ),
//           ),
//           Text(item['grade'], style: TextStyle(fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// }

// class _SkillsChipList extends StatelessWidget {
//   final List<String> skills;
//   _SkillsChipList({required this.skills});
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 8,
//       runSpacing: 8,
//       children: skills.map((s) => Chip(label: Text(s))).toList(),
//     );
//   }
// }

// class _Footer extends StatelessWidget {
//   final Map profile;
//   _Footer({required this.profile});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(color: Colors.indigo[900]),
//       child: Row(
//         children: [
//           Text(
//             '${profile['name']} • ${profile['location']}',
//             style: TextStyle(color: Colors.white),
//           ),
//           Spacer(),
//           Row(
//             children: [
//               Icon(Icons.email, color: Colors.white),
//               SizedBox(width: 8),
//               Text(profile['email'], style: TextStyle(color: Colors.white)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
// Srivishnu Portfolio - Flutter Web (Full Updated Version)
// ✅ Light & Dark themes fixed for readability
