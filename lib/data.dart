// Portfolio content – single source of truth
class PortfolioData {
  PortfolioData._();

  static const String name = 'Srivishnu Thiriveedhi';
  static const String title = 'Flutter Developer';
  static const String email = 'srivishnuthiriveedhi@gmail.com';
  static const String phone = '+91 8106824579';
  static const String location = 'Nellore, Andhra Pradesh';
  static const String github = 'https://github.com/srivishnu-thiriveedhi';
  static const String linkedin =
      'https://linkedin.com/in/srivishnu-thiriveedhi';

  static const String summary =
      'MCA graduate with 17+ months of hands-on Flutter development experience. '
      'Specializing in scalable mobile applications, REST API integration, Firebase, '
      'and crafting pixel-perfect, high-performance UIs that delight users. '
      'Passionate about AI integrations and clean architecture.';

  static const List<String> taglines = [
    'Building scalable, high-performance mobile apps',
    'Flutter Developer | 17 months of experience',
    'REST APIs  •  Firebase  •  AI Integration',
    'Turning ideas into beautiful mobile experiences',
  ];

  // ── Skills ────────────────────────────────────────────────────────────────
  static const List<Map<String, dynamic>> skills = [
    {
      'name': 'Flutter & Dart',
      'icon': '🦋',
      'level': 0.88,
      'colorHex': 0xFF00BCD4,
    },
    {
      'name': 'REST APIs (Dio)',
      'icon': '🌐',
      'level': 0.82,
      'colorHex': 0xFF26C6DA,
    },
    {'name': 'Firebase', 'icon': '🔥', 'level': 0.76, 'colorHex': 0xFFFF7043},
    {
      'name': 'UI/UX Design',
      'icon': '🎨',
      'level': 0.80,
      'colorHex': 0xFF7C4DFF,
    },
    {
      'name': 'State Management',
      'icon': '⚡',
      'level': 0.78,
      'colorHex': 0xFFFFB300,
    },
    {
      'name': 'Performance Optim.',
      'icon': '🚀',
      'level': 0.72,
      'colorHex': 0xFF4CAF50,
    },
    {
      'name': 'Git & GitHub',
      'icon': '🔀',
      'level': 0.85,
      'colorHex': 0xFF2196F3,
    },
    {
      'name': 'AI Integration',
      'icon': '🤖',
      'level': 0.70,
      'colorHex': 0xFFE91E63,
    },
  ];

  // ── Experience ────────────────────────────────────────────────────────────
  static const List<Map<String, dynamic>> experience = [
    {
      'role': 'Junior Flutter Developer',
      'company': 'Raslesarm Private IT Limited',
      'duration': 'Oct 2024 – March 2026',
      // 'period':   '6 months',
      'bullets': [
        'Integrated AI services and chatbot features into production mobile apps.',
        'Implemented real-time Maps & GPS location tracking with Google Maps API.',
        'Developed scalable apps following MVVM architecture and GetX state management.',
        'Built and consumed REST APIs using Dio; maintained full-stack data flow.',
        'Collaborated with design & backend teams for end-to-end feature delivery.',
      ],
    },
  ];

  // ── Projects ──────────────────────────────────────────────────────────────
  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'E-Commerce App',
      'desc':
          'Full-featured shopping app with product catalog, smart cart, '
          'secure checkout flow, and real-time order tracking.',
      'image':
          'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=600&q=80',
      'tags': ['Flutter', 'REST API', 'Provider', 'Firebase'],
      'accentHex': 0xFF00BCD4,
    },
    {
      'title': 'Activity Analysis Tracker',
      'desc':
          'Analytics dashboard tracking daily fitness metrics with interactive '
          'charts, step counters, and personalized health insights.',
      'image':
          'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=600&q=80',
      'tags': ['Flutter', 'Charts', 'SQLite', 'Health API'],
      'accentHex': 0xFF7C4DFF,
    },
    {
      'title': 'Location Tracker App',
      'desc':
          'Real-time GPS tracking with live map view, geofencing, '
          'route history, and secure live location sharing.',
      'image':
          'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?w=600&q=80',
      'tags': ['Flutter', 'Google Maps', 'Geolocator', 'Firebase'],
      'accentHex': 0xFF4CAF50,
    },
    {
      'title': 'AI Trainer Role Play App',
      'desc':
          'Claude AI-powered trainer with dynamic role-play scenarios for '
          'interactive skill development and conversational learning.',
      'image':
          'https://images.unsplash.com/photo-1677442135703-1787eea5ce01?w=600&q=80',
      'tags': ['Flutter', 'Claude AI', 'REST API', 'GetX'],
      'accentHex': 0xFFE91E63,
    },
  ];

  // ── Additional Skills ─────────────────────────────────────────────────────
  static const List<Map<String, String>> additionalSkills = [
    {'name': 'Claude AI Tools', 'icon': '🤖'},
    {'name': 'Canva Design', 'icon': '🎨'},
    {'name': 'MVVM Pattern', 'icon': '🏗️'},
    {'name': 'Figma Basics', 'icon': '✏️'},
    {'name': 'VS Code', 'icon': '💻'},
    {'name': 'Productivity Tools', 'icon': '⚙️'},
  ];

  // ── Education ─────────────────────────────────────────────────────────────
  static const List<Map<String, String>> education = [
    {
      'degree': 'Master of Computer Applications (MCA)',
      'institute': 'JNTUA University',
      'year': '2022 – 2024',
      'grade': '89%',
    },
    {
      'degree': 'B.Com (Computer Applications)',
      'institute': 'Vikrama Simhapuri University',
      'year': '2020 – 2022',
      'grade': '80%',
    },
  ];
}
//added flutter web